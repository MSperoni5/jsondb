local new_FileManager = function()
    local self = {}

    self.path = GetResourcePath(GetCurrentResourceName()) .. "/database/"

    self.doesFileExist = function(name)
        if ErrorsHandler.isFormatCorrect(name, "string") then
            local file = io.open(self.path .. name .. ".json", "r")
            if file then
                io.close(file)
                return true
            end
        end
        return false
    end

    self.deleteFile = function(name)
        if ErrorsHandler.isFormatCorrect(name, "string") and self.doesFileExist(self.path, name) then
            os.remove(self.path .. name .. ".json")
            return true
        end
        return false
    end

    self.createFile = function(name, default)
        if ErrorsHandler.isFormatCorrect(name, "string") and ErrorsHandler.isFormatCorrect(default, "table") and not self.doesFileExist(self.path, name) then
            local file = io.open(self.path .. name .. ".json", "w")
            if file then
                file:write(json.encode(default or {}))
                io.close(file)
                return true
            end
        end
        return false
    end

    return self
end

FileManager = new_FileManager()