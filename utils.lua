---@param fileName string
---@return table<string>
function ParseLinesIntoTable(fileName)
    local file = io.open(fileName, "r")
    if not file then
        error("File not found")
    end

    local lines = {}
    for line in file:lines() do
        table.insert(lines, line)
    end
    file:close()

    return lines
end

---@param fileName string
---@return table<string>
function ParseSeparatedByComma(fileName)
    local file = io.open(fileName, "r")
    if not file then
        error("File not found")
    end

    local content = file:read("*a")
    --- split by separator into table
    local lines = {}
    for item in content:gmatch("[^,]+") do
        table.insert(lines, item)
    end
    file:close()

    return lines
end
