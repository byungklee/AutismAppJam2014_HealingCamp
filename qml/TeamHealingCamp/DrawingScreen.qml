import QtQuick 2.0

Rectangle {

    id: root
    width: 600
    height: 600
     signal exit

    Row {
        id: paintTools
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: colorTools.top
            bottomMargin: 8
        }

        Image {
            id: back
            width: root.width * 0.18
            height: colorTools.height
            source: "images/back-button.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.exit()
                }
            }
        }

        Image {
            id: stroke
            width: root.width * 0.18
            height: colorTools.height
            source: "images/pencil.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    canvas.strokeSize = 50 // temp
                    // show stroke size changer
                }
            }
        }

        Image {
            id: clear
            width: root.width * 0.18
            height: colorTools.height
            source: "images/empty.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.clear()
                }
            }
        }

        Image {
            id: eraser
            width: root.width * 0.18
            height: colorTools.height
            source: "images/Eraser-icon.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    canvas.strokeSize = 30;
                    colorTools.paintColor = "white"
                }
            }
        } // End of Image

    }

//    Rectangle {
//        id: paintMenu
//        width: colorTools.width
//        height: paintTools.height * 2
//        color: "yellow"
//        visible: false

//        anchors {
//            horizontalCenter: parent.horizontalCenter
//            bottom: root.bottom
//            bottomMargin: 8
//        }
//        Row {
//            id:innerPaintMenu
//            spacing: 10
//            anchors {
//                horizontalCenter: parent.horizontalCenter
//                bottom: root.bottom
//                bottomMargin: 8
//            }
//            Rectangle {
//                id: goBackButton
//                width: root.width * 0.36
//                height: colorTools.height * 2
//                color: "red"
//            }

//            Rectangle {
//                id: exitButton
//                width: root.width * 0.36
//                height: colorTools.height * 2
//                color: "white"
//            }
//        }
//    }

    Row {
        id: colorTools
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 8
        }

        property color paintColor: "#33B5E5"
        spacing: 5
        Repeater {
            model: ["#33B5E5", "#99CC00", "#FFBB33", "#FF4444", "purple"]
            ColorSquare {
                id: paints
                color: modelData
                height: root.height * 0.12
                width: root.width * 0.18

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        colorTools.paintColor = color
                        canvas.strokeSize = 4
                    }
                }
            }
        }
    }


    Canvas {
        id: canvas
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: paintTools.top
            margins: 8
        }
        property real lastX
        property real lastY
        property color color: colorTools.paintColor
        property var ctx
        property real strokeSize: 4

        onPaint: {
            ctx = getContext('2d')
            ctx.lineWidth = strokeSize
            ctx.strokeStyle = canvas.color
            ctx.beginPath()
            ctx.moveTo(lastX, lastY)
            lastX = area.mouseX
            lastY = area.mouseY
            ctx.lineTo(lastX, lastY)
            ctx.stroke()
        }

        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {
                canvas.lastX = mouseX
                canvas.lastY = mouseY
            }
            onPositionChanged: {
                canvas.requestPaint()
            }
        }
    }

    function clear() {
        canvas.ctx.clearRect(0, 0, canvas.width, canvas.height);
        canvas.requestPaint()
    }
}
