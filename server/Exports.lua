local new_Exports = function()
    local self = {}

    self.deleteTable = DatabaseHandler.deleteTable

    self.createTableWithPrimaryKey = function(name)
        return DatabaseHandler.createTable(name, true)
    end

    self.createTableWithoutPrimaryKey = function(name)
        return DatabaseHandler.createTable(name, false)
    end

    self.deleteAllFromTable = function(dbTable, conditions)
        return DatabaseHandler.deleteFromTable(dbTable, conditions, false)
    end

    self.deleteSingleFromTable = function(dbTable, conditions)
        return DatabaseHandler.deleteFromTable(dbTable, conditions, true)
    end

    self.insertIntoTable = DatabaseHandler.insertIntoTable
    
    self.updateAllInTable = function(dbTable, conditions, data)
        return DatabaseHandler.updateIntoTable(dbTable, conditions, data, false)
    end

    self.updateSingleInTable = function(dbTable, conditions, data)
        return DatabaseHandler.updateIntoTable(dbTable, conditions, data, true)
    end

    self.selectAllFromTable = function(dbTable, conditions)
        return DatabaseHandler.selectFromTable(dbTable, conditions, false)
    end

    self.selectSingleFromTable = function(dbTable, conditions)
        return DatabaseHandler.selectFromTable(dbTable, conditions, true)
    end

    return self
end

Exports = new_Exports()

for name, data in pairs(Exports) do
    exports(name, data)
end