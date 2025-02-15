repeat task.wait() until game:IsLoaded();
local presets = {
	V1 = {
		Colors = {
			OutsideStroke = Color3.fromRGB(44, 44, 44),
			MainBackground = Color3.fromRGB(17, 17, 17),
			BottomBar = Color3.fromRGB(31, 82, 182),
			TabBackground = Color3.fromRGB(26, 26, 26),
			TabImage_1 = Color3.fromRGB(79, 88, 255),
			TabImage_2 = Color3.fromRGB(122, 122, 122),
			TabTextColorOn = Color3.fromRGB(255, 255, 255),
			TabTextColorOff = Color3.fromRGB(200, 200, 200),
			TopBar = Color3.fromRGB(29, 29, 29),
			TabBar = Color3.fromRGB(20, 20, 20),
			GameName = Color3.fromRGB(152, 152, 152),
			ScriptName = Color3.fromRGB(31, 82, 182),
			SectionBackground = Color3.fromRGB(36, 36, 36),
			SectionText = Color3.fromRGB(65, 74, 209),
			ElementBackground = Color3.fromRGB(21, 21, 21),
			ElementText = Color3.fromRGB(255, 255, 255),
			SwitchEnabled = Color3.fromRGB(65, 74, 208),
			SwitchDisabled = Color3.fromRGB(38, 38, 38),
			TabEnabled = Color3.fromRGB(26, 26, 26),
			Glow = Color3.fromRGB(44, 111, 255),
			Tag = Color3.fromRGB(150, 150, 150),
			TabStick = Color3.fromRGB(79, 88, 255),
			TabNameBackgroundColor = Color3.fromRGB(36, 36, 36),
			TabNameTextColor = Color3.fromRGB(126, 135, 255),
			ButtonColor = Color3.fromRGB(79, 88, 255),
			ButtonColor2 = Color3.fromRGB(96, 130, 255),
			MouseColor = Color3.fromRGB(139, 170, 255),
			SliderInner = Color3.fromRGB(137, 126, 255),
			SliderBackground = Color3.fromRGB(30, 30, 30),
			SliderStroke = Color3.fromRGB(48, 48, 48),
			DropdownText2 = Color3.fromRGB(158, 94, 255),
			DropdownText = Color3.fromRGB(109, 66, 179),
			KeybindBackground = Color3.fromRGB(39, 39, 39)
		},
	}
}
local library = {
	Name='KLib V4';
	Developers = {
		apnff0x = {'Designer', 'Programmer'},
		altered = {'Designer', 'Programmer'},
	};
	Tabs = {};
	Component = {};
	Colors = {
		OutsideStroke = Color3.fromRGB(44, 44, 44),
		MainBackground = Color3.fromRGB(17, 17, 17),
		BottomBar = Color3.fromRGB(58, 141, 204),
		TabBackground = Color3.fromRGB(26, 26, 26),
		TabImage_1 = Color3.fromRGB(66, 171, 182),
		TabImage_2 = Color3.fromRGB(122, 122, 122),
		TabTextColorOn = Color3.fromRGB(255, 255, 255),
		TabTextColorOff = Color3.fromRGB(200, 200, 200),
		TopBar = Color3.fromRGB(29, 29, 29),
		TabBar = Color3.fromRGB(20, 20, 20),
		GameName = Color3.fromRGB(152, 152, 152),
		ScriptName = Color3.fromRGB(82, 189, 255),
		SectionBackground = Color3.fromRGB(36, 36, 36),
		SectionText = Color3.fromRGB(83, 198, 209),
		ElementBackground = Color3.fromRGB(21, 21, 21),
		ElementText = Color3.fromRGB(255, 255, 255),
		SwitchEnabled = Color3.fromRGB(78, 152, 208),
		SwitchDisabled = Color3.fromRGB(38, 38, 38),
		TabEnabled = Color3.fromRGB(26, 26, 26),
		Glow = Color3.fromRGB(52, 235, 255),
		Tag = Color3.fromRGB(150, 150, 150),
		TabStick = Color3.fromRGB(84, 238, 255),
		TabNameBackgroundColor = Color3.fromRGB(36, 36, 36),
		TabNameTextColor = Color3.fromRGB(130, 255, 247),
		ButtonColor = Color3.fromRGB(78, 152, 208),
		ButtonColor2 = Color3.fromRGB(96, 189, 255),
		MouseColor = Color3.fromRGB(135, 229, 255),
		SliderInner = Color3.fromRGB(94, 166, 255),
		SliderBackground = Color3.fromRGB(30, 30, 30),
		SliderStroke = Color3.fromRGB(48, 48, 48),
		DropdownTextOff = Color3.fromRGB(67, 119, 182),
		DropdownTextOn = Color3.fromRGB(94, 166, 254),
		KeybindBackground = Color3.fromRGB(39, 39, 39)
	},
	Tag = math.random(0,9) .. math.random(0,9) .. math.random(0,9) .. math.random(0,9),
	Debug = false,
	ActiveDropdown = false
}

local Players = game:GetService("Players")
local LocalPlayer = Players['LocalPlayer']
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Http = game:GetService("HttpService")
local InputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
if library.Debug and RunService:IsStudio() then
	PlayerGui:WaitForChild("ContainerUI"):Destroy()
end

-- // config thing
function nostudio(func)
	if not RunService:IsStudio() and writefile and readfile and isfile then
		func(writefile, readfile, isfile)
	end
