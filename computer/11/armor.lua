local manager = peripheral.wrap("left")

local armor = manager.getArmor()
print(manager.getEmptySpace())
print(manager.getFreeSlot())
print("First armor piece is: " .. armor[1].displayName)
