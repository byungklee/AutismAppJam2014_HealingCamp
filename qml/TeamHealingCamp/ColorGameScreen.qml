import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id: root
    width: 1000
    height: 800

    // Global variable for this module
    signal exit
    property int totalNumberOfBlock : 5;
    property int seconds : 10
    property int previousStageTime: seconds
    property int previousStageLevel : totalNumberOfBlock
    property int stage : 1
    property bool musicOn: true
    property string musicOnImage: ""


    function initializer() {
        root.totalNumberOfBlock = 50
        root.seconds = 30
        root.stage = 1
        listView1.blockModel = generateBlocks()
        listView1.model = undefined
        listView1.model = listView1.blockModel;
    }

    function stageUp() {
        wellDoneScreen.visible = false;
        wellDoneImage.visible = false;
        root.stage += 1;
        seconds = previousStageTime + 10;
        totalNumberOfBlock = previousStageLevel + 10;

        listView1.blockModel = generateBlocks();
        listView1.model = undefined;
        listView1.model = listView1.blockModel;
    }

    // Background Image
    Image {
        source : "images/bg1.jpg"
        anchors.fill:parent
    }
    MouseArea{
        anchors.fill: parent
    }

    Component.onCompleted: {
        __PlaySoundEffect.source = "mp3/gamebg.mp3";
        __PlaySoundEffect.play();
        if(__PlaySoundEffect.muted === true) {
            __PlaySoundEffect.muted = false
        }
        root.musicOnImage = "images/musicOn.png"


    }

    // SideMenu
    Column {
        spacing: 20;
        anchors.right: root.right
        anchors.topMargin: root.height * 0.01
        anchors.rightMargin: root.width * 0.0015

        //        Image {
        //            id: musicControler
        //            source: root.musicOnImage
        //            rotation: 3;
        //            width: root.width * 0.18
        //            height: root.height * 0.10
        //            anchors.right: root.right

        //            MouseArea {
        //                anchors.fill : parent
        //                onClicked: {
        //                    if(root.musicOn == true) {
        //                        musicControler.source = "images/muted.png";
        //                        root.musicOn = false;
        //                    } else {
        //                        musicControler.source = "images/musicon.png";
        //                        root.musicOn = true;
        //                    }
        //                    __PlaySoundEffect.toggleMute();
        //                }

        //            }
        //        }

        Button {
            id: muteButton;
            label: __PlaySoundEffect.muted ?  qsTr("Sound Off") : qsTr("Sound On");
            rotation: 1;
            width: root.width * 0.18
            height: root.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: __PlaySoundEffect.toggleMute();

        }
        Button {
            id: quitButton; label: qsTr("Quit"); rotation: -2;
            width: root.width * 0.18
            height: root.height * 0.05
            onClicked: {
                root.quit();
            }

        }
    }

    function quit() {
        __PlaySoundEffect.stop();
        root.exit();
    }

    function generateBlocks() {
        var tempNumber = Math.floor((Math.random()*10)+1);
        var blocks = new Array();
        // number 1 = red
        // number 2 = blue
        // number 3 = green
        for(var i = 0; i < totalNumberOfBlock; i++) {
            tempNumber = Math.floor((Math.random()*10)+1);
            if(tempNumber % 3 == 1) {
                blocks[i] = "red";
            } else if(tempNumber % 3 == 2) {
                blocks[i] = "blue";
            } else {
                blocks[i] = "green";
            }
        }

        return blocks;
    }

    function matchColor(color) {
        console.log(color + " is pushed");
        if(listView1.blockModel[0] == color) {
            listView1.blockModel.splice(0, 1)
            console.log(JSON.stringify(listView1.blockModel,null,2))
            listView1.model = undefined
            listView1.model = listView1.blockModel
        } else {
            console.log("wrong")
        }
    }

    function timeStr(secs)
    {
        var m = Math.floor(secs/60);
        var ret = "" + m + "m " + (secs) + "s";
        return ret;
    }

    Item {
        id: titleContainer
        height : root.height * 0.1
        width : root.width * 0.9
        anchors.horizontalCenter: root.horizontalCenter

        // G A M E animation LOGO
        Row {
            anchors.verticalCenter: parent.verticalCenter
            Image {
                height : titleContainer.height * 0.6
                width : titleContainer.width * 0.065
                source : "images/logo-g.png"
                SequentialAnimation on y {
                    loops: Animation.Infinite
                    NumberAnimation { from: -(titleContainer.height * 0.1) ; to: titleContainer.height * 0.1 ; duration: 2000; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: titleContainer.height * 0.1 ; to: -(titleContainer.height * 0.1) ; duration: 1600; easing.type: Easing.InOutQuad }
                }

            }
            Image {
                height : titleContainer.height * 0.6
                width : titleContainer.width * 0.065
                source : "images/logo-a.png"
                SequentialAnimation on y {
                    loops: Animation.Infinite
                    NumberAnimation { from: titleContainer.height * 0.1 ; to: -(titleContainer.height * 0.1) ; duration: 1600; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: -(titleContainer.height * 0.1) ; to: titleContainer.height * 0.1; duration: 2000; easing.type: Easing.InOutQuad }

                }
            }

            Image {
                height : titleContainer.height * 0.6
                width : titleContainer.width * 0.065
                source : "images/logo-m.png"
                SequentialAnimation on y {
                    loops: Animation.Infinite
                    NumberAnimation { from: -(titleContainer.height * 0.1) ; to: titleContainer.height * 0.1 ; duration: 2000; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: titleContainer.height * 0.1 ; to: -(titleContainer.height * 0.1) ; duration: 1600; easing.type: Easing.InOutQuad }
                }
            }

            Image {
                height : titleContainer.height * 0.6
                width : titleContainer.width * 0.065
                source : "images/logo-e.png"
                SequentialAnimation on y {
                    loops: Animation.Infinite
                    NumberAnimation { from: titleContainer.height * 0.15 ; to: -(titleContainer.height * 0.15) ; duration: 1600; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: -(titleContainer.height * 0.15) ; to: titleContainer.height * 0.15 ; duration: 2000; easing.type: Easing.InOutQuad }

                }
            }
        } // END of Row
    }

    Item {
        id: gameInfoContainer
        height: root.height * 0.4
        width: root.width * 0.3
        anchors.left: pinkRect.left
        anchors.top: listViewContainer.top

        Column {
            anchors.horizontalCenter : gameInfoContainer.horizontalCenter
            Text {
                anchors.horizontalCenter : parent.horizontalCenter
                text : "Match\n the Color"
                font.pointSize: gameInfoContainer.width * 0.05

            }

            Image {
                id: timerIcon
                source:"images/icon-time.png"
                width: root.width * 0.1
                height: root.width * 0.1
            }

            Text {
                text : timeStr(seconds);
                font.pointSize: gameInfoContainer.width * 0.05
            }
        }
    }

    Image {
        source: "images/Finger.png"
        anchors.bottom:listViewContainer.bottom
        anchors.right: listViewContainer.left
        width: root.width * 0.1
        height: root.height * 0.08
        anchors.bottomMargin: - root.height * 0.03
    }

    Item {
        id: listViewContainer
        height : root.height * 0.5
        width : root.width * 0.3
        anchors.horizontalCenter: root.horizontalCenter
        anchors.top : parent.top
        anchors.topMargin: root.height * 0.12

        ListView {
            id: listView1
            anchors.fill: parent
            property var blockModel : generateBlocks()
            model: blockModel
            transform: Rotation { origin.y:listView1.y + listView1.height/2 ;axis {x:1;y:0;z:0 } angle: 180 }

            delegate: Rectangle {
                width: listViewContainer.width * 0.9
                height: listViewContainer.height * 0.09
                border.width: 1;
                border.color: "black"
                color: listView1.blockModel[index]
                anchors.horizontalCenter: parent.horizontalCenter;
                radius:20
                opacity: 0 === index ? 1:0.4
            }
            onBlockModelChanged: {
                console.log("blockmodelchanged")
                listView1.model = undefined
                listView1.model = blockModel
            }
            onModelChanged: {
                if(model != undefined) {
                    console.log("modelChanged " + listView1.model.length)
                    if(listView1.model.length == 0) {
                        gameTimer.stop();
                        //HEREWORK
                        wellDoneScreen.visible = true;
                        wellDoneImage.visible = true;
                        console.log("Stage is cleared!");
                        welldoneTimer.start();
                        //root.stageUp();

                    }
                }

            }

            Timer {
                id:welldoneTimer
                interval: 1000
                repeat:false
                onTriggered: {
                    root.stageUp();
                }

            }
        }
    }


    Item {
        id: pinkRect
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.9
        height: parent.height * 0.4
        Row {
            anchors.verticalCenter: pinkRect.verticalCenter
            spacing: 3.3
            Image {
                id: redButton
                source:"images/Circle_Red.png"
                width:root.width * 0.3
                height:root.height * 0.3
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill : parent
                    onClicked: {
                        root.matchColor("red")
                    }
                    onPressed: {
                        redButton.source = "images/Circle_Pressed.png"
                    }

                    onReleased: {
                        redButton.source = "images/Circle_Red.png"
                    }
                }

            }

            Image {
                id: blueButton
                source:"images/Circle_Blue.png"
                width:root.width * 0.3
                height:root.height * 0.3

                MouseArea {
                    anchors.fill : parent
                    onClicked: {
                        console.log("Blue is pushed");
                        root.matchColor("blue")
                    }
                    onPressed: {
                        blueButton.source = "images/Circle_Pressed.png"
                    }

                    onReleased: {
                        blueButton.source = "images/Circle_Blue.png"
                    }
                }
            }

            Image {
                id: greenButton
                source:"images/Circle_Green.png"
                width:root.width * 0.3
                height:root.height * 0.3
                MouseArea {
                    anchors.fill : parent
                    onClicked: {
                        console.log("Green is pushed");
                        root.matchColor("green")

                    }
                    onPressed: {
                        greenButton.source = "images/Circle_Pressed.png"
                    }

                    onReleased: {
                        greenButton.source = "images/Circle_Green.png"
                    }
                }
            }
        }
    }

    // Bubble Pop
    Image {
        source: "images/catch.png"

        SequentialAnimation on x {
            loops: Animation.Infinite
            NumberAnimation { from: root.width/2 ; to: root.width/2  + 40; duration: 2000; easing.type: Easing.InOutQuad }
            NumberAnimation { from: root.width/2  + 40; to: root.width/2; duration: 1600; easing.type: Easing.InOutQuad }
        }
    }

    Timer {
        id: startCounter
    }

    Timer {
        id: gameTimer
        interval: 1000; running: seconds > 0;// repeat: true;
        onTriggered: seconds--;
    }

    // Welldone window
    Item {
        id: wellDoneScreen
        anchors.horizontalCenter: root.horizontalCenter
        anchors.verticalCenter: root.verticalCenter
        width : root.width * 0.48
        height: root.width * 0.48
        visible: false
        Image {
            id: wellDoneImage
            source: "images/happy.png"
            width: parent.width;
            height: parent.height;
            anchors.horizontalCenter: root.horizontalCenter
            anchors.verticalCenter: root.verticalCenter
            //visible: false
        }
    }



    // Gameover window
    Rectangle {
        id: gameOver
        width: root.width * 0.75
        height: root.width * 0.5
        color: "silver"
        anchors.centerIn: root
        opacity: 0.86
        visible: false

        Image {
            source: "images/text-gameover.png"
            width: parent.width * 0.75
            height: parent.height * 0.5
            anchors.centerIn:parent
            smooth: true
        }

        Item {
            id: gameOver_innerContainer
            width: gameOver.width * 0.85
            height: gameOver.height * 0.2
            anchors.bottom : parent.bottom
            anchors.bottomMargin: gameOver.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: gameOver_continue
                width: gameOver_innerContainer.width * 0.4
                height: gameOver_innerContainer.height
                color : "silver"
                border.width: 4
                border.color: "black"
                anchors.left : parent.left

                Text {
                    text : "New Game"
                    anchors.centerIn: parent
                    font.pixelSize: parent.width * 0.1

                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        gameOver.visible = false;
                        initializer();

                    }
                }
            }

            Rectangle {
                id: gameOver_exit
                width: gameOver_innerContainer.width * 0.4
                height: gameOver_innerContainer.height
                color : "silver"
                border.width: 4
                border.color: "black"

                anchors.right : parent.right

                Text {
                    text : "Quit"
                    anchors.centerIn: parent
                    font.pixelSize: parent.width * 0.1
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.quit()
                }
            }

        }
    }

    onSecondsChanged: {
        if(seconds === 0) {
            gameOver.visible = true
        }
        //if(seconds > 0 && (listView1.model.length == 0) )
    }

}
