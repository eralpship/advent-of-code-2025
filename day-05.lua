require "utils"

---@type string[]
local testInput = {
    "3-5",
    "10-14",
    "16-20",
    "12-18",
    "",
    "1",
    "5",
    "8",
    "11",
    "17",
    "32 ",
}


---@param input string[]
local function processInput(input)
    ---@type table<integer, boolean>
    local ingredients = {}

    ---@type boolean
    local ingredientsComplete = false

    ---@type integer
    local freshIngredientCount = 0

    ---@alias Range {[1]: integer, [2]: integer}
    ---@type Range[]
    local freshRanges = {}

    local _countValid = 0

    for i = #input, 1, -1 do
        local entry = input[i]
        if #entry == 0 then
            ingredientsComplete = true
        elseif ingredientsComplete then
            local aStr, bStr = entry:match("(%d+)-(%d+)")
            local a = math.tointeger(aStr)
            local b = math.tointeger(bStr)
            if not a or not b then
                error("failed to parse range")
            end


            table.insert(freshRanges, { a, b })


            for ingredient, checkedFresh in pairs(ingredients) do
                if not checkedFresh and ingredient >= a and ingredient <= b then
                    ingredients[ingredient] = true
                    freshIngredientCount = freshIngredientCount + 1
                end
            end
        else
            local ingredientId = math.tointeger(entry)
            if not ingredientId then
                error("failed to parse int " .. entry)
            end
            ingredients[ingredientId] = false
        end
    end

    table.sort(freshRanges, function(a, b) return a[1] < b[1] end)

    -- Merge overlapping ranges
    local merged = {}
    for _, range in ipairs(freshRanges) do
        if #merged == 0 then
            table.insert(merged, { range[1], range[2] })
        else
            local prev = merged[#merged]
            if range[1] <= prev[2] + 1 then
                -- Overlapping or adjacent, merge
                prev[2] = math.max(prev[2], range[2])
            else
                -- Gap, add new range
                table.insert(merged, { range[1], range[2] })
            end
        end
    end

    -- Count total items in merged ranges
    for _, range in ipairs(merged) do
        _countValid = _countValid + (range[2] - range[1] + 1)
    end

    -- ---@type Range[]
    -- local trimmedRanges = {}
    -- for i = 1, #freshRanges do
    --     if i == 1 then
    --         table.insert(trimmedRanges, {
    --             freshRanges[i][1],
    --             freshRanges[i][2],
    --         })
    --     else
    --         local _a = freshRanges[i][1]
    --         local _b = freshRanges[i][2]
    --         for _, range in ipairs(trimmedRanges) do
    --             local prevA = range[1]
    --             local prevB = range[2]
    --             if _a >= prevA and _a <= prevB then
    --                 _a = prevB + 1
    --             end
    --             if _b >= prevA and _b <= prevB then
    --                 _b = prevA - 1
    --             end
    --         end
    --         table.insert(trimmedRanges, {
    --             _a,
    --             _b,
    --         })
    --     end
    -- end
    -- for t, range in ipairs(trimmedRanges) do
    --     local inRange = range[2] - range[1] + 1
    --     print(range[1] .. "-" .. range[2] .. "->" .. inRange)
    --     _countValid = _countValid + inRange
    -- end

    return freshIngredientCount, _countValid
end

assert(processInput(testInput) == 3)
assert(select(2, processInput(testInput)) == 14)

print(processInput(ParseLinesIntoTable("day-05-input.txt")))
