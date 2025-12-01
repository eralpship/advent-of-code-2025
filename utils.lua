---@param fileName string
---@return table
function ParseTextInput(fileName)
    local file = io.open(fileName, "r")
    if not file then
        error("File not found")
    end

    local content = file:read("*a")
    --- split by newline into table
    local lines = {}
    for line in content:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    file:close()

    return lines
end
