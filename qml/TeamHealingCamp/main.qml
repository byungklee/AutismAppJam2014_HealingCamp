import QtQuick 2.0

Item {
    id: root
    width: 1200
    height: 700

    Loader {
        id: __MainLoader
        anchors.fill: parent
        z: 1
        sourceComponent: __InitialComponent
    }
    Loader {
        id: __AppLoader
        anchors.fill: parent
        z: 2
        visible: false
        onLoaded: {
            __AppLoader.item.open()
        }
    }
    Component {
        id: __InitialComponent
        InitialScreen {
            id: initialScreen
        }
    }
    Component {
        id: __MainMenu
        MainMenuScreen {
            id: mainMenuScreen
        }
    }
    Component.onCompleted: {
       timer.restart()
    }

    state: "initial"


    states:[
        State {
            name: "initial"
            // PropertyChanges{ target: __MainLoader; sourceComponent: __InitialComponent}
        },
        State {
            name: "mainmenu"
            PropertyChanges{ target: __MainLoader;sourceComponent: undefined}
            PropertyChanges{ target: __AppLoader; sourceComponent: __MainMenu; visible: true}
        }
    ]

    Timer {
        id: timer
        repeat: false
        interval: 5000
        onTriggered: {
            root.state = "mainmenu"
        }
    }

    focus: true // important - otherwise we'll get no key events

    // Android device volume key controll
    Keys.onPressed: {
        if(event.key == Qt.Key_VolumeUp) {
            console.log("Volume up key is pressed.")
        }

        if(event.key == Qt.Key_VolumeDown) {
            console.log("Volume down key is pressed.")
        }
    }

    Keys.onReleased: {
        if (event.key == Qt.Key_Back) {
            console.log("Back button captured - wunderbar !")
//            event.accepted = true
        } else {
            console.log("event key: " + event.key + " ")
        }
    }
}