end

function ismobile()
	return ((InputService.KeyboardEnabled == false) and (InputService.TouchEnabled == true) and (InputService.MouseEnabled == false))
end
if library.Debug then
	warn(ismobile())
end

function BindToClick(obj, func)
	if not ismobile() then
		InputService.InputBegan:Connect(function(input, gpe)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and obj.GuiState == Enum.GuiState.Press and not gpe then
				func()
			end
		end)
	else
		local hover = false
		obj.MouseEnter:Connect(function()
			hover = true
		end)
		obj.MouseLeave:Connect(function()
			hover = false
		end)
		InputService.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch and hover then
				func()
			end
		end)
	end
end

function Create(class: string, props: table, children: table): Instance
	local instance = Instance.new(class)
	for property, value in next, props do
		instance[property] = value
	end
	for _, newinstance in next, (children or {}) do
		newinstance.Parent = instance
	end
	if props.Name == nil and not library.Debug then
		--instance.Name = Http:GenerateGUID(false)
	end
	return instance
end

function shadow()
	return Create("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 0
	}, {
		Create("ImageLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 0,
			Size = UDim2.new(1, 52, 1, 52),
			Image = "rbxassetid://6015897843",
			ImageColor3 = library.Colors.Glow,
			ScaleType = Enum.ScaleType.Slice,
			SliceScale = 1,
			SliceCenter = Rect.new(49, 49, 450, 450)
		})
	})
end

function dimensions()
	local temp = Instance.new("ScreenGui", PlayerGui)
	temp.Name = Http:GenerateGUID(true)
	
	local dims = temp.AbsoluteSize
	temp:Destroy()
	
	return dims
end

function parent()
	if RunService:IsStudio() or game.PlaceId == 106029673345214 then
		return PlayerGui
	else
		return CoreGui
	end
end

-- // do not remove this
local savedata = {}
nostudio(function(wf, rf, is)
	if not is("CONFIGFILE__.json") then
		wf("CONFIGFILE__.json", "{}")
	end
	savedata = Http:JSONDecode(rf("CONFIGFILE__.json"))
end)
function saveconfig()
	nostudio(function(wf, rf)
		wf("CONFIGFILE__.json", Http:JSONEncode(savedata))
	end)
end
-- component functions
function library.Component:AddTab(name, icon, __parent, __pagesinstance): Instance
	local Count = #library.Tabs
	local First = (Count == 0)
	
	local NewTab = Create("Frame", {
		BackgroundColor3 = library.Colors.TabBackground,
		BackgroundTransparency = First and 0 or 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 35),
		Parent = __parent
	}, {
		Create("Frame", {
			Name = "stick",
			BackgroundColor3 = library.Colors.TabStick,
			AnchorPoint = Vector2.new(1, 0.5),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(1, 0.5),
			Size = UDim2.new(0, 1, 1, First and 0 or -35),
			Visible = true
		}, {
			Create("UIGradient", {
				Name = "StickGradient",
				Rotation = 90,
				Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.7), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 0.7)})
			})
		}),
		Create("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			TextSize = 17,
			Font = Enum.Font.Arimo,
			TextColor3 = library.Colors[First and 'TabTextColorOn' or 'TabTextColorOff'],
			--TextXAlignment = Enum.TextXAlignment.Right,
			Text = name
		}),
		Create("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 5, 0.5, 0),
			Size = UDim2.fromOffset(22, 22),
			Image = icon,
			ImageColor3 = library.Colors[First and 'TabImage_1' or 'TabImage_2']
		}),
		Create("TextLabel", {
			Name = "Click",
			Size= UDim2.fromScale(1, 1),
			Text = "",
			ZIndex = 2,
			BackgroundTransparency = 1,
		}),
		Create("UIStroke", {
			Color = Color3.fromRGB(44, 44, 44),
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = 0
		})
	})
	local NewPage = Create("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -4, 1, -4),
		Visible = First,
		Parent = __pagesinstance,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
	}, {
		Create("ScrollingFrame", {
			AnchorPoint = Vector2.new(0, 1),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0, 1),
			Size = UDim2.fromScale(1, 1),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarThickness = 0,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ClipsDescendants = false
		}, {
			Create("UIListLayout", {
				Padding = UDim.new(0, 3)
			}),
			Create("Frame", {
				BackgroundColor3 = library.Colors.SectionBackground,
				Size = UDim2.new(1, 0, 0, 20),
				BorderSizePixel = 0,
				ZIndex = 9
			}, {
				Create("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.Arimo,
					Text = name,
					TextColor3 = library.Colors.SectionText,
					TextSize = 16,
					ZIndex = 9
				})
			}),
		})
	})
	
	NewTab.MouseEnter:Connect(function()
		if library.ActiveDropdown then return end
		TweenService:Create(NewTab.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 1}):Play()
	end)
	NewTab.MouseLeave:Connect(function()
		if library.ActiveDropdown then return end
		TweenService:Create(NewTab.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 0}):Play()
	end)
	
	BindToClick(NewTab.Click, function()
		for _, v in next, library.Tabs do
			TweenService:Create(v.Frame.stick, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 1, 1, -35)}):Play()
			TweenService:Create(v.Frame, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {BackgroundTransparency = 1}):Play()
			TweenService:Create(v.Frame.TextLabel, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {TextColor3 = library.Colors.TabTextColorOff}):Play()
			TweenService:Create(v.Frame.ImageLabel, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {ImageColor3 = library.Colors.TabImage_2}):Play()
			v.Content.Visible = false
		end
		NewPage.Visible = true
		TweenService:Create(NewTab.stick, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 1, 1, 0)}):Play()
		TweenService:Create(NewTab.TextLabel, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {TextColor3 = library.Colors.TabTextColorOn}):Play()
		TweenService:Create(NewTab.ImageLabel, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {ImageColor3 = library.Colors.TabImage_1}):Play()
		TweenService:Create(NewTab, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {BackgroundTransparency = 0}):Play()
	end)
	
	table.insert(library.Tabs, {Frame = NewTab, Content = NewPage})
	return {Frame = NewTab, Content = NewPage}
