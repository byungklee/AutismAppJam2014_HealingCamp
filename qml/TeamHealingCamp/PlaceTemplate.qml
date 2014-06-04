import QtQuick 2.0
import "framework" as Framework

Rectangle {
    id: root
    signal exit
    anchors.fill: parent
    color:"#379233"

    Framework.ButtonBase {
        source: "images/back-button.png"
        onClicked: {
            if (!checkOutContainer.visible){
                root.exit()
            } else {
                checkOutContainer.visible = false
            }
        }
        z:7
        opacity: 1
        width: parent.width * 0.15
        height: parent.height *0.15
    }
    MouseArea {
        anchors.fill: parent
    }
    property string title : "GROCERY"

    Item {
        width: parent.width *0.7
        height: parent.height *0.1
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment:  Text.AlignVCenter
            text: root.title
            font.underline: true
            font.pixelSize: 24
            font.letterSpacing: 5
            color: "white"
        }
    }
    property variant widgetModel

    Item {
        anchors.bottom: gridContainer.top

        width: parent.width
        height: parent.height * 0.2
        Text {
            anchors.fill: parent
            text: "DRAG AN ITEM TO THE CART!"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 22
            font.letterSpacing: 2
            color:"white"
        }
    }

    Rectangle {
        id: checkout
        color: "gray"

        height: parent.height * 0.1
        anchors.right: parent.right
        anchors.left: cart.left
        Connections {
            target: cart
            onPriceChanged: {
                console.log("hi")
                if(cart.price > 0) {
                    checkout.color = "orange"
                } else {
                    checkout.color = "gray"
                }
            }
        }
        border.width: 2
        border.color: "black"

        anchors.bottom: gridContainer.top
        opacity: cart.price > 0 ? 1 : 0.5
        Text {
            anchors.fill: parent
            text: "Check out!"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            color: cart.price>0 ? "black" : "white"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                //open
                if(cart.price > 0) {
                    console.log("open cartContainer + checkout info")
                    checkOutContainer.visible = true
                }
            }
            onPressed: {
                checkout.color = "darkred"
            }
            onReleased: {
                if(cart.price > 0) {
                    checkout.color = "orange"
                } else {
                    checkout.color = "gray"
                }
            }
        }
    }

    Rectangle {
        id: gridContainer
        width: parent.width * 0.6
        height: parent.height * 0.64
        color: "#EEEEEE"
        anchors.bottom: parent.bottom
        //anchors.topMargin: parent.height *0.15
        border.width: 2
        border.color: "black"
        z:5
        Component {
            id: widgetdelegate
            Item {
                width: grid.cellWidth
                height: grid.cellHeight
                Item {
                    id: im
                    state: "inactive"
                    //anchors.centerIn: parent
                    anchors.centerIn: parent
                    width: grid.cellWidth - 10;
                    height: grid.cellHeight *0.8
                    Image {
                        width: grid.cellWidth - 12
                        height: parent.height
                        source: itemSource
                        anchors.top: im.top
                        anchors.left: im.left
                    }

                    visible: iVisible
                    states: [
                        State {
                            name: "inactive";
                            when: (grid.firstIndexDrag == -1) || (grid.firstIndexDrag == index)
                            //  PropertyChanges { target: im; border.color: "black"}
                        }
                    ]
                }

                Text {
                    id: priceTag
                    anchors.top:im.bottom
                    anchors.left: im.left
                    anchors.right: im.right
                    text: "$ " + model.price
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                }

                states: [
                    State {
                        name: "inDrag"
                        when: index == grid.firstIndexDrag

                        //PropertyChanges { target: im; border.color: "red"}
                        PropertyChanges { target: im; parent: container }

                        PropertyChanges { target: im; anchors.centerIn: undefined }
                        PropertyChanges { target: im; x: coords.mouseX - im.width/2 }
                        PropertyChanges { target: im; y: coords.mouseY - im.height/2 }
                    }
                ]
            }
        }

        GridView {
            z:2
            property int firstIndexDrag: -1
            id: grid
            interactive: false // no flickable
            anchors.fill: parent
            cellWidth: parent.width / 2;
            cellHeight: parent.height /2;
            model: root.widgetModel
            delegate: widgetdelegate
            //
            Item {
                id: container
                anchors.fill: parent
            }


            MouseArea {
                id: coords
                anchors.fill: parent
                onReleased: {
                    var newIndex = grid.indexAt(mouseX, mouseY);
                    console.log("asdf" + cart.x +" " +mouseX + " " +"  y positions: " +cart.y +" "+mouseY + " " + (cart.y+height))
                    if(mouseX >= cart.x && mouseX <= cart.x + cart.width && cart.y <= mouseY+root.height*0.36 && cart.y+root.height >= mouseY+root.height*0.36) {

                        cart.quantity = cart.quantity + 1
                        cart.price = cart.price + widgetModel.get(grid.firstIndexDrag).price
                        console.log("quantity: " + cart.quantity + " price:" + cart.price)
                    }
                    console.log(grid.model.count)
                    grid.firstIndexDrag = -1
                }
                onPressed: {
                    grid.firstIndexDrag = grid.indexAt(mouseX, mouseY)
                }
            }
        }
    }

    Rectangle {
        id: cart
        anchors.top: gridContainer.top
        anchors.bottom: gridContainer.bottom
        //width: parent.width * 0.3
        anchors.right: parent.right
        //anchors.rightMargin: parent.width *0.03
        anchors.left: gridContainer.right
        property int quantity: 0
        color:"skyblue"
        property int price: 0
        border.width: 2
        border.color: "black"
        clip:true
        Image {
            source : "images/ShoppingCart.png"
            anchors.verticalCenter: parent.verticalCenter
            z:1
            width: parent.width
            height: parent.width
        }
        MouseArea {
            anchors.fill: parent
            onClicked:
            {
                console.log("areachecking")
                //open checkout
            }
        }
    }

    Item {
        id: checkOutContainer
        anchors.fill: parent
        visible: false
        z:10
        property int payment: 0
        onPaymentChanged: {
            if(payment >= cart.price && checkOutContainer.visible === true) {
                console.log("congrat!")
                _Row_Coins.enabled = false
                descriptionText.text = "Congratulations! Here is your change $" + (checkOutContainer.payment - cart.price) + "."
            }
        }
        MouseArea {
            anchors.fill: parent
        }
        Rectangle {

            anchors.centerIn: parent
            width: parent.width * 0.9
            height: parent.height * 0.9
            z:2
            border.width: 2
            border.color: "black"
             color: "skyblue"
            Column {
                anchors.fill: parent

                Rectangle {
                    width: parent.width * 0.997
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: parent.height * 0.5
                        color: "skyblue"
//                        border.color:"black"
//                        border.width: 2

                    Rectangle {
                        id: titleContainer
                         color:"#379233"
                        border.color:"black"
                        border.width: 2
                        width: parent.width
                        height: parent.height * 0.3
                        Text {
                            anchors.fill: parent
                            text: "Check Out"
                            font.underline: true
                            font.letterSpacing: 2
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 24
                            color: "white"
                        }
                    }
                    Rectangle {
                        id: des
                        anchors.top: titleContainer.bottom
                        width: parent.width
                        height: parent.height *0.3
                        border.width: 2
                        border.color: "black"
                        color:"lime"
                        Text {
                            id: descriptionText
                            anchors.fill: parent
                            text:"Total: $" + cart.price + "\n" +
                                 "Your payment: \b$" + checkOutContainer.payment

                            font.pixelSize: 20
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Image {
                        anchors.top: des.bottom
                        anchors.left: des.left
                        anchors.leftMargin: root.width * 0.3
                        source: "images/back-button.png"
                        width: parent.width * 0.3
                        height: parent.height * 0.4
                        visible: checkOutContainer.payment >= cart.price

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                checkOutContainer.visible = false
                                checkOutContainer.payment = 0;
                                cart.price = 0;
                                cart.quantity = 0;
                                descriptionText.text = "Total: $" + cart.price + "\n" +
                                        "Your payment: $" + checkOutContainer.payment
                                root.exit()
                            }
                        }
                    }

                }

                Rectangle {
                    id: yesOrNoContainer
                    width: parent.width * 0.8
                    height: parent.height * 0.3
                    anchors.horizontalCenter: parent.horizontalCenter
                     color: "skyblue"

                    Row {
                        id: _Row_Coins
                        anchors.centerIn: parent


                        spacing: parent.width *0.05
                        Rectangle {
                            width: yesOrNoContainer.width * 0.25
                            height: yesOrNoContainer.height *0.9
                            color:"brown"
                            border.width: 2
                            border.color: "yellowgreen"
                            Image {
                                source: "images/money1.png"
                                anchors.fill: parent
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    checkOutContainer.payment = checkOutContainer.payment + 1
                                }
                            }
                            Text {
                                anchors.top: parent.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                horizontalAlignment: Text.AlignHCenter
                                text: "$ 1"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle {
                            width: yesOrNoContainer.width * 0.25
                            height: yesOrNoContainer.height *0.9
                            color:"silver"
                            border.width: 2
                            border.color: "yellowgreen"
                            Image {
                                source: "images/bill.png"
                                anchors.fill: parent
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    checkOutContainer.payment = checkOutContainer.payment + 5
                                }
                            }
                            Text {
                                anchors.top: parent.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                horizontalAlignment: Text.AlignHCenter
                                text: "$ 5"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle {
                            width: yesOrNoContainer.width * 0.25
                            height: yesOrNoContainer.height *0.9
                            color:"gold"
                            border.width: 2
                            border.color: "yellowgreen"
                            Image {
                                source: "images/money2.png"

                                anchors.fill: parent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    checkOutContainer.payment = checkOutContainer.payment + 10
                                }
                            }
                            Text {
                                anchors.top: parent.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                horizontalAlignment: Text.AlignHCenter
                                text: "$ 10"
                                font.pixelSize: 20
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            anchors.fill: parent
            color:"black"
            opacity: 0.5
            z:1
        }
    }
    Component.onCompleted: {
        console.log("oncompleted")
        root.state = "opened"
    }

    state: ""
    states: [
        State {
            name: "opened"
        }
    ]

    function open() {

    }

    transitions: [
        Transition {
            to:"opened"
            PropertyAnimation {
                target: root
                //                properties: "anchors.fill";
                duration: 2000
            }
        }
    ]

}
