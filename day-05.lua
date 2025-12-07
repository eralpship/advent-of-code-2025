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
    -- local countFreshInRanges = 0
    for u, v in pairs(ingredients) do
        print(u, v)
    end
    return freshIngredientCount
end

assert(processInput(testInput) == 3)
-- print(processInput(ParseLinesIntoTable("day-05-input.txt")))
