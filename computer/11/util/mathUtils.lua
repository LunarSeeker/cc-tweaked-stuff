local function round(num, decimalPlaces)
    local mult = 10 ^ decimalPlaces
    return math.floor(num * mult + 0.5) / mult
end

local function clamp(value, min, max)
    return math.min(math.max(value, min), max)
end

local function map(n, InMin, InMax, OutMin, OutMax)
    return (OutMin + ((OutMax - OutMin) * ((n - InMin) / (InMax - InMin))))
end

return {
    clamp = clamp,
    round = round,
    map = map
}