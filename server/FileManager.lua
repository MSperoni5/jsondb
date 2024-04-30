local new_FileManager = function()
    local self = {}

    -- TODO: Optimise the file manager with the cache system. Use ErrorsHandler.getFile as little as possible

    self.path = GetResourcePath(GetCurrentResourceName()) .. "/database/"

    self.doesFileExist = function(name)
        if ErrorsHandler.formatIsCorrect(name, "string") then
            local file = ErrorsHandler.getFile(self.path .. name .. ".json", true)
            if file then
                io.close(file)
                return true
            end
        end
        return false
    end

    self.readFile = function(name)
        if ErrorsHandler.formatIsCorrect(name, "string") then
            if self.doesFileExist(name) then
                local file = ErrorsHandler.getFile(self.path .. name .. ".json", true)
                if file then
                    local content = json.decode(file:read("*a"))
                    io.close(file)
                    return content
                end
            end
        end
        return nil
    end

    self.writeFile = function(name, content)
        if ErrorsHandler.formatIsCorrect(name, "string") and ErrorsHandler.formatIsCorrect(content, "table") then
            if self.doesFileExist(name) then
                local file = ErrorsHandler.getFile(self.path .. name .. ".json", false)
                if file then
                    file:write(json.encode(content))
                    io.close(file)
                    return true
                end
            end
        end
        return false
    end

    self.deleteFile = function(name)
        if ErrorsHandler.formatIsCorrect(name, "string") and self.doesFileExist(self.path, name) then
            -- TODO: Check that os.remove works
            os.remove(self.path .. name .. ".json")
            return true
        end
        return false
    end

    self.createFile = function(name, default)
        if ErrorsHandler.formatIsCorrect(name, "string") and ErrorsHandler.formatIsCorrect(default, "table") and not self.doesFileExist(self.path, name) then
            local file = ErrorsHandler.getFile(self.path .. name .. ".json", false)
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