local manager = peripheral.wrap("left")

while true do
sleep(1)
manager.removeItemFromPlayer("up", {name="minecraft:glass", count=8})
end
