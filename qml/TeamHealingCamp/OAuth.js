.import QtQuick.LocalStorage 2.0 as Sql

function urlChanged(url) {
    var authorized = false;
    var mUrl = url.toString();
    var token = "";
    if (mUrl.indexOf("https://www.facebook.com") > -1) {
        var query = mUrl.substring(mUrl.indexOf('#') + 1);
        console.log("query: " + query)
        var vars = query.split("&");

        for (var i=0;i<vars.length;i++) {
            console.log("vars: " + vars[i])
            var pair = vars[i].split("=");
            if (pair[0] == "access_token") {
                authorized = true;
                token = pair[1];
                console.log("Found token: " + token)
                saveToken(token);
            }
        }
    }
    if (authorized) {
        stackOAuth.token = token;
        stackOAuth.state = "AuthDone";
    }
    console.log("author: " + authorized)
    console.log("toekn: "  + token)
}

function saveToken(token) {
    console.log("Saving...")
    var db = Sql.LocalStorage.openDatabaseSync("Token", "1.0", "the token", 1);
    var dataStr = "INSERT INTO Token VALUES(?)";
    var data = [token];
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Token(token TEXT)');
        tx.executeSql(dataStr, data);
    });
}

function deleteToken() {
    var dataStr  =  "DELETE * FROM Token"
    var db = Sql.LocalStorage.openDatabaseSync("Token", "1.0", "the token", 1);

    db.transaction(function(tx) {
        tx.executeSql('DROP TABLE Token');

    })

}

function checkToken() {
    var db = Sql.LocalStorage.openDatabaseSync("Token", "1.0", "the token", 1);
    var dataStr = "SELECT * FROM Token";
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Token(token TEXT)');
        var rs = tx.executeSql(dataStr);
        if (rs.rows.item(0)) {
            stackOAuth.token = rs.rows.item(0).token
            stackOAuth.state = "AuthDone"
            console.log("Auth done...")
        } else {
            stackOAuth.state = "Login"
            console.log("Logging in....")
        }
    });
}
