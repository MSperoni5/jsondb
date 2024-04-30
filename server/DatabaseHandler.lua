local new_DatabaseHandler = function()
    local self = {}

    self.tableFormatIsCorrectAndShouldExist = function(name, shouldExist)
        if ErrorsHandler.formatIsCorrect(name, "string") and ErrorsHandler.formatIsCorrect(shouldExist, "boolean") then
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
        if self.tableFormatIsCorrectAndShouldExist(name, true) then
            FileManager.deleteFile(name)
            return true
        end
        return false
    end
        
    self.createTable = function(name, primaryKey)
        if self.tableFormatIsCorrectAndShouldExist(name, false) and ErrorsHandler.formatIsCorrect(primaryKey, "boolean") then
            FileManager.createFile(name, { primaryKey = primaryKey, data = {} })
            return true
        end
        return false
    end

    -- TODO: Implement caching system when created
    self.updateIntoTable = function(name, conditions, newData, single)
        if self.tableFormatIsCorrectAndShouldExist(name, true) and ErrorsHandler.formatIsCorrect(conditions, "table") and ErrorsHandler.tableIsNotEmpty(conditions) and ErrorsHandler.formatIsCorrect(newData, "table") and ErrorsHandler.formatIsCorrect(single, "boolean") then
            local dbTable = FileManager.readFile(name)
            if ErrorsHandler.formatIsCorrect(dbTable, "table") then
                for primaryKey, data in pairs(dbTable.data) do
                    if dbTable.primaryKey and (conditions["primaryKey"] and (primaryKey == conditions["primaryKey"]) or true) or true then
                        local found = true
                        for key, value in pairs(conditions) do
                            if key ~= "primaryKey" and data[key] ~= value then
                                found = false
                                break
                            end
                        end
                        if found then
                            dbTable.data[primaryKey] = newData
                            if single then
                                FileManager.writeFile(name, dbTable)
                                return true
                            end
                        end
                    end
                end
                FileManager.writeFile(name, dbTable)
                return true
            end
        end
        return false
    end

    -- TODO: Implement caching system when created
    self.selectFromTable = function(name, conditions, single)
        if self.tableFormatIsCorrectAndShouldExist(name, true) and ErrorsHandler.formatIsCorrect(conditions, "table") and ErrorsHandler.tableIsNotEmpty(conditions) and ErrorsHandler.formatIsCorrect(single, "boolean") then
            local dbTable = FileManager.readFile(name)
            if ErrorsHandler.formatIsCorrect(dbTable, "table") then
                local results = {}
                for primaryKey, data in pairs(dbTable.data) do
                    if dbTable.primaryKey and (conditions["primaryKey"] and (primaryKey == conditions["primaryKey"]) or true) or true then
                        local found = true
                        for key, value in pairs(conditions) do
                            if key ~= "primaryKey" and data[key] ~= value then
                                found = false
                                break
                            end
                        end
                        if found then
                            if single then
                                return data
                            else
                                table.insert(results, data)
                            end
                        end
                    end
                end
                if #results > 0 then
                    return results
                end
            end
        end
        return nil
    end

    -- TODO: Implement caching system when created
    self.deleteFromTable = function(name, conditions, single)
        if self.tableFormatIsCorrectAndShouldExist(name, true) and ErrorsHandler.formatIsCorrect(conditions, "table") and ErrorsHandler.tableIsNotEmpty(conditions) and ErrorsHandler.formatIsCorrect(single, "boolean") then
            local dbTable = FileManager.readFile(name)
            if ErrorsHandler.formatIsCorrect(dbTable, "table") then
                for primaryKey, data in pairs(dbTable.data) do
                    if dbTable.primaryKey and (conditions["primaryKey"] and (primaryKey == conditions["primaryKey"]) or true) or true then
                        local found = true
                        for key, value in pairs(conditions) do
                            if key ~= "primaryKey" and data[key] ~= value then
                                found = false
                                break
                            end
                        end
                        if found then
                            dbTable.data[primaryKey] = nil
                            if single then
                                FileManager.writeFile(name, dbTable)
                                return true
                            end
                        end
                    end
                end
                FileManager.writeFile(name, dbTable)
                return true
            end
        end
        return false
    end

    -- TODO: Implement caching system when created
    self.insertIntoTable = function(name, primaryKey, data)
        if self.tableFormatIsCorrectAndShouldExist(name, true) and ErrorsHandler.formatIsCorrect(data, "table") then
            local dbTable = FileManager.readFile(name)
            if ErrorsHandler.formatIsCorrect(dbTable, "table") then
                if dbTable.primaryKey then
                    if primaryKey ~= nil then
                        primaryKey = tostring(primaryKey)
                        if dbTable.data[primaryKey] == nil then
                            dbTable.data[primaryKey] = data
                            FileManager.writeFile(name, dbTable)
                            return true
                        else
                            ErrorsHandler.error("The primary key " .. primaryKey .. " in table " .. name .. " already exists.")
                        end
                    else
                        ErrorsHandler.error("The table " .. name .. " requires a primary key.")
                    end
                else
                    table.insert(dbTable.data, data)
                    FileManager.writeFile(name, dbTable)
                    return true
                end
            end
        end
        return false
    end

    return self
end

DatabaseHandler = new_DatabaseHandler()