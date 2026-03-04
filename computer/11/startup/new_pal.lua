--- A custom ComputerCraft palette based on the zeromini theme.
--
-- One should place this within the startup directory.
-- @see https://github.com/SquidDev/where-the-heart-is/blob/master/.emacs.d/zeromini-theme.el

local palette = {
    [colours.black]     = "#000000",
    [colours.red]       = "#ff0000",
    [colours.white]     = "#ffffff",
}

for code, hex in pairs(palette) do
    term.setPaletteColour(code, tonumber(hex:sub(2), 16))
end
