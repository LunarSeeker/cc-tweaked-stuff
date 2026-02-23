local function round(num, decimalPlaces)
    local mult = 10 ^ decimalPlaces
    return math.floor(num * mult + 0.5) / mult
end

for i, v in pairs(peripheral.getMethods("left")) do
    if string.find(string.lower(v), "player") then
        print(v)
    end
end

local pd = peripheral.wrap("left")

while true do
    local foundPlr = pd.getPlayer("PuffFish99")

    print("x: " .. tostring(foundPlr.x))
    print("y: " .. tostring(foundPlr.y))
    print("z: " .. tostring(foundPlr.z))
    print(round(foundPlr.health / 20, 2))
    sleep(2)
end
