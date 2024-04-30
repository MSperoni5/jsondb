local new_FileManager = function()
    local self = {}

    -- TODO: Optimise the file manager with the cache system. Use self.getFile as little as possible

    self.path = GetResourcePath(GetCurrentResourceName()) .. "/database/"

    self.getPath = function(name)
        return self.path .. name .. ".json"
    end

    self.getFile = function(path, read)
        if ErrorsHandler.formatIsCorrect(path, "string") and ErrorsHandler.formatIsCorrect(read, "boolean") then
            local file = io.open(path, read and "r" or "w")
            if file then
                return file
            end
        end
        return nil
    end

    self.doesFileExist = function(name)
        if ErrorsHandler.formatIsCorrect(name, "string") then
            local file = self.getFile(self.getPath(name), true)
            if file ~= nil then
                io.close(file)
                return true
            end
        end
        return false
    end

    self.readFile = function(name)
        if ErrorsHandler.formatIsCorrect(name, "string") and self.doesFileExist(name) then
            local file = self.getFile(self.getPath(name), true)
            if file ~= nil then
                local content = json.decode(file:read("*a"))
                io.close(file)
                return content
            end
        end
        return nil
    end

    self.writeFile = function(name, content)
        if ErrorsHandler.formatIsCorrect(name, "string") and ErrorsHandler.formatIsCorrect(content, "table") and self.doesFileExist(name) then
            local file = self.getFile(self.getPath(name), false)
            if file ~= nil then
                file:write(json.encode(content))
                io.close(file)
                return true
            end
        end
        return false
    end

    self.deleteFile = function(name)
        if ErrorsHandler.formatIsCorrect(name, "string") and self.doesFileExist(name) then
            os.remove(self.getPath(name))
            return true
        end
        return false
    end

    self.createFile = function(name, default)
        if ErrorsHandler.formatIsCorrect(name, "string") and ErrorsHandler.formatIsCorrect(default, "table") and not self.doesFileExist(name) then
            local file = self.getFile(self.getPath(name), false)
            if file ~= nil then
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