local new_FilesHandler = function()
    local self = {}

    -- TODO: Optimise the file manager with the cache system. Use self.getFile as little as possible

    self.path = GetResourcePath(GetCurrentResourceName()) .. "/database/"

    self.getPath = function(name)
        return self.path .. name .. ".json"
    end

    -- TODO: Terminate the implementation of the cache system
    -- self.newGetFile = function(name, read)
    --     if ErrorsHandler.formatIsCorrect(name, "string") and ErrorsHandler.formatIsCorrect(read, "boolean") then
    --         if not CacheHandler.isInCache(name) then
    --             local file = self.getFile(name, read)
    --             if file ~= nil then
    --                 local content = json.decode(file:read("*a"))
    --                 io.close(file)
    --                 CacheHandler.addIntoCache(name, content)
    --                 return content
    --             end
    --         else
    --             return CacheHandler.getFromCache(name)
    --         end
    --     end
    --     return nil
    -- end

    self.getFile = function(name, read)
        if ErrorsHandler.formatIsCorrect(name, "string") and ErrorsHandler.formatIsCorrect(read, "boolean") then
            local path = self.getPath(name)
            return io.open(path, read and "r" or "w")
        end
        return nil
    end

    self.doesFileExist = function(name)
        if ErrorsHandler.formatIsCorrect(name, "string") then
            local file = self.getFile(name, true)
            if file ~= nil then
                io.close(file)
                return true
            end
        end
        return false
    end

    self.readFile = function(name)
        if ErrorsHandler.formatIsCorrect(name, "string") and self.doesFileExist(name) then
            local file = self.getFile(name, true)
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
            local file = self.getFile(name, false)
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
            local file = self.getFile(name, false)
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

FilesHandler = new_FilesHandler()