local dragging
local dragInput
local dragStart
local startPos

-- UI
local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Toogle = Instance.new("TextButton")

--MAİN

main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false
main.IngoreGuiInset = true
main.displayOrder = 999

--FRAME

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(54, 54, 54)
Frame.Position = UDim2.new(0, 0, 0, 0)
Frame.Size = UDim2.new(0, 30, 0, 30)

-- TOOGLE

Toogle.Name = "Toogle"
Toogle.Parent = Frame
Toogle.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
Toogle.BorderColor3 = Color3.fromRGB(1, 1, 1)
Toogle.Size = UDim2.new(0, 30, 0, 30)
Toogle.Font = Enum.Font.SourceSans
Toogle.TextColor3 = Color3.fromRGB(255, 0, 0)
Toogle.Text = "Auto Click : No"
Toogle.TextWrapped = true
Toogle.TextScaled = true



-- DATA 

local AutoClickEnabled = false


--AUTO CLİCK

local function repeatFunction()

local args = {
        [1] = 1.5,
        [2] = CFrame.new(-183.08358764648438, 125.93684387207031, 29.001541137695312, 0.9923487305641174, -0.07399874925613403, 0.09883421659469604, -3.500516765342354e-09, 0.8004931211471558, 0.5993419885635376, -0.12346666306257248, -0.5947562456130981, 0.794368326663971),
    
        [3] = {
            ["4739402996"] = Vector3.new(381.4285583496094, 166.36497497558594, 13.439170837402344),
        },
        [4] = {
            [1] = 576,
            [2] = 20
        }
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ParryAttempt"):FireServer(unpack(args))
end

Toogle.MouseButton1Click:Connent(function()
    autoClickEnabled = not autoClickEnabled
    Toogle.Text = "Auto Click: On"
    Toogle.TextColor3 = Color3.fromRGB(0, 255, 0)
    
    if autoClickEnabled then
      while autoClickEnabled do 
        repeatFunction()
        wait(1)
      end 
    else

      Toogle.TextColor3 Color3.fromRGB(255, 0, 0)
    end
  end)

local function updateInput(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)
