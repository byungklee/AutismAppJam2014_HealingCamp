import QtQuick 2.0
import QtMultimedia 5.0

Item {
    id: root
    anchors.fill: parent
    MouseArea {
        anchors.fill: parent

    }
    Rectangle {
        anchors.fill: parent
        color:"#379233"
        opacity:0.3
        z:1
    }
//    FacebookOAuth {
//        id: __FacebookOAuth
//        width: root.width* 0.5
//        height: root.height* 0.5
//        z:4
//        onAuthorlized: {
//            __FacebookOAuth.z= 0
//        }
//    }

    ListModel {
        id: menuListModel
        ListElement {
            textLogo: "images/shopping.png"
            poster: "images/shopping-center.jpg"
            //soundEffect: "people_laughing.mp3"
            qmlFile: "ShoppingMall.qml"
        }
        ListElement {
            textLogo: "images/expression.png"
            poster: "images/expression.jpg"
            //soundEffect: "people_laughing.mp3"
            qmlFile: "ExpressionScreen.qml"
        }
        ListElement {
            textLogo: "images/playgame.png"
            poster: "images/playgame.jpg"
            //soundEffect: "people_laughing.mp3"
            qmlFile: "ColorGameScreen.qml"
        }
        ListElement {
            textLogo: "images/drawing.png"
            poster: "images/crayons.png"
            //soundEffect: "people_laughing.mp3"
            qmlFile: "DrawingScreen.qml"
        }
    }

    MediaPlayer {
        id: __PlaySoundEffect
        //source: soundEffect
        muted: false
        volume: 0.5
        autoLoad: true
        function toggleMute() {
            if(__PlaySoundEffect.muted == true) {
                __PlaySoundEffect.muted = false
            } else {
                __PlaySoundEffect.muted = true
            }

        }
    }

    function open() {
        console.log("mainmenu is opening")

    }
    Component.onCompleted: {
        console.log("oncompleted")
        root.state = "opened"
           // __PlaySoundEffect.play()
    }

    state: ""
    states: [
        State {
            name: "opened"
            PropertyChanges { target: menuView; y: 0 }
            PropertyChanges { target: appLoader; source: "" }


        },
        State {
            name: "inGame"
            PropertyChanges { target: appLoader; source: "" }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "opened"
            PropertyAnimation{ properties: "y";  easing.type: Easing.InOutBounce; duration: 1500 }
        }
    ]

    ListView {
        id: menuView
        width: parent.width * 0.9
        height: parent.height * 0.8
        model: menuListModel
        z:1
        y: -800
        orientation: ListView.Horizontal
        clip: true
        snapMode: ListView.SnapOneItem

        highlightMoveDuration: 1000
        highlightFollowsCurrentItem: true
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.centerIn : parent
        highlightRangeMode: ListView.StrictlyEnforceRange

        delegate: Rectangle {
            id: delegateRoot
            width: menuView.width
            height: menuView.height
            smooth:true
            border.width: 3
            border.color: "black"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    //playMusic.play()
                    console.log("qmlFile:" + qmlFile)
                    root.state = "inGame"


                    appLoader.source = qmlFile

                }
            }

            Image {
                id: imageFiller
                source : poster
                smooth : true
                width: delegateRoot.width * 0.995
                height: delegateRoot.height * 0.8
                anchors.top: parent.top
                anchors.topMargin:3

                anchors.horizontalCenter: parent.horizontalCenter

            }
            Rectangle {
                id: textLogoContainer
                anchors.top: imageFiller.bottom
                anchors.left: imageFiller.left
                width: imageFiller.width
                height: delegateRoot.height * 0.2 - 6
                //color: "#44b316"
                color: "#449116"
                clip:true
                Image {
                    id: text
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: text.width * 0.01
                    anchors.verticalCenterOffset: text.height * -0.1
                    width: textLogoContainer * 0.7
                    height: textLogoContainer.height * 0.8
                    smooth: true
                    source: textLogo
                }
            }
        }
    }
    Row {
        anchors.top: menuView.bottom
        anchors.horizontalCenter: root.horizontalCenter

        Image {
            id: leftArrow
            source : "images/LeftArrow_colored.png"
            width: root.width * 0.10
            height: root.height * 0.10

            anchors.verticalCenter: parent.verticalCenter
            z:2
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    menuView.decrementCurrentIndex()
                }
                onPressed: {
                    console.log("pressed")
                    leftArrow.source = "images/LeftArrow.png"
                }
                onReleased: {
                    console.log("released")
                    leftArrow.source = "images/LeftArrow_colored.png"
                }
            }
        }
        Image {
            id: menuBar
            source : "images/Bar.png"
            width: root.width * 0.6
            //        height: root.height * 0.03

            anchors.verticalCenter: parent.verticalCenter
            z:2
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(dot.x + " " + menuBar.width + " " + menuView.currentIndex)
                }
                //            onPressed: {
                //                console.log("pressed")
                //                leftArrow.source = "images/arrowLeftClicked.png"
                //            }
                //            onReleased: {
                //                console.log("released")
                //                leftArrow.source = "images/LeftArrow.png"
                //            }
            }

            Image {
                id: dot
                source : "images/circle.png"
                width: height
                height: menuBar.height
                x: menuView.count > 1 ? Math.min(menuBar.width * (menuView.currentIndex) / (menuView.count-1), menuBar.width-dot.width) : menuBar.width/2
            }
        }

        Image {
            id: rightArrow
            source : "images/RightArrow_colored.png"
            width: root.width * 0.10
            height: root.height * 0.1

            anchors.verticalCenter: parent.verticalCenter
            z:2
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    menuView.incrementCurrentIndex()
                }
                onPressed: {
                    console.log("pressed")
                    rightArrow.source = "images/RightArrow.png"
                }
                onReleased: {
                    console.log("released")
                    rightArrow.source = "images/RightArrow_colored.png"
                }
            }
        }
    }

    Loader {
        anchors.fill: parent
        id: appLoader
        z:3

        Connections {
            target: appLoader.item
            onExit: {
                //appLoader.destroy()
                root.state = "opened"
                    //__PlaySoundEffect.play()

            }
        }
        onLoaded: {
            //appLoader.item.open();
        }
    }

}
