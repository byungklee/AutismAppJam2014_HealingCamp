import QtQuick 2.0
import QtQuick.Particles 2.0
import "framework" as Framework

Rectangle {
    signal exit;

    id: root

    width: 1000
    height: 800

    color: "steelblue"


    Framework.ButtonBase {
        source: "images/back-button.png"
        onClicked: {
            __PlaySoundEffect.stop();
            root.exit()
        }
        z:3
        opacity: 1
        width: parent.width * 0.17
        height: parent.height *0.15

    }

    Item {
        id: initialContainer
        height: root.height * 0.005
        width: root.width
    }
    Item {
        id: mainContainer
        height: root.height * 0.990
        width: root.width

        ParticleSystem {
            anchors.fill : parent
            ImageParticle {
                id: cloud
                source: "images/cloud.png"
                alphaVariation: 0.25
                opacity: 0.25
            }

            Wander {
                xVariance: 100;
                pace: 1;
            }

            Emitter {
                id: cloudLeft
                width: 160
                height: 160
                anchors.right: parent.left
                emitRate: 0.5
                lifeSpan: 12000
                velocity: PointDirection{ x: 64; xVariation: 2; yVariation: 2 }
                size: 240
            }

            Emitter {
                id: cloudRight
                width: 160
                height: 160
                anchors.left: parent.right
                emitRate: 0.5
                lifeSpan: 12000
                velocity: PointDirection{ x: -64; xVariation: 2; yVariation: 2 }
                size: 240
            }

            Image {
                id: sunny
                anchors.top:parent.top
                anchors.right: parent.right
                width: 100
                height: 100
                source: "images/sunny.png"
            }
        }

        Image {
            id : happyImage1
            visible: false
            anchors.centerIn: parent
            source: "images/happyworld1.png"
        }

        Image {
            id : loveImage1
            visible: false
            anchors.centerIn: parent
            source: "images/loveworld1.png"
        }

        Image {
            id : angryImage
            visible: false
            anchors.centerIn: parent
            source: "images/angryworld.jpg"
        }

        Image {
            id : sickImage
            visible: false
            anchors.centerIn: parent
            source: "images/sickimage.gif"

        }

        property int dislikeImageWidthSize: dislikeImage.width;
        property int dislikeImageHeightSize: dislikeImage.height;

        Image {
            id : dislikeImage
            visible: false
            anchors.centerIn: parent
            source: "images/dislike.png"

            Timer {
                id: dislikeImageChanger
                repeat: true
                interval: 100
                onTriggered: {
                    dislikeImage.width = dislikeImage.width * 1.10
                    dislikeImage.height = dislikeImage.height * 1.10
                }
            }
        }


        Row {
            spacing: 2;
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom;
            anchors.baselineOffset: 100;


            Image {
                id: happyMood
                source: "images/happy.png"
                width: root.width * 0.18
                height: root.height * 0.25
                smooth: true

                SequentialAnimation on y {
                    id: faceAnimation
                    loops: 0
                    NumberAnimation { from: happyMood.y ; to: -(root.height/2); duration: 2000; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: -root.height/2 ; to: happyMood.y; duration: 1600; easing.type: Easing.InOutQuad }
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        faceAnimation.loops = 2;
                        faceAnimation.start();
                        happyImage1.visible = true;
                        happyTimer.start();
                        __PlaySoundEffect.source = "mp3/laugh.wav";
                        __PlaySoundEffect.play();
                    }

                    Timer {
                        id: happyTimer
                        repeat: false
                        interval: 4000
                        onTriggered: happyImage1.visible = false;
                    }
                }

            }

            Image {
                id: angryMood
                source: "images/angry.png"
                width: root.width * 0.18
                height: root.height * 0.25
                smooth: true

                SequentialAnimation on y {
                    id: angryMoodAnimation
                    loops: 0
                    NumberAnimation { from: angryMood.y ; to: -(root.height/2); duration: 1000; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: -root.height/2 ; to: angryMood.y; duration: 800; easing.type: Easing.InOutQuad }
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        angryMoodAnimation.loops = 2;
                        angryMoodAnimation.start();
                        angryImage.visible = true;
                        angryTimer.start();
                        __PlaySoundEffect.source = "mp3/angry.wav";
                        __PlaySoundEffect.play();
                    }
                }

                Timer {
                    id: angryTimer
                    repeat: false
                    interval: 4000
                    onTriggered: angryImage.visible = false;
                }
            }

            Image {
                id: loveMood
                source: "images/love.png"
                width: root.width * 0.18
                height: root.height * 0.25
                smooth: true

                SequentialAnimation on y {
                    id: loveMoodAnimation
                    loops: 0
                    NumberAnimation { from: loveMood.y ; to: -(root.height/2); duration: 1000; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: -root.height/2 ; to: loveMood.y; duration: 800; easing.type: Easing.InOutQuad }
                }
                Timer {
                    id: loveTimer
                    repeat: false
                    interval: 4500
                    onTriggered: loveImage1.visible = false;
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        loveMoodAnimation.loops = 2;
                        loveMoodAnimation.start();
                        loveImage1.visible = true;
                        loveTimer.start();
                        __PlaySoundEffect.source = "mp3/iloveyoubaby.wav";
                        __PlaySoundEffect.play();
                    }
                }
            }

            Image {
                id: sickMood
                source: "images/sick.png"
                width: root.width * 0.18
                height: root.height * 0.25
                smooth: true

                SequentialAnimation on y {
                    id: sickMoodAnimation
                    loops: 0
                    NumberAnimation { from: sickMood.y ; to: -(root.height/2); duration: 1000; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: -root.height/2 ; to: sickMood.y; duration: 800; easing.type: Easing.InOutQuad }
                }
                Timer {
                    id: sickTimer
                    repeat: false
                    interval: 4500
                    onTriggered: sickImage.visible = false;
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        sickMoodAnimation.loops = 2;
                        sickMoodAnimation.start();
                        sickImage.visible = true;
                        sickTimer.start();
                        __PlaySoundEffect.source = "mp3/sneeze.wav";
                        __PlaySoundEffect.play();
                    }
                }
            }

            Image {
                id: dislikeMood
                source: "images/sullen.png"
                width: root.width * 0.18
                height: root.height * 0.25
                smooth: true

                SequentialAnimation on y {
                    id: dislikeMoodAnimation
                    loops: 0
                    NumberAnimation { from: dislikeMood.y ; to: -(root.height/2); duration: 1000; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: -root.height/2 ; to: dislikeMood.y; duration: 800; easing.type: Easing.InOutQuad }
                }
                Timer {

                    id: dislikeTimer
                    repeat: false
                    interval: 4000
                    onTriggered: {


                            dislikeImageChanger.repeat = false;
                            dislikeImage.visible = false;
                            dislikeImage.width = root.dislikeImageWidth;
                            dislikeImage.height = root.dislikeImageHeight;

                    }
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        dislikeMoodAnimation.loops = 2;
                        dislikeMoodAnimation.start();
                        dislikeImage.visible = true;
                        dislikeImageChanger.start();
                        dislikeImageChanger.repeat = true;
                        dislikeTimer.start();
                        __PlaySoundEffect.source = "mp3/sigh.wav";
                        __PlaySoundEffect.play();

                    }
                }
            }

        }


    }


}
