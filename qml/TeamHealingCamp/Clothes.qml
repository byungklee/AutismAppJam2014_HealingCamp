import QtQuick 2.0

PlaceTemplate {
    title: "CLOTHES"
   widgetModel: ListModel {
           ListElement {
               iColor: "#33B5E5"
               itemSource:"images/clothes1.jpg"
               itemName:"Pineapple"
               price: 1
               iVisible: true
           }
           ListElement {
               iColor: "brown"
               itemSource:"images/clothes3.jpg"
               itemName:"Pineapple"
               price: 2
               iVisible: true
           }
           ListElement {
               iColor: "green"
               itemSource:"images/clothes4.jpg"
               itemName:"Apple"
               price: 3
               iVisible: true

           }
           ListElement {
               iColor: "yellow"
               itemSource:"images/clothes5.jpg"
               itemName:"Strawberry"
               price: 4
               iVisible: true
           }
       }
}
