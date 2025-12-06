require "utils"

---@type string[]
local testInput = {
    "..@@.@@@@.",
    "@@@.@.@.@@",
    "@@@@@.@.@@",
    "@.@@@@..@.",
    "@@.@@@@.@@",
    ".@@@@@@@.@",
    ".@.@.@.@@@",
    "@.@@@.@@@@",
    ".@@@@@@@@.",
    "@.@.@@@.@.",
}

---@type table<{x: integer, y: integer}>
local adjacentLocationOffsets = {
    { -1, -1 }, { 0, -1 }, { 1, -1 },
    { -1, 0 }, { 1, 0 },
    { -1, 1 }, { 0, 1 }, { 1, 1 },
}

---@param x integer
---@param y integer
---@param input string[]
---@return string, string
local function getAdjacentPositions(x, y, input)
    ---@type string
    local adjacents = ""
    local maxY = #input
    for _, offset in ipairs(adjacentLocationOffsets) do
        local newx = x + offset[1]
        local newy = y + offset[2]
        if newx >= 1 and newy >= 1 then
            ---@type string
            local row = input[newy]
            if row then
                local maxX = #row
                if newx <= maxX and newy <= maxY then
                    local adjacent = row:sub(newx, newx)
                    adjacents = adjacents .. row:sub(newx, newx)
                end
            end
        end
    end

    local origin = input[y]:sub(x, x)
    return adjacents, origin
end
assert(select(2, getAdjacentPositions(1, 1, testInput)) == ".")
assert(select(2, getAdjacentPositions(3, 1, testInput)) == "@")
assert(select(2, getAdjacentPositions(10, 10, testInput)) == ".")
assert(select(2, getAdjacentPositions(5, 5, testInput)) == "@")

assert(getAdjacentPositions(1, 1, testInput) == ".@@")
assert(getAdjacentPositions(3, 1, testInput) == ".@@@.")
assert(getAdjacentPositions(10, 10, testInput) == "@.@")
assert(getAdjacentPositions(5, 5, testInput) == "@@@@@@@@")

---@param x integer
---@param y integer
---@param input string[]
---@return boolean
local function validateAdjacentPositions(x, y, input)
    local adjacents, origin = getAdjacentPositions(x, y, input)
    if origin ~= "@" then
        return false
    end
    local _, rollCount = adjacents:gsub("@", "")
    return rollCount < 4
end
assert(validateAdjacentPositions(1, 1, testInput) == false)
assert(validateAdjacentPositions(3, 1, testInput) == true)
assert(validateAdjacentPositions(10, 10, testInput) == false)
assert(validateAdjacentPositions(9, 10, testInput) == true)
assert(validateAdjacentPositions(5, 5, testInput) == false)

---@param input string[]
---@return nil
local function processInput(input)
    local numValid = 0
    for y, row in ipairs(input) do
        for x = 1, #row do
            if validateAdjacentPositions(x, y, input) then
                numValid = numValid + 1
            end
        end
    end
    return numValid
end
assert(processInput(testInput) == 13)

local result = processInput(ParseLinesIntoTable("day-04-input.txt"))
print(result)