end

function library.Component:AddBase(name, __parent, desc, tt, ch)
	local Base = Create("Frame", {
		BackgroundColor3 = library.Colors.ElementBackground,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 35),
		Parent = __parent
	}, {
		Create("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(5, 0),
			Size = UDim2.new(1, -5, 0, 35),
			Font = Enum.Font.Arial,
			Text = name,
			TextColor3 = library.Colors.ElementText,
			TextSize = 16,
			TextXAlignment = Enum.TextXAlignment.Left
		}),
		Create("UIStroke", {
			Color = Color3.fromRGB(44, 44, 44),
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = 0
		})
	})
	local uihovery = false
	Base.MouseEnter:Connect(function()
		uihovery = true
		
		if library.ActiveDropdown then return end
		TweenService:Create(Base.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 1}):Play()
	end)
	Base.MouseLeave:Connect(function()
		uihovery = false
		
		if library.ActiveDropdown then return end
		TweenService:Create(Base.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 0}):Play()
	end)
	if desc then
		local description = Create("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 5, 1, -7),
			Size = UDim2.new(1, -5, 0, 0),
			Font = Enum.Font.Arial,
			Text = desc,
			TextColor3 = Color3.fromRGB(148, 148, 148),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = Base,
			AnchorPoint = Vector2.new(0, 1),
			Name = "description"
		})
		RunService.RenderStepped:Connect(function()
			description.Size = UDim2.new(1, -5, 0, (description.TextBounds.Y))
			Base.Size = UDim2.new(1, 0, 0, 35 + description.TextBounds.Y)
		end)
	end
	if tt then -- tooltip for retards who cant read very well, or for extra information
		local TTContainer = Create("ScreenGui", {
			Parent = parent(),
			DisplayOrder = 69696969
		})
		local TTR = Create("Frame", {
			Parent = TTContainer,
			Name = "TT",
			Size = UDim2.new(0, 50, 0, 16),
			BackgroundColor3 = Color3.fromRGB(34, 34, 34)
		}, {
			Create("TextLabel", {
				Size = UDim2.fromScale(1, 1),
				Text = tt,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Font = Enum.Font.Arial,
				BackgroundTransparency = 1,
				TextSize = 12
			}),
			Create("UIStroke", {
				Color = Color3.fromRGB(122, 122, 122)
			}),
			Create("UICorner", {
				CornerRadius = UDim.new(0, 1)
			})
		})
		InputService.InputChanged:Connect(function(input)
			-- no idea if this works on mobile
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				TTR.Visible = uihovery
				TTR.Size = UDim2.fromOffset(TTR.TextLabel.TextBounds.X + 10, TTR.TextLabel.TextBounds.Y + 4)
				if uihovery then
					TTR.Position = UDim2.fromOffset(input.Position.X + 5, (input.Position.Y - 20) - (TTR.Size.Y.Offset - 10)) -- put it 20 pixels up and 5 to pixels to the right so it isnt covering our fake mouse
				end
			end
		end)
	end
	for _, v in pairs(ch) do
		v.Parent = Base
	end
	return Base
end

