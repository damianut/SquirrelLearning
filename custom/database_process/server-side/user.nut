// (Code from https://gitlab.com/GothicMultiplayerTeam/modules/sqlite)
class characterSaver
{
    _db = null;

    constructor(dbName) {
		_db = SQLite3(dbName);
    }

    function createDatabaseStructure() {
        if(_db) {
            _db.execute("CREATE TABLE IF NOT EXISTS characters (id INTEGER, name TEXT, hp INTEGER, maxHP integer, mana INTEGER, maxMana INTEGER, posX REAL, posY REAL, posZ REAL, PRIMARY KEY(id AUTOINCREMENT), UNIQUE(name))")
        }
    }
    
    function createCharacter (id, login, pwd) {
        if(_db) {
            local stmt = _db.prepare("INSERT INTO characters (name, hp, maxHP, mana, maxMana, posX, posY, posZ) VALUES (:name, :hp, :maxhp, :mana, :maxmana, :posX, :posY, :posZ)")
            if(!stmt) {
                print("Cannot create prepared statement!")
                print(_db.lastErrorMsg)
            }
            else {
                local pos = getPlayerPosition(id)
                stmt.bindValue(":hp", 100)
                stmt.bindValue(":maxhp", 100)
                stmt.bindValue(":mana", 100)
                stmt.bindValue(":maxmana", 100)
                stmt.bindValue(":posX", 68)
                stmt.bindValue(":posY", -74)
                stmt.bindValue(":posZ", -211)
                stmt.bindValue(":name", login)

                _db.execute("BEGIN")
                local result = stmt.step()

                if(result == SQLITE_DONE)
                    _db.execute("COMMIT")
                else {
                    _db.execute("ROLLBACK")
                    error(format("Cannot insert character information into database! %s", _db.LastErrorMsg))
                }
            }
        }
    }

    function saveCharacter(id) {
        if(_db) {
            local stmt = _db.prepare(@"INSERT INTO characters (name, hp, maxHP, mana, maxMana, posX, posY, posZ) VALUES 
(:name, :hp, :maxhp, :mana, :maxmana, :posX, :posY, :posZ) ON CONFLICT (name) DO UPDATE SET hp=:hp, maxHP=:maxhp, mana=:mana, maxMana=:maxmana, posX=:posX, posY=:posY, posZ=:posZ")

            if(!stmt) {
                print("Cannot create prepared statement!")
                print(_db.lastErrorMsg)
            }
            else {
                local pos = getPlayerPosition(id)
                stmt.bindValue(":hp", getPlayerHealth(id))
                stmt.bindValue(":maxhp", getPlayerMaxHealth(id))
                stmt.bindValue(":mana", getPlayerMana(id))
                stmt.bindValue(":maxmana", getPlayerMaxMana(id))
                stmt.bindValue(":posX", pos.x)
                stmt.bindValue(":posY", pos.y)
                stmt.bindValue(":posZ", pos.z)
                stmt.bindValue(":name", getPlayerName(id))

                _db.execute("BEGIN")
                local result = stmt.step()

                if(result == SQLITE_DONE)
                    _db.execute("COMMIT")
                else {
                    _db.execute("ROLLBACK")
                    error(format("Cannot insert character information into database! %s", _db.LastErrorMsg))
                }
            }
        }
    }

    function loadCharacter(id) {
        local playerName = getPlayerName(id)
        local result = checkPlayerExistsInDatabase(playerName)
        if(!result)
            error(format("Player '%s' doesn't exists in database!", playerName))
        else {
            _db.execute(format(@"BEGIN; 
SELECT * FROM characters WHERE name='%s'; 
COMMIT", playerName), function(data) {
                setPlayerHealth(id, data["hp"].tointeger())
                setPlayerMaxHealth(id, data["maxHP"].tointeger())
                setPlayerMana(id, data["mana"].tointeger())
                setPlayerMaxMana(id, data["maxMana"].tointeger())
                setPlayerPosition(id, data["posX"].tofloat(), data["posY"].tofloat(), data["posZ"].tofloat())
            })
        }
    }

    function checkPlayerExistsInDatabase(playerName) {
        local stmt = _db.prepare("SELECT count(*) FROM characters WHERE name=?")
        if(!stmt) {
            error(_db.lastErrorMsg)
            return false
        }
        else {
            stmt.bindValue(1, playerName)
            stmt.step()

            if(stmt.getColumn(0, SQLITE_INTEGER) == 0)
                return false
            else
                return true
        }
    }
}
