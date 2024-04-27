local new_DatabaseHandler = function()
    local self = {}

    -- TODO: SELECTWHERE
    -- TODO: UPDATEWHERE
    -- TODO: DELETEWHERE

    self.doesTableExist = function(name)
        if ErrorsHandler.isFormatCorrect(name, "string") then
            if FileManager.doesFileExist(name) then
                return true
            else
                ErrorsHandler.error("The table " .. name .. " does not exist.")
            end
        end
        return false
    end

    self.deleteFromTable = function(name, primaryKey, ...)
        -- TODO: ... sono where and value all'infinito quindi where deve essere una parte di table.data e value il valore da confrontare
        if self.doesTableExist(name) then
            local table = FileManager.readFile(name)
            if table then
                if primaryKey then
                    if table.primaryKey and table[primaryKey] then
                        table[primaryKey] = nil
                        FileManager.writeFile(name, table)
                        return true
                    else
                        ErrorsHandler.error("The primary key does not exist.")
                    end
                else
                    -- TODO: Qua fare quello che c'è nel primo todo con ... e confrontare i valori
                end
            else
                ErrorsHandler.error("The table " .. name .. " could not be opened.")
            end
        end
        return false
    end

    self.insertIntoTable = function(name, primaryKey, data)
        if self.doesTableExist(name) then
            if data then
                local table = FileManager.readFile(name)
                if table then
                    if table.primaryKey then
                        if primaryKey then
                            if not table[primaryKey] then
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
                else
                    ErrorsHandler.error("The table " .. name .. " could not be opened.")
                end
            else
                ErrorsHandler.error("The data is empty.")
            end
        end
        return false
    end

    self.deleteTable = function(name)
        if self.doesTableExist(name) then
            FileManager.deleteFile(name)
            return true
        end
        return false
    end
        
    self.createTable = function(name, primaryKey)
        if self.doesTableExist(name) and ErrorsHandler.isFormatCorrect(primaryKey, "boolean") then
            FileManager.createFile(name, { primaryKey = primaryKey, data = {} })
            return true
        end
        return false
    end

    return self
end

DatabaseHandler = new_DatabaseHandler()