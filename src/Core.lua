--!strict
-- Purpose: Build typed Jev requests and map finite answers back to exact selected Instances.
local MODEL = "jev-1.13.0"
local Core = { MODEL = MODEL }

export type Candidate = { id: string, name: string, className: string, path: string }
export type Issue = { id: string, label: string, instructions: string, markAbove: number }

function Core.cleanCandidates(raw: { Candidate }): { Candidate }
	local result = {}
	local seen = {}
	for _, candidate in raw do
		if #result >= 255 then break end
		if candidate.name ~= "" and not seen[candidate.path] then
			seen[candidate.path] = true
			table.insert(result, candidate)
		end
	end
	if #result == 0 then error("Select at least one Instance", 2) end
	return result
end

function Core.detectionRequest(candidates: { Candidate }, pack)
	local questions = {}
	for _, issue: Issue in pack.issues do
		questions[issue.id] = { type = "noul", instructions = issue.instructions }
	end
	return { model = MODEL, state = { selectedInstances = candidates }, questions = questions }
end

function Core.issuesToLocate(response, pack): { Issue }
	local issues = {}
	for _, issue: Issue in pack.issues do
		local answer = response.answers[issue.id]
		if answer and answer.type == "noul" and answer.noul >= issue.markAbove then table.insert(issues, issue) end
	end
	return issues
end

function Core.locationRequest(candidates: { Candidate }, issues: { Issue })
	local criteria = {}
	for _, candidate in candidates do criteria[candidate.id] = { name = candidate.name, className = candidate.className, path = candidate.path } end
	local questions = {}
	for _, issue in issues do
		questions[issue.id] = { type = "choice", instructions = "Which exact selected Instance most strongly demonstrates this issue? " .. issue.instructions, criteria = criteria }
	end
	return { model = MODEL, state = { selectedInstances = candidates }, questions = questions }
end

function Core.validateResponse(response, questions)
	if type(response) ~= "table" or response.model ~= MODEL or type(response.answers) ~= "table" then error("Invalid Jev response envelope", 2) end
	if type(response.usage) ~= "table" or type(response.usage.input_tokens) ~= "number" then error("Invalid Jev usage", 2) end
	for id, question in questions do
		local answer = response.answers[id]
		if type(answer) ~= "table" or answer.type ~= question.type then error("Missing or mismatched answer: " .. id, 2) end
		if answer.type == "noul" and (type(answer.noul) ~= "number" or answer.noul < 0 or answer.noul > 1) then error("Invalid noul: " .. id, 2) end
		if answer.type == "choice" and question.criteria[answer.choice] == nil then error("Invalid choice: " .. id, 2) end
	end
	return response
end

function Core.findings(candidates: { Candidate }, issues: { Issue }, response)
	local byId = {}
	for _, candidate in candidates do byId[candidate.id] = candidate end
	local result = {}
	for _, issue in issues do
		local answer = response.answers[issue.id]
		local candidate = answer and answer.type == "choice" and byId[answer.choice] or nil
		if candidate then table.insert(result, { issue = issue, candidate = candidate }) end
	end
	return result
end

return Core

