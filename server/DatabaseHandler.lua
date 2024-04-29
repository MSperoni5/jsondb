local new_DatabaseHandler = function()
    local self = {}

    self.doesTableFormatCorrectAndShouldExist = function(name, shouldExist)
        if ErrorsHandler.isFormatCorrect(name, "string") and ErrorsHandler.isFormatCorrect(shouldExist, "boolean") then
            if shouldExist then
                if FileManager.doesFileExist(name) then
                    return true
                else
                    ErrorsHandler.error("The table " .. name .. " does not exist.")
                end
            else
                if not FileManager.doesFileExist(name) then
                    return true
                else
                    ErrorsHandler.error("The table " .. name .. " already exists.")
                end
            end
        end
        return false
    end

    self.deleteTable = function(name)
        if self.doesTableFormatCorrectAndShouldExist(name, true) then
            FileManager.deleteFile(name)
            return true
        end
        return false
    end
        
    self.createTable = function(name, primaryKey)
        if self.doesTableFormatCorrectAndShouldExist(name, false) and ErrorsHandler.isFormatCorrect(primaryKey, "boolean") then
            FileManager.createFile(name, { primaryKey = primaryKey, data = {} })
            return true
        end
        return false
    end

    self.updateInTable = function(name, conditions, data, single)
        if self.doesTableFormatCorrectAndShouldExist(name, true) and ErrorsHandler.isFormatCorrect(conditions, "table") and ErrorsHandler.isFormatCorrect(data, "table") and ErrorsHandler.isFormatCorrect(single, "boolean") then
            -- TODO: Implement as soon as possible
        end
        return false
    end

    self.selectFromTable = function(name, conditions, single)
        if self.doesTableFormatCorrectAndShouldExist(name, true) and ErrorsHandler.isFormatCorrect(conditions, "table") and ErrorsHandler.isFormatCorrect(single, "boolean") then
            -- TODO: Implement as soon as possible
        end
        return false
    end

    self.deleteFromTable = function(name, conditions, single)
        if self.doesTableFormatCorrectAndShouldExist(name, true) and ErrorsHandler.isFormatCorrect(conditions, "table") and ErrorsHandler.isFormatCorrect(single, "boolean") then
            -- TODO: Implement as soon as possible
        end
        return false
    end

    self.insertIntoTable = function(name, primaryKey, data)
        if self.doesTableFormatCorrectAndShouldExist(name, true) and ErrorsHandler.isFormatCorrect(data, "table") then
            local table = FileManager.readFile(name)
            if ErrorsHandler.isFormatCorrect(table, "table") then
                if table.primaryKey then
                    if primaryKey ~= nil then
                        primaryKey = tostring(primaryKey)
                        if table[primaryKey] == nil then
                            table[primaryKey] = data
                            FileManager.writeFile(name, table)
                            return true
                        else
                            ErrorsHandler.error("The primary key already exists.")
                        end
                    else
                        ErrorsHandler.error("The table " .. name .. " requires a primary key.")
                    end
                else
                    table.insert(table.data, data)
                    FileManager.writeFile(name, table)
                    return true
                end
            end
        end
        return false
    end

    return self
end

DatabaseHandler = new_DatabaseHandler()