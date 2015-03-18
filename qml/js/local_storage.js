.import QtQuick.LocalStorage 2.0 as LS

function constructDB()
{
	var db = LS.LocalStorage.openDatabaseSync(
			"vk-notification-daemon-db",
			"1.0",
			"The vk notification daemon main database",
			1000000);

	db.transaction(function(tx) {
		tx.executeSql('CREATE TABLE IF NOT EXISTS Auth(key TEXT UNIQUE, value TEXT)');
	})
}

function insert(key, value)
{
	var db = LS.LocalStorage.openDatabaseSync(
			"vk-notification-daemon-db",
			"1.0",
			"The vk notification daemon main database",
			1000000);

	db.transaction(function(tx) {
		tx.executeSql('INSERT INTO Auth VALUES(?, ?)', [ key, value ]);
	})
}

function printDB()
{
	var db = LS.LocalStorage.openDatabaseSync(
			"vk-notification-daemon-db",
			"1.0",
			"The vk notification daemon main database",
			1000000);

	db.transaction(function(tx) {
		var rs = tx.executeSql('SELECT * FROM Auth');
		var r = "\ndb contents:"
		for(var i = 0; i < rs.rows.length; i++) {
			r += "\n" + rs.rows.item(i).key + " -> " + rs.rows.item(i).value;
		}
		console.log(r)
	})
}

function clearDB()
{
	var db = LS.LocalStorage.openDatabaseSync(
			"vk-notification-daemon-db",
			"1.0",
			"The vk notification daemon main database",
			1000000);

	db.transaction(function(tx) {
		tx.executeSql('DROP TABLE IF EXISTS Auth');
	})
}

