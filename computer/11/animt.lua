local function clamp(value, min, max)
    return math.min(math.max(value, min), max)
end

local tron = peripheral.wrap("top")

tron.setBodyRot(0, 0, 0)
tron.setFace("normal")
tron.setHeadRot(0, 0, 0)

tron.push()

for i, v in pairs(peripheral.getMethods("top")) do
    print(v)
end

sleep(1)

local emotions = {
    "happy",
    "normal",
    "question",
    "sad"
}

for i = 1, #emotions, 1 do
    sleep(0.5)

    tron.setFace(emotions[clamp(i, 1, #emotions)])
    tron.setHeadRot(0, i * 15, 0)
    tron.setRightArmRot(0, 0, math.random(1, i + 1) * 45)

    tron.push()
end

sleep(2)

while true do
    sleep(1.2)
    tron.setHeadRot(math.random(1, 8) * 45, 0, math.random(1, 8) * 45)
    tron.push()
end
