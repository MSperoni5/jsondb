local new_Exports = function()
    local self = {}

    return self
end

Exports = new_Exports()

for name, data in pairs(Exports) do
    exports(name, data)
end