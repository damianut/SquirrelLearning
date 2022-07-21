// (Code from https://gitlab.com/GothicMultiplayerTeam/modules/sqlite)
class PlayerDBHandling {
    _db = null;
    _dbName = null;
    _pwd = null;

    constructor (dbName) {
        _dbName = dbName;
		_db = SQLite3(dbName);
    }
    
    function close () {
        return _db.isOpen ? (SQLITE_OK == _db.close()) : false;
    }
    
    function open () {
        return _db.isOpen ? false : (SQLITE_OK == _db.open(_dbName));
    }

    function createDatabaseStructure() {
        if(_db) {
            _db.execute("CREATE TABLE IF NOT EXISTS characters (id INTEGER, name TEXT, pwd TEXT, hp INTEGER, maxHP integer, mana INTEGER, maxMana INTEGER, posX REAL, posY REAL, posZ REAL, PRIMARY KEY(id AUTOINCREMENT), UNIQUE(name))")
        }
    }
    
    function createCharacter (id, login, pwd) {
        if(_db) {
            local stmt = _db.prepare(@"INSERT INTO characters (name, pwd, hp, maxHP, mana, maxMana, posX, posY, posZ) VALUES (:name, :pwd, :hp, :maxhp, :mana, :maxmana, :posX, :posY, :posZ)")
            if(!stmt) {
                print("Cannot create prepared statement!")
                print(_db.lastErrorMsg)
            }
            else {
                stmt.bindValue(":name", login)
                stmt.bindValue(":pwd", pwd)
                stmt.bindValue(":hp", 40)
                stmt.bindValue(":maxhp", 40)
                stmt.bindValue(":mana", 10)
                stmt.bindValue(":maxmana", 10)
                stmt.bindValue(":posX", 0)
                stmt.bindValue(":posY", 0)
                stmt.bindValue(":posZ", 0)

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

    function saveCharacter(id, name) {
        if(_db) {
            local stmt = _db.prepare(@"UPDATE characters SET hp=:hp, maxHP=:maxhp, mana=:mana, maxMana=:maxmana, posX=:posX, posY=:posY, posZ=:posZ WHERE name=:name")

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
                stmt.bindValue(":name", name)

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

    function loadCharacter(id, playerName) {
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
    
    function comparePwd (playerName, pwdInput) {
        local result = false;
        _db.execute("SELECT pwd FROM characters WHERE name='" + playerName + "'", function (tbl) { 
            result = (tbl.pwd == md5(pwdInput));
        }.bindenv(PlayerDBHandling));          
        
        return result;
    }
    
    function getPlayerData (playerName) {
        local playerData = {};
        _db.execute("SELECT name, hp, maxHP, mana, maxMana, posX, posY, posZ FROM characters WHERE name='" + playerName + "'", function (tbl) {
            playerData = tbl;
        }.bindenv(PlayerDBHandling));
        
        return playerData;
    }
}
