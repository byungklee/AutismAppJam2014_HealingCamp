import QtQuick 2.0

BorderImage {
    id: root
    signal clicked;
    property bool pressed: false;
    property alias sourceIcon : _Image_Icon.source;
    property url sourceDefault : "";
    property url sourcePressed : "";
    property alias sourceHighlight: _Image_Highlight.source;
    property alias iconImageObject : _Image_Icon;
    property alias highlightImageObject : _Image_Highlight;
    property bool active;
    property url sourceActive : "";

    property bool preventStealingMouseFocus : false;
    property bool dragEnabled : false;
    property int dragAxis : Drag.XAxis
    property bool forceFocus : true
    property bool disabledReflectedImage: true;

    source: !pressed ? (!active ? sourceDefault : sourceActive) : sourcePressed;

    smooth: true

    BorderImage {
        id: _Image_Highlight;
        anchors.centerIn: parent;
        visible: parent.activeFocus;
        smooth: true
    }

    Image {
        id: _Image_Icon;
        anchors.centerIn: parent;
        smooth: true
    }

    MouseArea {
        anchors.fill: parent;
        onPressed: {
            if(root.forceFocus)
            {
                parent.forceActiveFocus();
            }
            parent.pressed = true;
        }
        onReleased: parent.pressed = false;
        onClicked: {
            parent.action()
        }

        drag.target: root.dragEnabled ? parent : undefined
        drag.axis: root.dragAxis
        preventStealing: root.preventStealingMouseFocus
    }

    function action()
    {
        clicked();
    }
    onActiveFocusChanged: {
        if(activeFocus)
        {
            root.z = 2;
        }
        else
        {
            root.pressed = false;
            root.z = 1;
        }
    }
}
