require "utils"

---@type string[]
local testInput = {
    ".......S.......",
    "...............",
    ".......^.......",
    "...............",
    "......^.^......",
    "...............",
    ".....^.^.^.....",
    "...............",
    "....^.^...^....",
    "...............",
    "...^.^...^.^...",
    "...............",
    "..^...^.....^..",
    "...............",
    ".^.^.^.^.^...^.",
    "...............",
}

---@param input string[]
local function processInput(input)
    local splitCount = 0

    ---@type string[]
    local output = {
        input[1]
    }

    for i = 2, #input do
        local inputCur = input[i]
        local outputPre = output[i - 1]

        ---@type string
        local outputCur = ""

        for j = 1, #inputCur do
            local outputPreChar = outputPre:sub(j, j)

            if outputPreChar == "S" then
                outputCur = outputCur .. "|"
            elseif outputPreChar == "|" then
                outputCur = outputCur .. "|"
            elseif outputPreChar == "." then
                outputCur = outputCur .. "."
            elseif outputPreChar == "^" then
                outputCur = outputCur .. "."
            end

            local inputCurChar = inputCur:sub(j, j)
            if outputPreChar == "|" and inputCurChar == "^" then
                --- split!
                splitCount = splitCount + 1
                outputCur = outputCur:sub(1, -3) .. "|^"
            end

            ---@type string?
            local inputPrevChar = nil
            if j > 1 then
                inputPrevChar = inputCur:sub(j - 1, j - 1)
            end
            if inputPrevChar == "^" then
                outputCur = outputCur:sub(1, -2) .. "|"
            end
        end
        table.insert(output, outputCur)
    end
    return output, splitCount
end

local testOutput, splitCount = processInput(testInput)
-- for _, row in ipairs(testOutput) do
--     print(row)
-- end
assert(testOutput[#testOutput] == "|.|.|.|.|.|||.|")
assert(splitCount == 21)

local resultTree, resultSplitCount = processInput(ParseLinesIntoTable("day-07-input.txt"))

for _, row in ipairs(resultTree) do
    print(row)
end

print(resultSplitCount)
