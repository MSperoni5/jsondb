local new_ErrorsHandler = function()
    local self = {}

    self.error = function(message)
        print("^1[ERROR] " .. message .. "^0")
    end

    self.formatIsCorrect = function(value, format)
        if value == nil or type(value) ~= format then
            self.error("The value is not in the correct format. Expected: " .. format .. ", received: " .. value and type(value) or "nil")
            return false
        end
        return true
    end

    self.getFile = function(path, read)
        if self.formatIsCorrect(path, "string") and self.formatIsCorrect(read, "boolean") then
            local file = io.open(path, read and "r" or "w")
            if file then
                return file
            else
                self.error("The file " .. path .. " could not be opened.")
            end
        end
        return nil
    end

    self.tableIsNotEmpty = function(table)
        for _, __ in pairs(table) do
            return true
        end
        self.error("The table is empty.")
        return false
    end

    return self
end

ErrorsHandler = new_ErrorsHandler()