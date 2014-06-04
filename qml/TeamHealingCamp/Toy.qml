import QtQuick 2.0

PlaceTemplate{
    title: "TOY"
    widgetModel:  ListModel {
        ListElement {
            iColor: "#33B5E5"
            itemSource:"images/toy1.png"
            itemName:"TOY1"
            price: 1
            iVisible: true
        }
        ListElement {
            iColor: "brown"
            itemSource:"images/toy2.png"
            itemName:"TOY2"
            price: 2
            iVisible: true
        }
        ListElement {
            iColor: "green"
            itemSource:"images/toy3.png"
            itemName:"TOY3"
            price: 3
            iVisible: true

        }
        ListElement {
            iColor: "yellow"
            itemSource:"images/toy4.png"
            itemName:"TOY4"
            price: 4
            iVisible: true
        }
    }
}
