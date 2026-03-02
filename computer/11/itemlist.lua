function trim(s)
    return s:gsub("^%s*(.-)%s*$", "%1")
end

function removeNumbers(s)
    return s:gsub("%d+", "")
end

for _, v in pairs(peripheral.call("left", "dump")) do
    local trimmed = trim(v)
    print(trimmed)
end
