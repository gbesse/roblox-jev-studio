--!strict
-- Purpose: Provide a dockable Studio UI that reviews and refocuses exact selected Instances.
local Selection = game:GetService("Selection")
local Core = require(script.Core)
local Client = require(script.Client)
local Pack = require(script.Pack)

local toolbar = plugin:CreateToolbar("Jev")
local toggle = toolbar:CreateButton("Selection Review", "Review exact selected Instances with Jev", "")
toggle.ClickableWhenViewportHidden = true
local widgetInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 360, 520, 280, 360)
local widget = plugin:CreateDockWidgetPluginGui("JevSelectionReview", widgetInfo)
widget.Title = "Jev Selection Review"

local layout = Instance.new("UIListLayout"); layout.Padding = UDim.new(0, 8); layout.Parent = widget
local padding = Instance.new("UIPadding"); padding.PaddingTop = UDim.new(0, 12); padding.PaddingLeft = UDim.new(0, 12); padding.PaddingRight = UDim.new(0, 12); padding.Parent = widget
local function element(className: string, height: number, text: string)
	local item: any = Instance.new(className); item.Size = UDim2.new(1, 0, 0, height); item.BackgroundColor3 = Color3.fromRGB(40, 40, 44); item.TextColor3 = Color3.fromRGB(240, 240, 240); item.Text = text; item.Parent = widget; return item
end
local intro = element("TextLabel", 52, "Finite review of selected Instance metadata.\nNo edits, no generated critique.") :: TextLabel; intro.TextWrapped = true
local key = element("TextBox", 36, "") :: TextBox; key.PlaceholderText = "TypeSafe API key (memory only)"; key.ClearTextOnFocus = false
local review = element("TextButton", 36, "Review selection") :: TextButton
local status = element("TextLabel", 40, "Select Instances to begin") :: TextLabel; status.TextWrapped = true
local results = Instance.new("ScrollingFrame"); results.Size = UDim2.new(1, 0, 1, -188); results.BackgroundTransparency = 1; results.AutomaticCanvasSize = Enum.AutomaticSize.Y; results.CanvasSize = UDim2.new(); results.Parent = widget
local resultsLayout = Instance.new("UIListLayout"); resultsLayout.Padding = UDim.new(0, 6); resultsLayout.Parent = results

local function clearResults() for _, child in results:GetChildren() do if child:IsA("TextButton") then child:Destroy() end end end
local function candidates()
	local raw: { any }, instances: { [string]: Instance } = {}, {}
	for index, instance in Selection:Get() do
		if index > 255 then break end
		local id = "instance_" .. index
		table.insert(raw, { id = id, name = instance.Name, className = instance.ClassName, path = instance:GetFullName() }); instances[id] = instance
	end
	return Core.cleanCandidates(raw), instances
end

review.Activated:Connect(function()
	review.Active = false; clearResults()
	local ok, message = pcall(function()
		local selected, instances = candidates(); status.Text = "Checking " .. #selected .. " Instances…"
		local firstRequest = Core.detectionRequest(selected, Pack); local first = Client.call(firstRequest, key.Text); local issues = Core.issuesToLocate(first, Pack)
		if #issues == 0 then status.Text = "No issue crossed the declared thresholds"; return end
		status.Text = "Locating exact Instances…"; local secondRequest = Core.locationRequest(selected, issues); local second = Client.call(secondRequest, key.Text); local findings = Core.findings(selected, issues, second)
		for _, finding in findings do
			local button = Instance.new("TextButton"); button.Size = UDim2.new(1, 0, 0, 42); button.Text = finding.issue.label .. ": " .. finding.candidate.name; button.TextWrapped = true; button.Parent = results
			button.Activated:Connect(function() local target = instances[finding.candidate.id]; if target and target.Parent then Selection:Set({ target }) end end)
		end
		status.Text = tostring(#findings) .. " exact-Instance finding(s)"
	end)
	if not ok then status.Text = tostring(message) end
	review.Active = true
end)

toggle.Click:Connect(function() widget.Enabled = not widget.Enabled end)
widget:GetPropertyChangedSignal("Enabled"):Connect(function() toggle:SetActive(widget.Enabled) end)
