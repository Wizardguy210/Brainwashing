local Library = {}

local CoreGui = game:GetService'CoreGui'
local HttpService = game:GetService'HttpService'
local TweenService = game:GetService'TweenService'
local UserInputService = game:GetService'UserInputService'

local newUDim2 = UDim2.new
local newInstance = Instance.new
local newTweenInfo = TweenInfo.new

local function Create(class, properties, parent)
	local object, children = type(class) == 'string' and newInstance(class) or class, {}
	for prop, value in next, properties do
		if type(prop) == 'number' and typeof(value) == 'Instance' then
			children[#children + 1] = value
			continue;
		end
		object[prop] = value
	end

	for i = 1, #children do children[i].Parent = object end
	if parent then object.Parent = parent end

	return object
end

local screenGui = Create('ScreenGui', {
	Name = HttpService:GenerateGUID(false):gsub('-', ''),
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, gethui and gethui())

if not gethui and syn.protect_gui then
	syn.protect_gui(screenGui)
	screenGui.Parent = CoreGui
end

Library.Flags = {}
Library.Objects = {}
Library.Connections = {}

Library.sliding = false
Library.screenGui = screenGui
Library.staticColors = {
	Border = Color3.fromRGB(60, 60, 60),
	BackgroundBorder = Color3.fromRGB(37, 37, 37),
	MainBackground = Color3.fromRGB(53, 53, 53),
	SecondaryBackground = Color3.fromRGB(64, 64, 64),
	HTextColor = Color3.fromRGB(200, 200, 200),
	TextColor = Color3.fromRGB(170, 170, 170),
	NTextColor = Color3.fromRGB(140, 140, 140),
	SelectedColor = Color3.fromRGB(71, 71, 71)
}

--Library._openFrameRegistry = {}

function Library:Unload()
	Library.screenGui:Destroy()
	Library.screenGui = nil

	for i = 1, #self.Connections do
		self.Connections[i]:Disconnect()
	end

	table.clear(self.Flags)
	table.clear(self.Objects)
	table.clear(self.Connections)
end

--# customs

local Signal = {}; do
	Signal.__index = Signal

	function Signal.new()
		return setmetatable({}, Signal)
	end

	function Signal:Connect(fn)
		local index = #self + 1
		self[index] = fn
		return {
			Disconnect = function()
				self[index] = nil
			end
		}
	end

	function Signal:Fire(...)
		for i = 1, #self do
			task.spawn(self[i], ...)
		end
	end
end

Library.Signal = Signal

--# common functions

function Library:Tween(object, time, style, direction, reverses, properties)
	local tween = TweenService:Create(object, newTweenInfo(
		time, Enum.EasingStyle[style], Enum.EasingDirection[direction], 0, reverses, 0
	), properties); tween:Play()

	return tween
end

function Library:GiveSignal(signal)
	self.Connections[#self.Connections + 1] = signal
end

function Library:MakeDraggable(frame)
	local startPosition, startInputPosition;
	local canDrag = false

	local function updateInput(inputObject)
		local delta = inputObject.Position - startInputPosition
		frame.Position = newUDim2(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end

	frame.InputBegan:Connect(function(inputObject, processed)
		if processed then return end

		if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
			startPosition = frame.Position
			startInputPosition = inputObject.Position
			canDrag = true

			local connection; connection = inputObject.Changed:Connect(function()
				if inputObject.UserInputState == Enum.UserInputState.End then
					canDrag = false
					connection:Disconnect()
				end
			end)
		end
	end)
	Library:GiveSignal(UserInputService.InputChanged:Connect(function(inputObject)
		if not Library.sliding and canDrag and inputObject.UserInputType == Enum.UserInputType.MouseMovement then
			--[[local mousePosition = UserInputService:GetMouseLocation()
			local mouseX, mouseY = mousePosition.X, mousePosition.Y

			print(Library._openFrameRegistry, #Library._openFrameRegistry)

			for i = 1, #Library._openFrameRegistry do
				local absolutePosition = Library._openFrameRegistry[i].AbsolutePosition
				local apX, apY = absolutePosition.X, absolutePosition.Y

				print(absolutePosition)
				print(mousePosition)

				if mouseX > apX and mouseY > apY and mouseX < (apX * 2) and mouseY < (apY * 2) then
					return
				end
			end]]

			updateInput(inputObject)
		end
	end))
end

function Library:OnHighlight(object, properties, defaultProperties)
	object.MouseEnter:Connect(function()
		Library:Tween(object, .3, 'Sine', 'Out', false, properties)
	end)
	object.MouseLeave:Connect(function()
		Library:Tween(object, .3, 'Sine', 'Out', false, defaultProperties)
	end)
end

--# main components

local components = {}
do
	function components:createComponentContainer(size)
		return Create('Frame', {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = size or newUDim2(1, 0, 0, 20)
		})
	end

	function components:applyDefaultHighlight(object)
		Library:OnHighlight(object,
			{
				TextColor3 = Library.staticColors.HTextColor,
				BorderColor3 = Library.staticColors.Border,
				BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			},
			{
				TextColor3 = Library.staticColors.TextColor,
				BorderColor3 = Library.staticColors.BackgroundBorder,
				BackgroundColor3 = Library.staticColors.MainBackground
			}
		)
	end

	local Box = {}; do
		Box.__index = Box

		function Box.new(self, properties)
			local box = setmetatable({
				title = properties.Text or 'Box',
				flag = properties.Flag or ('Flag' .. #Library.Flags + 1),
				callback = properties.Callback or function() end,
				Value = '',
				Changed = Signal.new()
			}, Box)

			local container = Create(components:createComponentContainer(), {
				Create('TextLabel', {
					Name = 'Label',
					BackgroundTransparency = 1,
					Position = newUDim2(0, 5, 0, 0),
					Size = newUDim2(0, 0, 1, 0),
					Font = Enum.Font.SourceSans,
					Text = box.title .. ': ',
					TextColor3 = Library.staticColors.TextColor,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextSize = 14
				})
			}, self.container)

			local textBox = Create('TextBox', {
				Name = 'Box',
				BackgroundColor3 = Library.staticColors.MainBackground,
				BorderSizePixel = 1,
				BorderColor3 = Library.staticColors.BackgroundBorder,
				Font = Enum.Font.SourceSans,
				Text = '',
				PlaceholderText = '...',
				PlaceholderColor3 = Library.staticColors.NTextColor,
				TextColor3 = Library.staticColors.TextColor,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextSize = 14,
				Size = newUDim2(1, -(5 + container.Label.TextBounds.X + 8), 1, -2),
				Position = newUDim2(0, (5 + container.Label.TextBounds.X + 2), 0, 1),
			}, container)

			textBox:GetPropertyChangedSignal'Text':Connect(function()
				Library.Flags[box.flag] = box.callback(textBox.Text) or textBox.Text
				box.Value = Library.Flags[box.flag]
			end)

			Library.Flags[box.flag] = box.Value
			box.container = container
			components:applyDefaultHighlight(textBox)

			return box
		end

		function Box:SetValue(text)
			self.Value = text
			if self.callback then
				self.callback(text)
			end
			self.Changed:Fire(text)
		end
	end

	local Button = {}; do
		Button.__index = Button

		local function createHighlight(parent)
			return Create('Frame', {
				Name = 'Highlight',
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(83, 89, 95),
				Size = newUDim2(1, 0, 1, 0)
			}, parent)
		end

		function Button.new(self, properties)
			local button = setmetatable({
				title = properties.Text or 'Button',
				callback = properties.Callback or function() end
			}, Button)

			local container = components:createComponentContainer()
			local textButton = Create('TextButton', {
				BackgroundColor3 = Library.staticColors.MainBackground,
				BorderSizePixel = 1,
				BorderColor3 = Library.staticColors.BackgroundBorder,
				Font = Enum.Font.SourceSans,
				Text = button.title,
				TextColor3 = Library.staticColors.TextColor,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextSize = 14,
				Position = newUDim2(0, 6, 0, 1),
				Size = newUDim2(1, -12, 1, -2),
				AutoButtonColor = false
			}, container)

			button.parent = self
			button.textButton = textButton

			button.container = container
			container.Parent = self.container

			components:applyDefaultHighlight(textButton)
			button.highlight = createHighlight(textButton)

			button:onClick()
			textButton.MouseButton1Click:Connect(button.callback)

			return button
		end

		function Button:Sub(properties)
			properties = properties or {}			

			local button = setmetatable({
				title = properties.Text or 'Sub Button',
				callback = properties.Callback or function() end
			}, Button)

			local textButton = self.container.TextButton
			textButton.Size = newUDim2(0.5, -8, 1, -2)
			textButton.Position = newUDim2(0, 6, 0, 1)

			local subButton = Create('TextButton', {
				BackgroundColor3 = Library.staticColors.MainBackground,
				BorderSizePixel = 1,
				BorderColor3 = Library.staticColors.BackgroundBorder,
				Font = Enum.Font.SourceSans,
				Text = button.title,
				TextColor3 = Library.staticColors.TextColor,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextSize = 14,
				Position = newUDim2(0.5, 2, 0, 1),
				Size = newUDim2(0.5, -8, 1, -2),
				AutoButtonColor = false
			}, self.container)

			self.sub = subButton

			button.textButton = subButton
			button.highlight = createHighlight(subButton)

			button:onClick()
			subButton.MouseButton1Click:Connect(button.callback)

			components:applyDefaultHighlight(subButton)

			return self.parent
		end

		function Button:onClick()
			local textButton = self.textButton
			local highlight = textButton.Highlight

			textButton.MouseButton1Down:Connect(function()
				if self.currentTween then self.currentTween:Cancel() self.currentTween = nil end
				highlight.BackgroundTransparency = .45
			end)
			textButton.MouseButton1Click:Connect(function()
				self.currentTween = Library:Tween(highlight, .25, 'Quad', 'Out', false, {
					BackgroundTransparency = 1
				})
			end)
		end
	end

	local Divider = {}; do
		function Divider.new(self)
			local divider = {
				container = Create(components:createComponentContainer(UDim2.new(1, 0, 0, 4)), {
					Create('Frame', {
						AnchorPoint = Vector2.new(0, .5),
						Size = UDim2.new(1, -12, 0, 1),
						Position = UDim2.new(0, 6, .5, 0),
						BackgroundColor3 = Library.staticColors.MainBackground,
						BorderSizePixel = 1,
						BorderColor3 = Library.staticColors.BackgroundBorder
					})
				}, self.container)
			}

			return divider
		end
	end

	local Toggle = {}; do
		Toggle.__index = Toggle

		function Toggle.new(self, properties)
			local toggle = setmetatable({
				title = properties.Text or 'Toggle',
				flag = properties.Flag or ('Flag' .. #Library.Flags + 1),
				callback = properties.Callback or function() end,
				Value = properties.Value,
				Changed = Signal.new()
			}, Toggle)

			local container = components:createComponentContainer()
			local toggleFrame = Create('Frame', {
				Name = 'Button',
				BackgroundColor3 = Color3.fromRGB(41, 41, 41),
				BorderSizePixel = 0,
				Position = newUDim2(0, 5, 0.5, -9),
				Size = newUDim2(0, 19, 0, 19),
				Create('Frame', {
					Name = 'Middle',
					BackgroundColor3 = Color3.fromRGB(41, 41, 41),
					BorderColor3 = Library.staticColors.MainBackground,
					BorderSizePixel = 2,
					Position = newUDim2(0, 3, 0, 3),
					Size = newUDim2(1, -6, 1, -6),
					Create('Frame', {
						Name = 'Point',
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = newUDim2(0.5, 0, 0.5, 0),
						BackgroundColor3 = Color3.fromRGB(83, 89, 95),
						Size = newUDim2(0, 0, 0, 0),
						BorderSizePixel = 0
					})
				})
			}, container)

			Library:OnHighlight(Create('TextLabel', {
				BackgroundTransparency = 1,
				Position = newUDim2(0, 28, 0, 0),
				Size = newUDim2(1, -32, 1, 0),
				Font = Enum.Font.SourceSans,
				TextColor3 = Library.staticColors.TextColor,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextSize = 14,
				Text = toggle.title
			}, container),
				{ TextColor3 = Library.staticColors.HTextColor },
				{ TextColor3 = Library.staticColors.TextColor }
			)

			local point = toggleFrame.Middle.Point
			point.Size = toggle.Value and newUDim2(1, 0, 1, 0) or newUDim2(0, 0, 0, 0)

			toggleFrame.InputBegan:Connect(function(inputObject)
				if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
					toggle:SetValue(not toggle.Value)
				end
			end)

			container.Parent = self.container
			toggle.point = point
			toggle.container = container
			Library.Flags[toggle.flag] = toggle.Value

			return toggle
		end

		function Toggle:SetValue(value)
			self.Value = value
			if self.callback then
				local override = self.callback(value)
				if typeof(override) == 'boolean' then
					self.Value = override
				end
			end

			Library.Flags[self.flag] = self.Value
			self.Changed:Fire(self.Value)
			Library:Tween(self.point, .075, 'Quad', 'Out', false, {
				Size = (self.Value and newUDim2(1, 0, 1, 0)) or newUDim2(0, 0, 0, 0)
			})
		end
	end

	local Slider = {}; do
		Slider.__index = Slider

		function Slider.new(self, properties)
			local slider = setmetatable({
				title = properties.Text or 'Slider',
				min = properties.Min or '0',
				max = properties.Max or '10',
				flag = properties.Flag or ('Flag' .. #Library.Flags + 1),
				showMax = properties.ShowMax or false,
				suffix = properties.Suffix,
				precise = properties.Precise,
				callback = properties.Callback or function() end,
				Changed = Signal.new()
			}, Slider)

			local container = Create(components:createComponentContainer(), {
				Create('Frame', {
					Name = 'Holder',
					BackgroundColor3 = Color3.fromRGB(50, 50, 50),
					BorderColor3 = Library.staticColors.BackgroundBorder,
					BorderSizePixel = 1,
					BorderMode = Enum.BorderMode.Outline,
					Position = newUDim2(0, 6, 0 ,3),
					Size = newUDim2(1, -12, 1, -6),
					ClipsDescendants = true,
					Create('Frame', {
						Name = 'Input',
						BackgroundTransparency = 1,
						Size = newUDim2(1, 0, 1, 0),
						Create('UIPageLayout', {
							FillDirection = Enum.FillDirection.Vertical,
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							EasingStyle = Enum.EasingStyle.Sine,
							GamepadInputEnabled = false,
							ScrollWheelInputEnabled = false,
							TouchInputEnabled = false,
							TweenTime = .2
						}),
						ZIndex = 2
					})
				})
			}, self.container)

			Library.Flags[slider.flag] = slider.min

			local holder = container.Holder

			local innerFrame = Create('Frame', {
				Parent = holder,
				Size = newUDim2(0, 0, 1, 0),
				BackgroundColor3 = Color3.fromRGB(83, 89, 95),
				BorderColor3 = Color3.fromRGB(70, 65, 80),
				BorderSizePixel = 1,
				BorderMode = Enum.BorderMode.Inset
			})

			local valueLabel = Create('TextLabel', {
				Parent = holder.Input,
				BackgroundTransparency = 1,
				Size = newUDim2(1, 0, 1, 0),
				ZIndex = 2,
				Font = Enum.Font.SourceSans,
				TextColor3 = Library.staticColors.TextColor,
				TextSize = 14,
				TextStrokeTransparency = .5
			})

			local valueBox = Create('TextBox', {
				Parent = holder.Input,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = newUDim2(1, 0, 1, 0),
				Font = Enum.Font.SourceSans,
				TextColor3 = Library.staticColors.TextColor,
				TextSize = 14,
				TextStrokeTransparency = .5,
				ZIndex = 2
			})

			slider.container = container
			slider.valueLabel = valueLabel
			slider.valueBox = valueBox
			slider.innerFrame = innerFrame

			local dragToggle = false
			local boxToggle = false

			Library:GiveSignal(holder.InputBegan:Connect(function(inputObject)
				if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
					dragToggle = true
					Library.sliding = true

					local inputChanged = UserInputService.InputChanged:Connect(function(input)
						if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
							slider:SetValue(slider.max * math.clamp((Vector2.new(input.Position.X, input.Position.Y) - holder.AbsolutePosition).X / holder.AbsoluteSize.X, 0, 1))
						end
					end)

					local connection; connection = inputObject.Changed:Connect(function()
						if inputObject.UserInputState == Enum.UserInputState.End then
							dragToggle = false
							connection:Disconnect()
							inputChanged:Disconnect()
							Library.sliding = false
						end
					end)
				end
			end))

			Library:GiveSignal(valueLabel.InputBegan:Connect(function(inputObject)
				if not boxToggle and inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
					boxToggle = true

					holder.Input.UIPageLayout:Next()
					valueBox:CaptureFocus()

					valueBox.FocusLost:Once(function()
						local value = tonumber(valueBox.Text)
						if value then
							slider:SetValue(value)
						end

						holder.Input.UIPageLayout:Previous()
						boxToggle = false
					end)
				end
			end))

			if properties.Value then
				slider:SetValue(properties.Value)
			else
				slider.Value = slider.min
			end

			slider:UpdateText()

			return slider
		end

		function Slider:UpdateText()
			local suffix = self.suffix or (self.showMax and '/' .. self.max) or ''

			self.valueLabel.Text = ('%s: %d%s'):format(self.title, self.Value, suffix)
		end

		function Slider:SetValue(value)
			if not self.precise then
				value = math.round(value)
			end

			local ratio = math.clamp(value / self.max, 0, 1)

			Library:Tween(self.innerFrame, .1, 'Sine', 'Out', false, {
				Size = UDim2.new(ratio, 0, 1, 0)
			})

			self.Value = value
			Library.Flags[self.flag] = value

			if self.callback then
				self.callback(value)
			end

			self:UpdateText()
			self.Changed:Fire(value)

			return self
		end
	end

	local Keybind = {}; do
		Keybind.__index = Keybind

		function Keybind.new(self, properties)
			local keybind = setmetatable({
				default = properties.Default or 'Unknown',
				title = properties.Text or 'Keybind',
				enabled = true,
				callback = properties.Callback or function() end
			}, Keybind)

			local container = Create(components:createComponentContainer(), {}, self.container)
			local keybindFrame = Create('Frame', {
				BackgroundColor3 = Color3.fromRGB(41, 41, 41),
				BorderColor3 = Color3.fromRGB(65, 65, 65),
				BackgroundTransparency = 0,
				BorderSizePixel = 1,
				BorderMode = Enum.BorderMode.Inset,
				Position = newUDim2(1, -36, 0, 0),
				Size = newUDim2(0, 30, 0, 19),
				Create('TextLabel', {
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = newUDim2(1, 0, 1, 0),
					Text = keybind.default == 'Unknown' and '...' or keybind.default.Name,
					Font = Enum.Font.SourceSans,
					TextSize = 14,
					TextColor3 = Library.staticColors.TextColor
				})
			}, container)

			Create('TextLabel', {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = newUDim2(0, 6, 0, 0),
				Size = newUDim2(1, -36, 1, 0),
				TextColor3 = Library.staticColors.TextColor,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.SourceSans,
				Text = keybind.title,
				Parent = container
			})

			keybind.Value = keybind.default
			keybind.container = container

			keybindFrame.InputBegan:Connect(function(inputObject)
				if keybind.enabled then
					keybind:onInputBegan(inputObject)
				end
			end)
			Library.Objects[#Library.Objects + 1] = keybind

			return keybind
		end

		function Keybind:onInputBegan(inputObject)
			if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
				local keybindFrame = self.container.Frame

				keybindFrame.TextLabel.Text = ''
				self.enabled = false

				local breakLoop; task.spawn(function()
					while not breakLoop do
						task.wait(.4)

						if breakLoop then
							break;
						end
						if keybindFrame.TextLabel.Text == '...' then
							keybindFrame.TextLabel.Text = ''
						end

						keybindFrame.TextLabel.Text ..= '.'
					end
				end)

				task.wait(.2)

				local connection; connection = UserInputService.InputBegan:Connect(function(inputObject)
					local key;
					if inputObject.UserInputType == Enum.UserInputType.Keyboard and inputObject.KeyCode ~= Enum.KeyCode.Backspace then
						key = inputObject.KeyCode
					elseif inputObject.KeyCode == Enum.KeyCode.Backspace then
						key = Enum.KeyCode.Unknown
					end

					if key then
						breakLoop = true

						if key.Name == 'Unknown' then
							keybindFrame.TextLabel.Text = '...'
							self.Value = nil
						else
							keybindFrame.TextLabel.Text = key.Name
							self.Value = key
						end
					end

					task.delay(.1, function()
						self.enabled = true
					end)

					connection:Disconnect()
				end)
			end
		end
	end

	local Dropdown = {}; do
		Dropdown.__index = Dropdown

		function Dropdown:createOption(outer, text)
			local frame = Create('Frame', {
				BackgroundTransparency = 1,
				Size = newUDim2(1, 0, 0, 18),
				Create('TextLabel', {
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 5, 0, 0),
					Size = UDim2.new(1, -5, 1, 0),
					Font = Enum.Font.SourceSans,
					Text = text,
					TextColor3 = Color3.fromRGB(170, 170, 170),
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				Create('Frame', {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, -2, 1, -2),
					Position = UDim2.new(0, 1, 0, 1),
					Create('UIStroke', {
						Enabled = false,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
						Color = Color3.fromRGB(163, 162, 165),
						LineJoinMode = Enum.LineJoinMode.Miter,
						Thickness = 1,
						Transparency = 0
					})
				})
			}, outer)

			frame.MouseEnter:Connect(function()
				frame.Frame.UIStroke.Enabled = true
			end)
			frame.MouseLeave:Connect(function()
				frame.Frame.UIStroke.Enabled = false
			end)

			return frame
		end

		function Dropdown.new(self, properties)
			local dropdown = setmetatable({
				title = properties.Text or 'Dropdown',
				options = properties.Options or {},
				flag = properties.Flag or ('Flag' .. #Library.Flags + 1),
				Value = properties.Value or '',
				Changed = Signal.new(),
				section = self
			}, Dropdown)

			local container = Create(components:createComponentContainer(newUDim2(1, 0, 0, 40)), {
				Create('Frame', {
					Name = 'Main',
					BackgroundColor3 = Color3.fromRGB(53, 53, 53),
					BorderColor3 = Color3.fromRGB(37, 37, 37),
					BorderMode = Enum.BorderMode.Inset,
					ClipsDescendants = true,
					Position = UDim2.new(0, 5, 0.5, 0),
					Size = UDim2.new(1, -10, 0.5, -1),
					Create('TextLabel', {
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 5, 0, 0),
						Size = UDim2.new(1, -6, 1, 0),
						Font = Enum.Font.SourceSans,
						Text = '...',
						TextColor3 = Color3.fromRGB(170, 170, 170),
						TextSize = 14,
						TextXAlignment = Enum.TextXAlignment.Left,
					}),
					Create('ImageButton', {
						Name = 'Button',
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(1, -16, 0, 1),
						Rotation = 0,
						Size = UDim2.new(0, 16, 0, 16),
						Image = 'rbxassetid://10833212996',
						ImageColor3 = Color3.fromRGB(163, 162, 165),
						ScaleType = Enum.ScaleType.Fit,
						SliceCenter = Rect.new(4, 6, 10, 9)
					})
				}),
				Create('TextLabel', {
					Text = dropdown.title,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 7, 0, 0),
					Size = UDim2.new(1, -14, 0.5, 0),
					Font = Enum.Font.SourceSans,
					TextColor3 = Color3.fromRGB(170, 170, 170),
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Left
				})
			}, self.container)

			local outerFrame = Create('Frame', {
				Parent = self.container.Parent.Parent.Parent,
				AnchorPoint = Vector2.new(.5, 0),
				BackgroundColor3 = Color3.fromRGB(49, 49, 49),
				BorderColor3 = Color3.fromRGB(37, 37, 37),
				BorderSizePixel = 1,
				BorderMode = Enum.BorderMode.Inset,
				Visible = false,
				Create('UIListLayout', { SortOrder = Enum.SortOrder.LayoutOrder }),
				ZIndex = 2
			})

			local options = {}
			for _, option in next, dropdown.options do
				table.insert(options, dropdown:createOption(outerFrame, option))
			end

			outerFrame.Size = UDim2.new(0, container.Main.AbsoluteSize.X, 0, outerFrame.UIListLayout.AbsoluteContentSize.Y)

			dropdown.outerFrame = outerFrame
			dropdown.container = container
			dropdown.options = options

			container.Main.Button.MouseButton1Click:Connect(function()
				if dropdown.open then
					dropdown:Hide()
				else
					dropdown:Show()
				end
			end)

			if dropdown.Value ~= '' then
				dropdown:SetValue(dropdown.Value)
			end

			dropdown:Hide()

			return dropdown
		end

		function Dropdown:Show()
			local size = 20 -- account for section text obj
			for _, component in next, self.section.components do
				size += component.container.AbsoluteSize.Y + 2
				if component == self then break end
			end

			self.open = true
			self.container.Main.Button.Rotation = 180
			self.outerFrame.Visible = true
			self.outerFrame.Position = UDim2.new(.25, 1, 0, 3 + size)
			self.container.Parent.Parent.ScrollingEnabled = false

			local connections = {}
			for _, option in next, self.options do
				table.insert(connections, option.InputBegan:Connect(function(inputObject)
					if inputObject.UserInputState == Enum.UserInputState.Begin and inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
						for i = 1, #connections do
							connections[i]:Disconnect()
						end; table.clear(connections)

						self.openConnections = nil
						self:SetValue(option.TextLabel.Text)

						self:Hide()
					end
				end))
			end

			self.openConnections = connections
		end

		function Dropdown:Hide()
			self.open = false
			self.outerFrame.Visible = false
			self.container.Main.Button.Rotation = 0

			if self.openConnections then
				for i = 1, #self.openConnections do
					self.openConnections[i]:Disconnect()
				end

				table.clear(self.openConnections)
				self.openConnections = nil
			end
		end

		function Dropdown:SetValue(value)
			self.Value = value
			self.Changed:Fire(value)
			self.container.Main.TextLabel.Text = value
		end
	end

	local List = {}; do
		List.__index = List

		function List.new(self, properties)
			if not properties or not properties.Options or #properties.Options < 1 then return end

			local list = setmetatable({
				title = properties.Text or 'List',
				options = properties.Options,
				flag = properties.Flag or ('Flag' .. #Library.Flags + 1),
				Value = properties.Value or '',
				buttons = {},
				Changed = Signal.new()
			}, List)

			local container = Create(components:createComponentContainer(), { AutomaticSize = Enum.AutomaticSize.Y }, self.container)
			local listFrame = Create('Frame', {
				BackgroundColor3 = Library.staticColors.MainBackground,
				BorderSizePixel = 1,
				BorderColor3 = Library.staticColors.BackgroundBorder,
				BorderMode = Enum.BorderMode.Inset,
				Position = newUDim2(0, 6, 0, 0),
				Size = newUDim2(1, -12, 0, 66)
			}, container)

			Create('TextLabel', {
				Name = 'Text',
				BackgroundTransparency = 1,
				Size = newUDim2(1, 0, 0, 20),
				Font = Enum.Font.SourceSans,
				Text = list.title,
				TextColor3 = Color3.fromRGB(170, 170, 170),
				TextSize = 14
			}, listFrame)

			local holder = Create('Frame', {
				Name = 'Holder',
				BackgroundColor3 = Color3.fromRGB(48, 48, 48),
				BorderSizePixel = 0,
				ClipsDescendants = true,
				Position = newUDim2(0, 3, 0, 20),
				Size = newUDim2(1, -6, 0, 0),
				Create('UIListLayout', {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 2)
				}),
				Create('Frame', {
					BackgroundTransparency = 1,
					Size = newUDim2(1, 0, 0, 0)
				})
			}, listFrame)

			holder.UIListLayout:GetPropertyChangedSignal'AbsoluteContentSize':Connect(function()
				local size = holder.UIListLayout.AbsoluteContentSize
				holder.Size = newUDim2(holder.Size.X.Scale, holder.Size.X.Offset, 0, size.Y + 2)
				listFrame.Size = newUDim2(listFrame.Size.X.Scale, listFrame.Size.X.Offset, 0, holder.AbsoluteSize.Y + 26)
			end)

			list.holder = holder
			list.container = container
			list.frame = listFrame

			for _, optionName in next, list.options do
				if type(optionName) == 'string' then
					list:createOption(optionName)
				end
			end

			list:SetValue(list.Value)

			return list
		end

		function List:createOption(name)
			local holder = self.holder
			local button = Create('TextButton', {
				BackgroundColor3 = Color3.fromRGB(50, 50, 50),
				BorderColor3 = Color3.fromRGB(39, 39, 39),
				Position = newUDim2(0, 3, 0, 1),
				Size =  newUDim2(1, -4, 0, 18),
				Font = Enum.Font.SourceSans,
				Text = name,
				TextColor3 = Color3.fromRGB(170, 170, 170),
				TextSize = 14.000,
				BorderMode = Enum.BorderMode.Inset,
				AutoButtonColor = false
			}, holder)

			button.MouseButton1Click:Connect(function()
				self.Value = name
				Library.Flags[self.flag] = name
				Library:Tween(button, .25, 'Quad', 'Out', false, { BackgroundColor3 = Color3.fromRGB(65, 65, 65) })
				for i = 1, #self.buttons do
					local _button = self.buttons[i]
					if _button ~= button then
						Library:Tween(_button, .25, 'Quad', 'Out', false, { BackgroundColor3 = Color3.fromRGB(50, 50, 50) })
					end
				end
			end)

			self.buttons[#self.buttons + 1] = button
		end

		function List:SetValue(value)
			for i = 1, #self.buttons do
				local button = self.buttons[i]
				if button.Text == value then
					self.Value = value
					Library.Flags[self.flag] = value
					self.Changed:Fire(value)
					Library:Tween(button, .25, 'Quad', 'Out', false, { BackgroundColor3 = Color3.fromRGB(65, 65, 65) })
				else
					Library:Tween(button, .25, 'Quad', 'Out', false, { BackgroundColor3 = Color3.fromRGB(50, 50, 50) })
				end
			end
		end
	end

	local MultiList = {} do
		MultiList.__index = MultiList

		function MultiList.new(self, properties)
			if not properties or not properties.Options or #properties.Options < 1 then return end

			local list = setmetatable({
				title = properties.Text or 'List',
				options = properties.Options,
				flag = properties.Flag or ('Flag' .. #Library.Flags + 1),
				Selected = properties.Selected or {},
				buttons = {},
				Changed = Signal.new()
			}, MultiList)

			local container = Create(components:createComponentContainer(), { AutomaticSize = Enum.AutomaticSize.Y }, self.container)
			local listFrame = Create('Frame', {
				BackgroundColor3 = Library.staticColors.MainBackground,
				BorderSizePixel = 1,
				BorderColor3 = Library.staticColors.BackgroundBorder,
				BorderMode = Enum.BorderMode.Inset,
				Position = newUDim2(0, 6, 0, 0),
				Size = newUDim2(1, -12, 0, 66)
			}, container)

			Create('TextLabel', {
				Name = 'Text',
				BackgroundTransparency = 1,
				Size = newUDim2(1, 0, 0, 20),
				Font = Enum.Font.SourceSans,
				Text = list.title,
				TextColor3 = Color3.fromRGB(170, 170, 170),
				TextSize = 14
			}, listFrame)

			local holder = Create('Frame', {
				Name = 'Holder',
				BackgroundColor3 = Color3.fromRGB(48, 48, 48),
				BorderSizePixel = 0,
				ClipsDescendants = true,
				Position = newUDim2(0, 3, 0, 20),
				Size = newUDim2(1, -6, 0, 0),
				Create('UIListLayout', {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 2)
				}),
				Create('Frame', {
					BackgroundTransparency = 1,
					Size = newUDim2(1, 0, 0, 0)
				})
			}, listFrame)

			holder.UIListLayout:GetPropertyChangedSignal'AbsoluteContentSize':Connect(function()
				local size = holder.UIListLayout.AbsoluteContentSize
				holder.Size = newUDim2(holder.Size.X.Scale, holder.Size.X.Offset, 0, size.Y + 2)
				listFrame.Size = newUDim2(listFrame.Size.X.Scale, listFrame.Size.X.Offset, 0, holder.AbsoluteSize.Y + 26)
			end)

			list.holder = holder
			list.container = container
			list.frame = listFrame

			for _, optionName in next, list.options do
				if type(optionName) == 'string' then
					list:createOption(optionName)
				end
			end

			for _, value in next, list.Selected do
				list:AddValue(value)
			end

			Library.Flags[list.flag] = list.Selected

			return list
		end

		function MultiList:createOption(name)
			local holder = self.holder
			local button = Create('TextButton', {
				BackgroundColor3 = Color3.fromRGB(50, 50, 50),
				BorderColor3 = Color3.fromRGB(39, 39, 39),
				Position = newUDim2(0, 3, 0, 1),
				Size =  newUDim2(1, -4, 0, 18),
				Font = Enum.Font.SourceSans,
				Text = name,
				TextColor3 = Color3.fromRGB(170, 170, 170),
				TextSize = 14.000,
				BorderMode = Enum.BorderMode.Inset,
				AutoButtonColor = false
			}, holder)

			button.MouseButton1Click:Connect(function()
				if not table.find(self.Selected, name) then
					self:AddValue(name)
				else
					self:RemoveValue(name)
				end
			end)

			self.buttons[#self.buttons + 1] = button
		end

		function MultiList:AddValue(value)
			for i = 1, #self.buttons do
				local button = self.buttons[i]
				if button.Text == value then
					if not table.find(self.Selected, value) then
						table.insert(self.Selected, value)
					end
					self.Changed:Fire(self.Selected)
					Library:Tween(button, .25, 'Quad', 'Out', false, { BackgroundColor3 = Color3.fromRGB(65, 65, 65) })
					break
				end
			end
		end

		function MultiList:RemoveValue(value)
			for i = 1, #self.buttons do
				local button = self.buttons[i]
				if button.Text == value then
					if table.find(self.Selected, value) then
						table.remove(self.Selected, table.find(self.Selected, value))
					end
					self.Changed:Fire(self.Selected)
					Library:Tween(button, .25, 'Quad', 'Out', false, { BackgroundColor3 = Color3.fromRGB(50, 50, 50) })
					break
				end
			end
		end
	end

	components.Box = Box
	components.Button = Button
	components.Toggle = Toggle
	components.Slider = Slider
	components.Divider = Divider
	components.Keybind = Keybind
	components.Dropdown = Dropdown
	components.List = List
	components.MultiList = MultiList
end

local containers = {}
do
	local Section = {}; do
		Section.__index = Section

		function Section.new(tab, properties)
			local section = setmetatable({
				title = (properties and properties.Text) or 'Section',
				side = math.clamp((properties and properties.Side) or 0, 0, 1)
			}, Section)

			local sectionFrame = Create('Frame', {
				Size = newUDim2(1, 0, 0, 20),
				BackgroundColor3 = Library.staticColors.MainBackground,
				BorderSizePixel = 1,
				BorderColor3 = Library.staticColors.BackgroundBorder,
				Create('UIListLayout', {
					Name = 'Layout',
					Padding = UDim.new(0, 2),
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Top
				}),
				Create('TextLabel', {
					Name = 'SectionText',
					BackgroundTransparency = 1,
					Size = newUDim2(1, -3, 0, 20),
					Font = Enum.Font.SourceSans,
					Text = section.title,
					TextColor3 = Library.staticColors.TextColor,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextSize = 14
				})
			}, section.side == 0 and tab.leftGroup or tab.rightGroup)

			sectionFrame.Layout:GetPropertyChangedSignal'AbsoluteContentSize':Connect(function()
				local Size = sectionFrame.Size
				sectionFrame.Size = newUDim2(Size.X.Scale, Size.X.Offset, Size.Y.Scale, (sectionFrame.Layout.AbsoluteContentSize.Y + 5))
			end)

			section.container = sectionFrame
			section.components = {}

			return section
		end

		function Section:AddBox(properties)
			local box = components.Box.new(self, properties or {})
			self.components[box.flag or #self.components + 1] = box
			return box
		end

		function Section:AddButton(properties)
			local button = components.Button.new(self, properties or {})
			table.insert(self.components, button)
			return button
		end

		function Section:AddDivider()
			local divider = components.Divider.new(self)
			table.insert(self.components, divider)
			return divider
		end

		function Section:AddToggle(properties)
			local toggle = components.Toggle.new(self, properties or {})
			self.components[toggle.flag or #self.components + 1] = toggle
			return toggle
		end

		function Section:AddSlider(properties)
			local slider = components.Slider.new(self, properties or {})
			self.components[slider.flag or #self.components + 1] = slider
			return slider
		end

		function Section:AddKeybind(properties)
			local keybind = components.Keybind.new(self, properties or {})
			table.insert(self.components, keybind)
			return keybind
		end

		function Section:AddDropdown(properties)
			local dropdown = components.Dropdown.new(self, properties or {})
			self.components[dropdown.flag or #self.components + 1] = dropdown
			return dropdown
		end

		function Section:AddList(properties)
			local list = components.List.new(self, properties or {})
			self.components[list.flag or #self.components + 1] = list
			return list
		end

		function Section:AddMultiList(properties)
			local multiList = components.MultiList.new(self, properties or {})
			self.components[multiList.flag or #self.components + 1] = multiList
			return multiList
		end
	end

	local Tab = {}; do
		Tab.__index = Tab

		function Tab.new(window, name)
			local tab = setmetatable({
				sections = {},
				window = window
			}, Tab)

			local tabFrame = Create('ScrollingFrame', {
				BackgroundColor3 = Library.staticColors.MainBackground,
				BorderSizePixel = 0,
				Size = newUDim2(1, 0, 1, 0),
				Position = newUDim2(0, 0, 0, 0),
				CanvasSize = newUDim2(0, 0, 1, 0),
				ScrollBarThickness = 0,
				ScrollBarImageTransparency = 1,
				Visible = true,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
			}, window.tabHolder)

			tab.container = tabFrame
			tab.tabButton = tab:createTabButton(name)

			local sectionHolderLeft = tab:createSectionHolder(newUDim2(0, 3, 0, 3))
			local sectionHolderRight = tab:createSectionHolder(newUDim2(0, 220, 0, 3))

			tab.leftGroup = sectionHolderLeft
			tab.rightGroup = sectionHolderRight

			if #window._tabs == 0 then
				tab:Show()
			else
				tab:Hide()
			end

			return tab
		end

		function Tab:createSectionHolder(position)
			return Create('ScrollingFrame', {
				Position = position,
				Size = newUDim2(0, 213, 1, -6),
				BackgroundColor3 = Library.staticColors.MainBackground,
				BorderSizePixel = 1,
				BorderColor3 = Library.staticColors.BackgroundBorder,
				ScrollBarThickness = 0,
				ScrollBarImageTransparency = 1,
				Visible = true,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				CanvasSize = newUDim2(0, 0, .5, 0),
				Create('UIListLayout', {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					Padding = UDim.new(0, 4)
				})
			}, self.container)
		end

		function Tab:createTabButton(name)
			local tabButton = Create('TextButton', {
				BackgroundColor3 = Library.staticColors.MainBackground,
				BorderSizePixel = 0,
				Size = newUDim2(0, 16, 1, 0),
				Text = string.format('  %s  ', name or 'Tab'),
				TextColor3 = Library.staticColors.TextColor,
				TextSize = 14,
				AutomaticSize = Enum.AutomaticSize.X,
				Font = Enum.Font.SourceSans
			}, self.window.tabButtonHolder)

			tabButton.MouseButton1Click:Connect(function()
				self:Show()
				for i = 1, #self.window._tabs do
					local currentTab = self.window._tabs[i]
					if currentTab ~= self then
						currentTab:Hide()
					end
				end
			end)

			return tabButton
		end

		function Tab:Hide()
			Library:Tween(self.tabButton, .1, 'Quad', 'Out', false, {
				BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			})

			self.container.Visible = false
		end

		function Tab:Show()
			Library:Tween(self.tabButton, .1, 'Quad', 'Out', false, {
				BackgroundColor3 = Library.staticColors.MainBackground
			})

			self.container.Visible = true
		end

		function Tab:AddSection(...)
			local section = Section.new(self, ...)
			self.sections[#self.sections + 1] = section

			return section
		end
	end

	local Window = {}; do
		Window.__index = Window

		function Window.new(title)
			local window = {
				onClosed = Signal.new(),
				_tabs = {}
			}

			local container = Create('Frame', {
				Name = 'Border',
				BackgroundColor3 = Library.staticColors.Border,
				Size = newUDim2(0, 444, 0, 308),
				Position = newUDim2(0.5, -222, 0.5, -154),
				BorderSizePixel = 0,
				Create('Frame', {
					Name = 'Background',
					BackgroundColor3 = Library.staticColors.BackgroundBorder,
					BorderColor3 = Library.staticColors.BackgroundBorder,
					Size = newUDim2(1, -8, 1, -8),
					Position = newUDim2(0, 4, 0, 4),
					ClipsDescendants = true,
					Create('Frame', {
						Name = 'Bar',
						BackgroundColor3 = Library.staticColors.MainBackground,
						Size = newUDim2(1, 0, 0, 48),
						Position = newUDim2(0, 0, 0, 0),
						BorderSizePixel = 0,
						Create('TextLabel', {
							Text = title or 'Untitled',
							BackgroundTransparency = 1,
							Size = newUDim2(0.5, 0, 0, 23),
							Position = newUDim2(0.25, 0, 0, 0),
							Font = Enum.Font.SourceSans,
							TextColor3 = Library.staticColors.TextColor,
							TextSize = 14
						}),
						Create('Frame', {
							Name = 'Ray',
							BorderSizePixel = 0,
							BackgroundColor3 = Library.staticColors.SecondaryBackground,
							Position = newUDim2(0, 0, 0, 0),
							Size = newUDim2(1, 0, 0, 4),
						}),
						Create('Frame', {
							Name = 'Holder',
							BackgroundColor3 = Color3.fromRGB(37, 37, 37),
							BorderColor3 = Color3.fromRGB(26, 26, 26),
							Position = newUDim2(0, 3, 1, -25),
							Size = newUDim2(1, -6, 0, 22),
							Create('UIListLayout', {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalAlignment = Enum.HorizontalAlignment.Left,
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
								Padding = UDim.new(0, 1)
							})
						}),
					}),
					Create('Frame', {
						Name = 'Holder',
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = newUDim2(1, 0, 1, -49),
						Position = newUDim2(0, 0, 0, 49),
						Visible = true,
					})
				})
			}, screenGui)

			Library:MakeDraggable(container)

			local exitButton = Create('TextButton', {
				Name = 'Exit',
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = newUDim2(0, 11, 0, 11),
				Position = newUDim2(1, -11, 0, 7),
				Font = Enum.Font.SourceSansLight,
				Text = 'X',
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 16,
				TextXAlignment = Enum.TextXAlignment.Left,
			}, container.Background.Bar)

			exitButton.MouseButton1Click:Connect(function()
				window.onClosed:Fire()
				Library:Unload()
			end)

			local minimizeButton = Create('TextButton', {
				Name = 'Minimize',
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = newUDim2(0, 11, 0, 11),
				Position = newUDim2(1, -25, 0, 7),
				Font = Enum.Font.SourceSans,
				Text = '﹘',
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Top,
			}, container.Background.Bar)

			minimizeButton.MouseButton1Click:Connect(function()
				minimizeButton.Text = (minimizeButton.Text == '﹘' and '+') or '﹘'
				Library:Tween(container, .15, 'Sine', 'Out', false, {
					Size = (container.Size == newUDim2(0, 444, 0, 308) and newUDim2(0, 444, 0, 56)) or newUDim2(0, 444, 0, 308)
				})
			end)

			window.container = container
			window.tabHolder = container.Background.Holder
			window.titleLabel = container.Background.Bar.TextLabel
			window.tabButtonHolder = container.Background.Bar.Holder

			setmetatable(window, Window)

			return window
		end

		function Window:AddTab(name)
			local tab = Tab.new(self, name)
			self._tabs[#self._tabs + 1] = tab

			return tab
		end

		function Window:SetTitle(title)
			self.titleLabel.Text = title
		end
	end

	containers.Window = Window
	containers.Tab = Tab
end

function Library:CreateWindow(title)
	return containers.Window.new(title)
end

Library:GiveSignal(UserInputService.InputBegan:Connect(function(inputObject, processed)
	if UserInputService:GetFocusedTextBox() then
		return;
	end

	if inputObject.KeyCode == Enum.KeyCode.RightControl and screenGui then
		screenGui.Enabled = not screenGui.Enabled
		return;
	end
	for _, keybindObject in next, Library.Objects do
		if keybindObject.enabled and keybindObject.Value == inputObject.KeyCode then
			task.spawn(keybindObject.callback)
		end
	end
end))

return Library