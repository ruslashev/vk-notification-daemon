.import QtQuick.LocalStorage 2.0 as LS

function getDB()
{
	return LS.LocalStorage.openDatabaseSync(
			"vk-notification-daemon-db",
			"1.0",
			"The vk notification daemon main database",
			1000000);
}

function constructDB()
{
	getDB().transaction(function(tx) {
		tx.executeSql('CREATE TABLE IF NOT EXISTS Auth(key TEXT UNIQUE, value TEXT)');
	})
}

function insert(key, value)
{
	getDB().transaction(function(tx) {
		tx.executeSql('INSERT OR REPLACE INTO Auth VALUES(?, ?)', [ key, value ]);
	})
}

function select(key)
{
	var result = -1;
	getDB().transaction(function(tx) {
		var rs = tx.executeSql('SELECT * FROM Auth WHERE key=?', key);
		if (rs.rows.length !== 0)
			result = rs.rows.item(0).value;
	})
	return result;
}

function printDB()
{
	getDB().transaction(function(tx) {
		var rs = tx.executeSql('SELECT * FROM Auth');
		console.log("db contents:");
		for (var i = 0; i < rs.rows.length; i++) {
			console.log(rs.rows.item(i).key + " -> " + rs.rows.item(i).value);
		}
	})
}

function clearDB()
{
	getDB().transaction(function(tx) {
		tx.executeSql('DROP TABLE IF EXISTS Auth');
	})
}