-- // window functions
function library:AddWindow(windowproperties: table)
	windowproperties = {
		Name = windowproperties.Name or 'Unnamed Script',
		GameName = windowproperties.GameName or 'Unknown Game',
		Size = windowproperties.Size or UDim2.fromOffset(650, 390),
	}
	
	local Window = Create("ScreenGui", {
		Parent = parent(),
		Name = Http:GenerateGUID(true),
		ResetOnSpawn = false,
		IgnoreGuiInset = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
	})
	
	local MainFrame = Create("Frame", {
		Parent = Window,
		BackgroundColor3 = library.Colors.MainBackground,
		Size = windowproperties.Size,
		Position = UDim2.fromOffset(dimensions().X/2, dimensions().Y/2)
	}, {
		Create("UIStroke", {
			Color = library.Colors.OutsideStroke
		}),
		Create("Frame", {
			Name = "cover",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(15, 15, 15),
			ZIndex = 42069,
			Visible = false
		}, {
			Create("TextLabel", {
				Text = "UI Hidden",
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(166, 166, 166),
				TextSize = 22,
				FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold),
				ZIndex = 42069
			})
		}),
		Create("TextButton", {
			Name = "resizer",
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.fromScale(1, 1),
			Size = UDim2.fromOffset(15, 15),
			BackgroundTransparency = 1,
			Text = ""
		}),
		Create("TextLabel", {
			Size = UDim2.new(1, 0, 0, 27),
			TextColor3 = library.Colors.ScriptName,
			Position = UDim2.fromOffset(10, 3),
			Text = windowproperties.Name,
			BackgroundTransparency = 1,
			TextSize = 27,
			Font = Enum.Font.SourceSans,
			TextXAlignment = Enum.TextXAlignment.Left,
			Name = "s"
		}),
		Create("TextLabel", {
			Size = UDim2.new(1, 0, 0, 27),
			TextColor3 = library.Colors.GameName,
			Position = UDim2.fromOffset(10, 23),
			Text = windowproperties.GameName,
			BackgroundTransparency = 1,
			Font = Enum.Font.SourceSans,
			TextSize = 20,
			TextXAlignment = Enum.TextXAlignment.Left
		}),
		Create("Frame", {
			AnchorPoint = Vector2.new(0, 1),
			BackgroundColor3 = library.Colors.BottomBar,
			Position = UDim2.new(0, 0, 1, -10),
			Size = UDim2.new(1, 0, 0, 10),
			BorderSizePixel = 0
		}, {
			Create("ImageLabel", {
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, -25),
				Size = UDim2.fromOffset(20, 20),
				Image = "rbxassetid://92300560334264",
				ImageColor3 = Color3.fromRGB(34, 34, 34),
				ZIndex = 2
			}, {
				Create("ImageLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=512&height=512&format=png",
					ZIndex = 2
				}, {
					Create("UICorner", {CornerRadius = UDim.new(1, 0)})
				})
			}),
			Create("TextLabel", {
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(30, -20),
				Size = UDim2.fromOffset(100, 15),
				Font = Enum.Font.Arimo,
				Text = LocalPlayer.Name .. (not LocalPlayer.Name:match("%d") and ("#" .. library.Tag) or ""),
				TextColor3 = library.Colors.Tag,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2
			}),
			Create("Frame", {
				AnchorPoint = Vector2.new(0, 1),
				BackgroundColor3 = library.Colors.TabBar,
				Size = UDim2.new(0, 190, 0, 30),
				BorderSizePixel = 0
			})
		}),
		Create("Frame", {
			Name = "Framex",
			ClipsDescendants = true,
			BackgroundTransparency = 0,
			BackgroundColor3 = library.Colors.TabBar,
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(0, 50),
			Size = UDim2.new(0, 190, 1, -100)
		}, {
			Create("ScrollingFrame", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.new(1, -4, 1, -4),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 0,
				ScrollingDirection = Enum.ScrollingDirection.Y,
				CanvasSize = UDim2.new(0, 0, 0, 0),
				ClipsDescendants = false
			}, {
				Create("UIListLayout", {
					Padding = UDim.new(0, 1),
					FillDirection = Enum.FillDirection.Vertical
				})
			}),	
		}),
		Create("Frame", {
			Name = "Pages",
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(200, 50),
			Size = UDim2.new(1, -210, 1, -80),
			ClipsDescendants = true
		}),
		Create("Frame", {
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = library.Colors.TopBar,
			BorderSizePixel = 0,
			Position = UDim2.new(1, 0, 0, 3),
			Size = UDim2.fromOffset(45, 20),
			Name = "top"
		}, {
			Create("TextLabel", {
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -5, 0.5, 0),
				Size = UDim2.fromOffset(15, 15),
				Font = Enum.Font.SourceSans,
				Text = "X",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				Name = "exit"
			}),
			Create("TextLabel", {
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -25, 0.5, 0),
				Size = UDim2.fromOffset(15, 15),
				Font = Enum.Font.SourceSans,
				Text = "_",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				Name = "min"
			})
		}),
		shadow()
	})
	BindToClick(MainFrame.top.exit, function()
		InputService.MouseIconEnabled = true
		Window:Destroy()
	end)
	BindToClick(MainFrame.top.min, function()
		print("press f2 to show ui")
		MainFrame.Visible = false
	end)

	local FakeMouse = Create("ImageLabel", {
		Parent = Window,
		Visible = false,
		Image = "rbxassetid://80969788083542",
		Size = UDim2.fromOffset(16, 16),
		BackgroundTransparency = 1,
		ZIndex = 42069,
		ImageColor3 = library.Colors.MouseColor
	})
	
	local mouse = LocalPlayer:GetMouse()
	InputService.InputBegan:Connect(function(input)
		if input.KeyCode==Enum.KeyCode.F2 then
			MainFrame.Visible = not MainFrame.Visible
		end
	end)
	InputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			mouse = LocalPlayer:GetMouse()
			FakeMouse.Position = UDim2.fromOffset(mouse.X, mouse.Y)
		end
	end)
	
	function updatem(d1, d2)
		MainFrame.cover.Visible = true
		newsize = UDim2.new(
			0,
			math.clamp(LocalPlayer:GetMouse().X - MainFrame.Position.X.Offset + d1, 510, math.huge),
			0,
			math.clamp(LocalPlayer:GetMouse().Y - MainFrame.Position.Y.Offset + d2, 300, math.huge)
		)
		TweenService:Create(MainFrame, TweenInfo.new(0.15, Enum.EasingStyle.Cubic), {Size = newsize}):Play()
	end
	InputService.InputBegan:Connect(function(key, gpe)
		if gpe then return end
		if key.KeyCode == Enum.KeyCode.F4 then
			local d1 = MainFrame.Size.X.Offset + (MainFrame.Position.X.Offset - LocalPlayer:GetMouse().X)
			local d2 = MainFrame.Size.Y.Offset + (MainFrame.Position.Y.Offset - LocalPlayer:GetMouse().Y)
			
			while InputService:IsKeyDown(Enum.KeyCode.F4) do
				updatem(d1, d2)
				task.wait()
			end
			MainFrame.cover.Visible = false
		elseif key.KeyCode == Enum.KeyCode.F3 then
			MainFrame.cover.Visible = not MainFrame.cover.Visible
		end
	end)
	
	local resizin = false
	local dragToggle = nil
	local dragInput = nil
	local dragStart = nil
	local dragPos = nil
	MainFrame.resizer.MouseButton1Down:Connect(function()
		resizin = true
		local d1 = MainFrame.Size.X.Offset + (MainFrame.Position.X.Offset - LocalPlayer:GetMouse().X)
		local d2 = MainFrame.Size.Y.Offset + (MainFrame.Position.Y.Offset - LocalPlayer:GetMouse().Y)
		while resizin do
			updatem(d1, d2)
			task.wait()
		end
		MainFrame.cover.Visible = false
	end)
	InputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizin = false
		end
	end)
	
	MainFrame.MouseEnter:Connect(function()
		InputService.MouseIconEnabled = false
		FakeMouse.Visible = true
	end)
	MainFrame.MouseLeave:Connect(function()
		if dragToggle then return end
		repeat wait() until not resizin
		FakeMouse.Visible = false
		InputService.MouseIconEnabled = true
	end)
	
	-- // adding drag
	local Delta
	local Position
	local startPos
	local function updateInput(input)
		Delta = input.Position - dragStart
		Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
		game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.08, Enum.EasingStyle.Cubic), {Position = Position}):Play()
	end
	MainFrame.s.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and InputService:GetFocusedTextBox() == nil then
			dragToggle = true
			dragStart = input.Position
			startPos = MainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	MainFrame.s.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	InputService.InputChanged:Connect(function(input)
		if input == dragInput and dragToggle then
			updateInput(input)
		end
	end)
	
	local WindowData = {}
	function WindowData.AddTab(tabproperties)
		local component = library.Component:AddTab(tabproperties.Name or 'Unknown', tabproperties.Icon or '', MainFrame.Framex.ScrollingFrame, MainFrame.Pages)
		local TabData = {}
		
		function TabData.AddToggle(toggleproperties)
			local data = {
				Enabled = toggleproperties.Value or false
			}
			
			nostudio(function(wf, rf)
				if toggleproperties.NoSave then return end
				data = Http:JSONDecode(rf("CONFIGFILE__.json"))[toggleproperties.Name] or data
				toggleproperties.Callback(data.Enabled)
			end)
			
			local toggle = library.Component:AddBase(toggleproperties.Name or 'Unknown', component.Content.ScrollingFrame, toggleproperties.Description, toggleproperties.ToolTip, {
				Create("TextLabel", {
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = library.Colors[data.Enabled and 'SwitchEnabled' or 'SwitchDisabled'],
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.fromOffset(24, 24),
					Font = Enum.Font.SourceSans,
					TextSize = 14,
					Text = "",
					Name = "TextLabel2"
				}, {
					Create("UICorner", {
						CornerRadius = UDim.new(0, 4)
					}),
					Create("UIStroke", {
						Color = data.Enabled and library.Colors.ButtonColor2 or Color3.fromRGB(58, 58, 58),
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Thickness = 0
					})
				})
			})
			toggle.TextLabel2.MouseEnter:Connect(function()
				if library.ActiveDropdown then return end
				TweenService:Create(toggle.TextLabel2.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 1}):Play()
			end)
			toggle.TextLabel2.MouseLeave:Connect(function()
				if library.ActiveDropdown then return end
				TweenService:Create(toggle.TextLabel2.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 0}):Play()
			end)
			BindToClick(toggle.TextLabel2, function()
				data.Enabled = not data.Enabled
				toggle.TextLabel2.BackgroundColor3 = library.Colors[data.Enabled and 'SwitchEnabled' or 'SwitchDisabled']
				TweenService:Create(toggle.TextLabel2.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Color = data.Enabled and library.Colors.ButtonColor2 or Color3.fromRGB(58, 58, 58)}):Play()
				
				if not toggleproperties.NoSave then
					nostudio(function(wf)
						savedata[toggleproperties.Name] = {Enabled = data.Enabled}
					end)
					saveconfig()
				end
				
				toggleproperties.Callback(data.Enabled)
			end)
			
			return data
		end
		function TabData.AddButton(buttonproperties)
			local button = library.Component:AddBase(buttonproperties.Name or 'Unknown', component.Content.ScrollingFrame, buttonproperties.Description, buttonproperties.ToolTip, {
				Create("TextLabel", {
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = library.Colors.ButtonColor,
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.new(0, 120, 1, -20),
					TextSize = 12,
					Text = buttonproperties.ButtonText or "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold),
					Name = "TextLabel2"
				}, {
					Create("UICorner", {
						CornerRadius = UDim.new(0, 3)
					}),
					Create("UIStroke", {
						Color = library.Colors.ButtonColor2,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Thickness = 0
					})
				})
			})
			button.TextLabel2.MouseEnter:Connect(function()
				if library.ActiveDropdown then return end
				TweenService:Create(button.TextLabel2.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 1}):Play()
			end)
			button.TextLabel2.MouseLeave:Connect(function()
				if library.ActiveDropdown then return end
				TweenService:Create(button.TextLabel2.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 0}):Play()
			end)
			BindToClick(button.TextLabel2, function()
				buttonproperties.Callback(tick())
			end)
		end
		function TabData.AddSlider(sliderproperties)
			local data = {
				Value = sliderproperties.Def or sliderproperties.Min
			}
			
			nostudio(function(wf, rf)
				if sliderproperties.NoSave then return end
				data = Http:JSONDecode(rf("CONFIGFILE__.json"))[sliderproperties.Name] or data
				sliderproperties.Callback(data.Value)
			end)
			
			local slider = library.Component:AddBase(sliderproperties.Name or 'Unknown', component.Content.ScrollingFrame, sliderproperties.Description, sliderproperties.ToolTip, {
				Create("Frame", {
					Name = "Inner",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = library.Colors.SliderBackground,
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.fromOffset(120, 8)
				}, {
					Create("UIStroke", {
						Color = library.Colors.SliderStroke,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Thickness = 0
					}),
					Create("UICorner", {
						CornerRadius = UDim.new(1, 0)	
					}),
					Create("Frame", {
						Name = "Inner",
						BackgroundColor3 = library.Colors.SliderInner,
						Size = UDim2.fromScale(0.5, 1)
					}, {
						Create("UICorner", {
							CornerRadius = UDim.new(1, 0)	
						})
					})
				})
			})
			
			local mouse = nil
			local sdragging = false
			local p
			slider.Inner.MouseEnter:Connect(function()
				if library.ActiveDropdown then return end
				TweenService:Create(slider.Inner.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 1}):Play()
			end)
			slider.Inner.MouseLeave:Connect(function()
				if sdragging then return end
				TweenService:Create(slider.Inner.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 0}):Play()
			end)
			
			local function fixsize(per)
				TweenService:Create(slider.Inner.Inner, TweenInfo.new(0.1, Enum.EasingStyle.Cubic), {Size = UDim2.fromScale(math.clamp(per, 0, 1), 1)}):Play()
			end
			
			-- FROM VENYX
			local function update(slider, value, min, max)
				mouse = LocalPlayer:GetMouse()
				local bar = slider.Inner
				local percent = (mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
				
				if not value then
					fixsize(percent)
				else
					percent = (value - min) / (max - min)
					if library.Debug then
						print(percent)
					end
					fixsize(percent)
				end

				percent = math.clamp(percent, 0, 1)
				value = value or math.floor(min + (max - min) * percent)
				
				return value
			end
			
			-- // drag
			BindToClick(slider.Inner, function()
				sdragging = true
				while sdragging do
					data.Value = update(slider, nil, sliderproperties.Min, sliderproperties.Max, nil)
					if library.Debug then
						print(data.Value)
					end
					sliderproperties.Callback(data.Value)
					task.wait()
				end
			end)
			
			-- // def
			update(slider, data.Value, sliderproperties.Min, sliderproperties.Max, nil)
			
			-- // stop drag
			InputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 and sdragging then
					sdragging = false
					TweenService:Create(slider.Inner.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 0}):Play()
					if not sliderproperties.NoSave then
						nostudio(function(wf)
							savedata[sliderproperties.Name] = {Value = data.Value}
						end)
						saveconfig()
					end
				end
			end)
			
			return data
		end
		function TabData.AddDropdown(dropdownproperties)
			local data = {
				Selected = dropdownproperties.Def or nil
			}
			
			nostudio(function(wf, rf)
				if dropdownproperties.NoSave then return end
				data = Http:JSONDecode(rf("CONFIGFILE__.json"))[dropdownproperties.Name] or data
				dropdownproperties.Callback(data.Selected)
			end)
			
			local dropdown = library.Component:AddBase(dropdownproperties.Name or 'Unknown', component.Content.ScrollingFrame, dropdownproperties.Description, dropdownproperties.ToolTip, {
				Create("Frame", {
					Name = "Inner",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(30, 30, 30),
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.fromOffset(130, 25)
				}, {
					Create("Frame", {
						Name = "Right",
						AnchorPoint = Vector2.new(1, 0),
						BackgroundColor3 = Color3.fromRGB(48, 48, 48),
						Position = UDim2.fromScale(1, 0),
						Size = UDim2.fromOffset(20, 25)
					}, {
						Create("Frame", {
							BackgroundColor3 = Color3.fromRGB(48, 48, 48),
							Size = UDim2.fromOffset(3, 25),
							BorderSizePixel = 0
						}),
						Create("ImageLabel", {
							BackgroundTransparency = 1,
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.fromOffset(15, 15),
							Position = UDim2.fromScale(0.5, 0.5),
							Image = "rbxassetid://121112600399854",
							ScaleType = Enum.ScaleType.Fit
						}),
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						})
					}),
					Create("UIStroke", {
						Color = Color3.fromRGB(55, 55, 55),
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Thickness = 0
					}),
					Create("UICorner", {
						CornerRadius = UDim.new(0, 5)
					}),
					Create("TextLabel", {
						Text = " " .. ((data.Selected and tostring(data.Selected)) or "Unselected"),
						BackgroundTransparency = 1,
						Size = UDim2.new(1, -25, 1, 0),
						TextColor3 = Color3.fromRGB(88, 88, 88),
						TextXAlignment = Enum.TextXAlignment.Left,
						Font = Enum.Font.Arimo,
						TextSize = 14,
						ClipsDescendants = true
					}),
					Create("Frame", {
						Name = "Classez",
						ClipsDescendants = true,
						Size = UDim2.fromScale(1, 0),
						Position = UDim2.new(0, 0, 1, 2),
						BackgroundColor3 = Color3.fromRGB(30, 30, 30),
						ZIndex = 4000
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("UIListLayout", {
							Padding = UDim.new(0, 0)
						})
					})
				})
			})
			
			dropdown.Inner.MouseEnter:Connect(function()
				TweenService:Create(dropdown.Inner.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 1}):Play()
			end)
			dropdown.Inner.MouseLeave:Connect(function()
				TweenService:Create(dropdown.Inner.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Thickness = 0}):Play()
			end)
			
			local open
			BindToClick(dropdown.Inner, function()
				if library.ActiveDropdown and not open then return end
				if open == true then
					open = false
				else
					open = true
				end
				library.ActiveDropdown = open
				
				local newsize = (#(dropdownproperties.Array or {})*(25 + 0))
				TweenService:Create(dropdown.Inner.Classez, TweenInfo.new(0.2, Enum.EasingStyle.Cubic), {Size = UDim2.new(1, 0, 0, open and newsize or 0)}):Play()
				TweenService:Create(dropdown.Inner.Right.ImageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Cubic), {Rotation = open and 180 or 0}):Play()
			end)
			
			local dconnections = {}
			local objects = {}
			local value = data.Selected
			local function refresh()
				for a, b in next, objects do b:Destroy() end;
				for c, d in next, dconnections do d:Disconnect() end;
				for e, f in ipairs(dropdownproperties.Array or {}) do
					local newobject = Create("Frame", {
						Parent = dropdown.Inner.Classez,
						BackgroundColor3 = Color3.fromRGB(28, 28, 28),
						AnchorPoint = Vector2.new(1, 0.5),
						Size = UDim2.fromOffset(130, 25),
						BorderSizePixel = 0,
						ZIndex = 4000
					}, {
						Create("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.new(1, -5, 1, 0),
							Font = Enum.Font.Arimo,
							TextColor3 = Color3.fromRGB(88, 88, 88),
							TextSize = 14,
							Text = " " .. tostring(f),
							ClipsDescendants = true,
							TextXAlignment = Enum.TextXAlignment.Left,
							ZIndex = 4000
						})
					})
					
					local funval = (e == 1 or e == #dropdownproperties.Array)
					
					table.insert(dconnections, newobject.MouseEnter:Connect(function()
						if data.Selected == f then return end
						newobject.TextLabel.TextColor3 = library.Colors.DropdownTextOff
					end))
					table.insert(dconnections, newobject.MouseLeave:Connect(function()
						if data.Selected == f then return end
						newobject.TextLabel.TextColor3 = Color3.fromRGB(88, 88, 88)
					end))
					
					if funval then
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5),
							Parent = newobject
						})
						if e == 1 then
							Create("Frame", {
								BackgroundColor3 = Color3.fromRGB(28, 28, 28),
								AnchorPoint = Vector2.new(0, 1),
								Position = UDim2.fromScale(0, 1),
								Size = UDim2.new(1, 0, 0, 5),
								Parent = newobject,
								BorderSizePixel = 0,
								ZIndex = 4000
							})
						else
							Create("Frame", {
								BackgroundColor3 = Color3.fromRGB(28, 28, 28),
								AnchorPoint = Vector2.new(0, 0),
								Position = UDim2.fromScale(0, 0),
								Size = UDim2.new(1, 0, 0, 5),
								Parent = newobject,
								BorderSizePixel = 0,
								ZIndex = 4000
							})
						end
					end
					
					local function updated()
						newobject.TextLabel.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
						newobject.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
						newobject.TextLabel.TextColor3 = library.Colors.DropdownTextOn
						dropdown.Inner.TextLabel.Text = " " .. tostring(data.Selected)
						if newobject:FindFirstChild("Frame") then
							newobject.Frame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
						end
					end
					
					if data.Selected == f then
						updated()
					end
					
					BindToClick(newobject, function()
						data.Selected = f
						updated()
						
						for _, v in objects do
							if v == newobject then continue end
							v.TextLabel.TextColor3 = Color3.fromRGB(88, 88, 88)
							v.TextLabel.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Regular)
							v.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
							if v:FindFirstChild("Frame") then
								v.Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
							end
						end
						
						if not dropdownproperties.NoSave then
							nostudio(function()
								savedata[dropdownproperties.Name] = {Selected = data.Selected}
							end)
							saveconfig()
						end
						
						dropdownproperties.Callback(data.Selected)
					end)
					
					table.insert(objects, newobject)
					if dropdownproperties.Def == f then
						newobject.TextLabel.FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold)
						newobject.TextLabel.TextColor3 = library.Colors.DropdownTextOn
						newobject.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
						if funval then
							newobject.Frame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
						end
					end
				end
			end
			refresh()
			
			function data:Refresh(array)
				dropdownproperties.Array = array
				refresh()
			end
			
			return data
		end
		function TabData.AddKeybind(bindproperties)
			local data = {
				Bind = (bindproperties.Keybind and bindproperties.Keybind.Name) or nil
			}
			
			nostudio(function(wf, rf)
				if bindproperties.NoSave then return end
				data = Http:JSONDecode(rf("CONFIGFILE__.json"))[bindproperties.Name] or data
			end)
			
			local keybind = library.Component:AddBase(bindproperties.Name or 'Unknown', component.Content.ScrollingFrame, bindproperties.Description, bindproperties.ToolTip, {
				Create("TextLabel", {
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = library.Colors.KeybindBackground,
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.fromOffset(24, 24),
					Font = Enum.Font.SourceSans,
					TextSize = 14,
					Text = "",
					Name = "TextLabel2"
				}, {
					Create("UICorner", {
						CornerRadius = UDim.new(0, 4)
					}),
					Create("ImageLabel", {
						Size = UDim2.new(1, -8, 1, -8),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.fromScale(0.5, 0.5),
						Image = "rbxassetid://105518905916733", -- "Edit" image!!1
						ImageColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Visible = data.Bind == nil
					}),
					Create("TextLabel", {
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.fromScale(0.5, 0.5),
						Text = (data.Bind) or "",
						TextColor3 = Color3.fromRGB(222, 222, 222),
						TextSize = 14,
						FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Bold),
						Size = UDim2.new(1, -3, 1, -3),
						BackgroundTransparency = 1,
						ClipsDescendants = true
					})
				})
			})
			
			local keybindconnection = nil
			
			keybindconnection = InputService.InputBegan:Connect(function(input)
				if data.Bind ~= nil and input.KeyCode == Enum.KeyCode[data.Bind] then
					bindproperties.Callback()
				end
			end)
			BindToClick(keybind.TextLabel, function()
				newkey = InputService.InputBegan:Wait()
				
				wait(0.03)
				if newkey.KeyCode ~= Enum.KeyCode.Unknown then
					data.Bind = newkey.KeyCode.Name
					keybind.TextLabel2.ImageLabel.Visible = false
					keybind.TextLabel2.TextLabel.Text = data.Bind
					
					if not bindproperties.NoSave then
						nostudio(function()
							savedata[bindproperties.Name] = {Bind = data.Bind}
						end)
						saveconfig()
					end
				end
			end)
			
			return data
		end
		function TabData.AddTextBox(boxproperties)
			local data = {
				Text = (boxproperties.Def and tostring(boxproperties.Def)) or ""
			}
			
			nostudio(function(wf, rf)
				if boxproperties.NoSave then return end
				data = Http:JSONDecode(rf("CONFIGFILE__.json"))[boxproperties.Name] or data
			end)
			
			local box = library.Component:AddBase(boxproperties.Name or 'Unknown', component.Content.ScrollingFrame, boxproperties.Description, boxproperties.ToolTip, {
				Create("Frame", {
					Name = "Box",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(17, 17, 17),
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.fromOffset(120, 22)
				}, {
					Create("UICorner", {
						CornerRadius = UDim.new(0, 4)
					}),
					Create("UIStroke", {
						Color = Color3.fromRGB(48, 48, 48)
					}),
					Create("ImageLabel", {
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 3, 0.5, 0),
						Size = UDim2.fromOffset(14, 14),
						Image = "rbxassetid://74554103132200",
						ImageColor3 = boxproperties.ImageColor or Color3.fromRGB(163, 163, 163)
					}),
					Create("TextBox", {
						AnchorPoint = Vector2.new(1, 0),
						BackgroundTransparency = 1,
						Name = "Input",
						Position = UDim2.new(1, -5, 0, 0),
						Size = UDim2.new(1, -26, 1, 0),
						ClipsDescendants = true,
						FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular),
						TextSize = 14,
						PlaceholderColor3 = Color3.fromRGB(163, 163, 163),
						PlaceholderText = boxproperties.Placeholder or "",
						TextColor3 = boxproperties.TextColor or Color3.fromRGB(255, 255, 255),
						TextXAlignment = Enum.TextXAlignment.Right,
						Text = data.Text,
						ClearTextOnFocus = false
					})
				})
			})
			
			box.Box.Input.FocusLost:Connect(function()
				data.Text = box.Box.Input.Text
				
				if not boxproperties.NoSave then
					nostudio(function()
						savedata[boxproperties.Name] = {Text = data.Text}
					end)
					saveconfig()
				end
				
				boxproperties.Callback(data.Text)
			end)
			
			return data
		end
		function TabData.AddLabel(textproperties)
			local text = library.Component:AddBase(textproperties.Text or 'Text Was not put by the dev ??', component.Content.ScrollingFrame, textproperties.Description, textproperties.ToolTip, {})
			text.TextLabel.TextXAlignment = Enum.TextXAlignment.Center
			text.description.TextXAlignment = Enum.TextXAlignment.Center
		end
		function TabData:Divide(x)
			Create("Frame", {
				BackgroundColor3 = library.Colors.SectionBackground,
				Size = UDim2.new(1, 0, 0, 20),
				BorderSizePixel = 0,
				Parent = component.Content.ScrollingFrame
			}, {
				Create("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.Arimo,
					Text = x,
					TextColor3 = library.Colors.SectionText,
					TextSize = 16
				})
			})
		end
		return TabData
	end
	
	return WindowData
end

-- // credits
print("--------------- UI CREDITS ---------------")
	for i, v in library.Developers do
		print(`\t\t  {i}: {table.concat(v, ', ')}`)
	end
print("--------------- UI CREDITS ---------------")

-- // init
return library
