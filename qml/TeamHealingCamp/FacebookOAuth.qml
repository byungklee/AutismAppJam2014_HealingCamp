import QtQuick 2.0
import QtWebKit 3.0
import "OAuth.js" as OAuth

Rectangle {
    id: root
    height: 750
    width: 500
    signal authorlized

    Text {
        id: nextState
        visible: false
        anchors.centerIn: parent
        text: "Log in successful!"
    }


    Item {
        id: stackOAuth
        property string nextState: "AuthDone"
        anchors.fill: parent
        Component.onCompleted: OAuth.checkToken()
        property string token: ""
        property string scope: "user_groups,photo_upload,publish_actions"
        WebView {
            id: loginView
            visible: false
            anchors.fill: parent
            onUrlChanged: OAuth.urlChanged(url)
        }
        Rectangle {
            height: 50
            width: parent.width
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            Text {
                text: loginView.url
            }
        }

        states: [
            State {
                name: "Login"
                PropertyChanges {
                    target: loginView
                    visible: true
                    url:"https://www.facebook.com/dialog/oauth?client_id=797694290242643&redirect_uri=https://www.facebook.com/connect/login_success.html&response_type=token&scope=photo_upload,publish_actions,user_groups"
                }
            },
            State {
                name: "AuthDone"
                PropertyChanges {
                    target: loginView
                    visible: false
                    opacity: 0
                }
                PropertyChanges {
                    target: nextState
                    visible: true
                }
            }
        ]
        onStateChanged: {
            if(stackOAuth.state == "AuthDone") {
                root.authorlized()
            }
        }
    }


    function webRequest(requestUrl, callback){
        var request = new XMLHttpRequest();
        console.log("webRequest: ", requestUrl)
        request.onreadystatechange=function() {
            var response;
            if(request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    response = JSON.parse(request.responseText);

                }else {
                    console.log("Server: " + request.status + "- " + request.statusText);
                    response = ""
                }
                callback(response, request, requestUrl)
            }
        }
        //var encodedString = encodeURIComponent(postString);
        request.open("GET", requestUrl, true); // only async supported
        //var requestString = "text=" + encodedString;
        request.send();
    }

    function postMessageOnFacebook(message) {
        var http = new XMLHttpRequest()
                var url = "https://graph.facebook.com/byungki.lee.507/feed?"; //must be replaced with id
                var params = "message=" + message +"&access_token=" + stackOAuth.token;
                http.open("POST", url, true);
        var response
                 http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                http.setRequestHeader("Content-length", params.length);
                http.setRequestHeader("Connection", "close");

                http.onreadystatechange = function() { // Call a function when the state changes.
                            if (http.readyState == 4) {
                                if (http.status == 200) {
                                    response = JSON.parse(request.responseText);
                                    console.log("ok")
                                } else {
                                    console.log("error: " + http.status)
                                }
                            }
                        }
                http.send(params);
        console.log(response)
    }
}
