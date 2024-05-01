local new_CacheHandler = function()
    local self = {}

    self.data = {}

    self.isInCache = function(name)
        return self.data[name] ~= nil
    end

    self.addIntoCache = function(name, data)
        if not self.isInCache(name) then
            self.data[name] = data
            return true
        end
        return false
    end

    self.removeFromCache = function(name)
        if self.isInCache(name) then
            self.data[name] = nil
            return true
        end
        return false
    end

    self.getFromCache = function(name)
        if self.isInCache(name) then
            return self.data[name]
        end
        return nil
    end

    self.updateCache = function(name, data)
        if self.isInCache(name) then
            self.data[name] = data
            return true
        end
        return false
    end

    self.clearCache = function()
        self.data = {}
    end

    return self
end

CacheHandler = new_CacheHandler()