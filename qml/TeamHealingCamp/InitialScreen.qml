import QtQuick 2.0

Rectangle {
    id: root
    signal buttonClicked
    anchors.fill: parent
    color: "#44B316"

    Image {
        id: logoImage
        width: root.width * 0.55
        height: root.height * 0.55
        source: "images/healingcamplogo.png"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: root.height * 0.035
    }

//    Image {
//        id: logo
//        source: "images/logo-bubble.png"
//        anchors.top: parent.top

//        SequentialAnimation on x {
//            loops: Animation.Infinite
//            NumberAnimation { from: root.width/2 - 40 ; to: root.width/2  + 40; duration: 2000; easing.type: Easing.InOutQuad }
//            NumberAnimation { from: root.width/2  + 40; to: root.width/2 - 40; duration: 1600; easing.type: Easing.InOutQuad }
//        }
//        SequentialAnimation on anchors.topMargin {
//            loops: Animation.Infinite
//            NumberAnimation { from: root.height * 0.35; to: root.height * 0.10; duration: 1600; easing.type: Easing.InOutQuad }
//            NumberAnimation { from: root.height * 0.10; to: root.height * 0.35; duration: 2000; easing.type: Easing.InOutQuad }
//        }
//        SequentialAnimation on width {
//            loops: Animation.Infinite
//            NumberAnimation { from: 140; to: 160; duration: 1000; easing.type: Easing.InOutQuad }
//            NumberAnimation { from: 160; to: 140; duration: 800; easing.type: Easing.InOutQuad }
//        }
//        SequentialAnimation on height {
//            loops: Animation.Infinite
//            NumberAnimation { from: 150; to: 140; duration: 800; easing.type: Easing.InOutQuad }
//            NumberAnimation { from: 140; to: 150; duration: 1000; easing.type: Easing.InOutQuad }
//        }
//    }

    Image {
        width: root.width * 0.8
        height: root.height * 0.2
        source: "images/logo-healing.png"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
