local new_ErrorsHandler = function()
    local self = {}

    self.error = function(message)
        print("^1[ERROR] " .. message .. "^0")
    end

    self.isFormatCorrect = function(value, format)
        if type(value) ~= format then
            self.error("The value is not in the correct format. Expected: " .. format .. ", received: " .. type(value))
            return false
        end
        return true
    end

    return self
end

ErrorsHandler = new_ErrorsHandler()