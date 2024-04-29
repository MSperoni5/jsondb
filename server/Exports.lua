local new_Exports = function()
    local self = {}

    self.deleteTable = DatabaseHandler.deleteTable

    self.createTable = DatabaseHandler.createTable

    self.deleteAllFromTable = function(table, conditions)
        return DatabaseHandler.deleteFromTable(table, conditions, false)
    end

    self.deleteSingleFromTable = function(table, conditions)
        return DatabaseHandler.deleteFromTable(table, conditions, true)
    end

    self.insertIntoTable = DatabaseHandler.insertIntoTable
    
    self.updateAllInTable = function(table, conditions, data)
        return DatabaseHandler.updateInTable(table, conditions, data, false)
    end

    self.updateSingleInTable = function(table, conditions, data)
        return DatabaseHandler.updateInTable(table, conditions, data, true)
    end

    self.selectAllFromTable = function(table, conditions)
        return DatabaseHandler.selectFromTable(table, conditions, false)
    end

    self.selectSingleFromTable = function(table, conditions)
        return DatabaseHandler.selectFromTable(table, conditions, true)
    end

    return self
end

Exports = new_Exports()

for name, data in pairs(Exports) do
    exports(name, data)
end