function trim(s)
    return s:gsub("^%s*(.-)%s*$", "%1")
end

function removeNumbers(s)
    return s:gsub("%d+", "")
end

return {
    trim = trim,
    removeNumbers = removeNumbers
}