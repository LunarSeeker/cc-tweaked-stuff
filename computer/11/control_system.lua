-- local event, username, message, uuid, isHidden = os.pullEvent("chat")
-- print("The 'chat' event was fired with the username " .. username .. " and the message " .. message)

local router = "redrouter_1"


local function clamp(value, min, max)
    return math.min(math.max(value, min), max)
end

while true do
    write("On/Off:")
    local message = read()

    -- peripheral.call(sourceCreate, "setLine", 1)
    if string.lower(message) == "off" then
        peripheral.call(router, "setAnalogueOutput", "back", 0)
    elseif string.lower(message) == "on" then
        peripheral.call(router, "setAnalogueOutput", "back", 15)
    else
        peripheral.call(router, "setAnalogueOutput", "back", clamp(tonumber(message), 1, 15))
    end
end
