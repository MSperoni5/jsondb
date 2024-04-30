jsondb.createTable("Test", true)
jsondb.insertIntoTable("Test", "char:0000", { name = "John" })
jsondb.updateSingleInTable("Test", { primaryKey = "char:0000" }, { name = "Dio cane" })
print(json.encode(jsondb.selectAllFromTable("Test", { primaryKey = "char:0000" })))