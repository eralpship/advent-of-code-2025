require "utils"

local testInput = {
    "L68",
    "L30",
    "R48",
    "L5",
    "R60",
    "L55",
    "L1",
    "L99",
    "R14",
    "L82",
}

---@param rotationString string
---@return number
local function parseRotation(rotationString)
    local direction = rotationString:sub(1, 1)
    local distance = tonumber(rotationString:sub(2))
    assert(distance, "Invalid distance: %s", rotationString)
    if direction == "L" then
        return -distance
    end
    return distance
end
assert(parseRotation('L100') == -100)
assert(parseRotation('R100') == 100)

---@param input number
---@param rotationString string
---@return number, number
local function applyRotation(input, rotationString)
    local rotation = parseRotation(rotationString)
    local numPass0 = 0
    input = input + rotation
    while input < 0 do
        input = input + 100
        numPass0 = numPass0 + 1
    end
    while input > 99 do
        input = input - 100
        numPass0 = numPass0 + 1
    end
    return input, numPass0
end
assert(applyRotation(50, 'R5') == 55, 0)
assert(select(2, applyRotation(50, 'R5')) == 0)
assert(applyRotation(50, 'L5') == 45, 0)
assert(select(2, applyRotation(50, 'L5')) == 0)
assert(applyRotation(50, 'L55') == 95, 0)
assert(select(2, applyRotation(50, 'L55')) == 1)
assert(applyRotation(50, 'R55') == 5, 0)
assert(select(2, applyRotation(50, 'R55')) == 1)
assert(applyRotation(50, 'L155') == 95, 0)
assert(select(2, applyRotation(50, 'L155')) == 2)
assert(applyRotation(50, 'R155') == 5, 0)
assert(select(2, applyRotation(50, 'R155')) == 2)
assert(applyRotation(50, 'L355') == 95, 0)
assert(select(2, applyRotation(50, 'L355')) == 4)
assert(applyRotation(50, 'R355') == 5, 0)
assert(select(2, applyRotation(50, 'R355')) == 4)
assert(select(2, applyRotation(50, 'R1000')) == 10)
assert(select(2, applyRotation(50, 'L1000')) == 10)

---@param rotations table
---@return number, number
local function applyRotations(rotations)
    local numFinalHit0 = 0
    local totalNumPass0 = 0
    local current = 50
    for index, value in ipairs(rotations) do
        local newCurrent, numPass0 = applyRotation(current, value)
        current = newCurrent
        if current == 0 then
            numFinalHit0 = numFinalHit0 + 1
        end

        totalNumPass0 = totalNumPass0 + numPass0

        print(value, current, numPass0)
    end
    return numFinalHit0, totalNumPass0
end
assert(applyRotations(testInput) == 3)
assert(select(2, applyRotations(testInput)) == 6)

local realInput = ParseTextInput("day-01-input.txt")
local phase1, phase2 = applyRotations(realInput)
assert(phase1 == 1180)

print(phase1, phase2)
