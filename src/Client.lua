--!strict
-- Purpose: Call the pinned Jev endpoint with bounded retry, permission-aware errors, and no persisted key.
local HttpService = game:GetService("HttpService")
local Core = require(script.Parent.Core)
local Client = {}
local ENDPOINT = "https://api.typesafe.ai/v1/systemone"

function Client.call(request, apiKey: string, endpoint: string?)
	if apiKey:match("^%s*$") then error("Enter a TypeSafe API key", 2) end
	if request.model ~= Core.MODEL then error("Model must remain pinned", 2) end
	local url = endpoint or ENDPOINT
	if not url:match("^https://") and not url:match("^http://127%.0%.0%.1:") and not url:match("^http://localhost:") then error("Endpoint requires HTTPS except on loopback", 2) end
	for attempt = 0, 2 do
		local ok, response = pcall(function()
			return HttpService:RequestAsync({ Url = url, Method = "POST", Headers = { ["Authorization"] = "Bearer " .. apiKey, ["Content-Type"] = "application/json" }, Body = HttpService:JSONEncode(request) })
		end)
		if ok and response.Success then return Core.validateResponse(HttpService:JSONDecode(response.Body), request.questions) end
		local status = ok and response.StatusCode or 0
		if (status == 429 or status == 529 or not ok) and attempt < 2 then task.wait(0.25 * 2 ^ attempt) else
			local detail = ok and tostring(response.StatusMessage) or tostring(response)
			error(("Jev request failed (%d): %s"):format(status, detail:gsub(apiKey, "[redacted]")), 2)
		end
	end
	error("Jev request failed", 2)
end

return Client

