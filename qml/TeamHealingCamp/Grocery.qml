import QtQuick 2.0
import "framework" as Framework

PlaceTemplate {
    title: "GROCERY"
    widgetModel:
        ListModel {
        id: groceryModel
        ListElement {
            iColor: "#33B5E5"
            itemSource:"images/banana.png"
            itemName:"Pineapple"
            price: 1
            iVisible: true
        }
        ListElement {
            iColor: "brown"
            itemSource:"images/pineapple.png"
            itemName:"Pineapple"
            price: 2
            iVisible: true
        }
        ListElement {
            iColor: "green"
            itemSource:"images/tomato.png"
            itemName:"Apple"
            price: 3
            iVisible: true

        }
        ListElement {
            iColor: "yellow"
            itemSource:"images/strawberry.png"
            itemName:"Strawberry"
            price: 4
            iVisible: true
        }
    }

}
