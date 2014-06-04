import QtQuick 2.0
import "framework" as Framework

Rectangle {
    id: root
    signal exit

    MouseArea{
        id: clickguard
        anchors.fill: parent
        z:9999
        Timer {
            running :true
            interval: 500
            onTriggered: {
                clickguard.z = 0
            }
        }
    }

    Framework.ButtonBase {
        source: "images/back-button.png"
        onClicked: {
            __PlaySoundEffect.stop();
            root.exit()
        }
        z:3
        opacity: 1
        width: parent.width * 0.15
        height: parent.height *0.15
    }

    ListModel {
        id: storeModel
        ListElement {
            place: "Grocery"
            qmlFile: "Grocery.qml"
            image: "images/grocery-shopping.jpg"
        }
        ListElement {
            place: "Clothes"
            qmlFile: "Clothes.qml"
            image: "images/clothechildren.jpg"
        }
        ListElement {
            place: "Toy"
            qmlFile: "Toy.qml"
            image: "images/toystore.jpg"
        }
    }



    Image {
        source: "images/Shoppers11.jpg"
        anchors.fill: parent
        z:1
        opacity: 0.3
    }
    Rectangle {
        anchors.fill: parent
        color:"black"
        opacity: 0.4
        z:0
    }

    Loader {
        id: placeLoader
        anchors.fill: parent
        z:4
        Connections {
            target: placeLoader.item
            onExit: {
                root.state = "opened"
            }
        }
    }
    Component.onCompleted: {
        console.log("oncompleted")
        //PropertyChanges { target: __PlaySoundEffect; source: "mp3/start.mp3";  }

        root.state = "opened"
        __PlaySoundEffect.source = "mp3/start.mp3"
        __PlaySoundEffect.play()
    }

    //    state: ""
    states: [
        State {
            name: "opened"
            //PropertyChanges { target: menuView; y: 0 }
            PropertyChanges { target: placeLoader; source: "" }


        },
        State {
            name: "inPlace"
            PropertyChanges { target: placeLoader; source: "" }
        }
    ]

    Rectangle {
        width: parent.width * 0.72
        height: parent.height * 0.1

        anchors.horizontalCenter: parent.horizontalCenter
        //        color:"transparent"
        color:"black"
        Text {
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            anchors.fill:parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "Where do you want to go?"
            font.family: "Helvetica"

            color: "white"
            smooth: true
            font.pointSize: 24
        }

    }

    GridView {
        id: placeView
        z: 2
        anchors.centerIn: parent
        anchors.verticalCenterOffset: root.height * 0.07
        width: root.width * 0.9
        height: root.height * 0.9
        cellWidth: placeView.width*0.8
        cellHeight: placeView.height * 0.7
        clip: true
        model: storeModel
        snapMode: GridView.SnapOneRow

        delegate: Item {
            id: delegateItem
            width: placeView.width *0.8
            height: placeView.height *0.65
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.state = "inPlace"
                    placeLoader.source = qmlFile
                }
            }

            Image {
                id: icon
                width: frameImg.width *0.93
                height: frameImg.height * 0.73
                source: model.image
                z:2
                anchors.top: frameImg.top
                anchors.left: frameImg.left
                anchors.topMargin: frameImg.height * 0.06
                anchors.leftMargin: frameImg.width *0.04
            }
            Item {
                anchors.top: icon.bottom
                anchors.left: icon.left
                width: icon.width
                height: delegateItem.height * 0.2
                z:2
                Rectangle {
                    width: parent.width * 1.01
                    height: parent.height*0.94
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.height * 0.02
                    anchors.horizontalCenterOffset:  parent.width * -0.006
                    color:"transparent"
                    Text {
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: place
                        color: "brown"
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        font.pointSize: 26
                        font.letterSpacing: parent.width * 0.02
                        font.bold: true
                    }
                }
            }

            Image {
                id: frameImg
                anchors.centerIn: parent
                width: delegateItem.width
                height: parent.height
                source: "images/frame.png"
            }
        }
    }


}
