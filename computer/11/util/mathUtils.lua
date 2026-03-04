local function round(num, decimalPlaces)
    local mult = 10 ^ decimalPlaces
    return math.floor(num * mult + 0.5) / mult
end

local function clamp(value, min, max)
    return math.min(math.max(value, min), max)
end

return {
    clamp = clamp,
    round = round
}