local new_ErrorsHandler = function()
    local self = {}

    self.error = function(message)
        print("^1[ERROR] " .. message .. "^0")
    end

    self.isFormatCorrect = function(value, format)
        if value == nil or type(value) ~= format then
            self.error("The value is not in the correct format. Expected: " .. format .. ", received: " .. value and type(value) or "nil")
            return false
        end
        return true
    end

    self.isTableEmpty = function(table)
        for _, __ in pairs(table) do
            return true
        end
        return false
    end

    return self
end

ErrorsHandler = new_ErrorsHandler()