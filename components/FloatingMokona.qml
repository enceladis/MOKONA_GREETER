
/* import QtQuick

Item {
    id: root

    width: 220
    height: 220

    property real floatOffset: -55
    property real driftOffset: -8

    Image {
        id: mokona

        width: parent.width
        height: parent.height

        x: root.driftOffset
        y: root.floatOffset

        source: "../assets/mokonas/white/floating_white.png"

        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
    }

    // Gentle vertical floating
    SequentialAnimation {
        loops: Animation.Infinite
        running: true

        NumberAnimation {
            target: root
            property: "floatOffset"
            from: -55
            to: -35
            duration: 1800
            easing.type: Easing.InOutSine
        }

        NumberAnimation {
            target: root
            property: "floatOffset"
            from: -35
            to: -55
            duration: 1800
            easing.type: Easing.InOutSine
        }
    }

    // Gentle horizontal drifting
    SequentialAnimation {
        loops: Animation.Infinite
        running: true

        NumberAnimation {
            target: root
            property: "driftOffset"
            from: -8
            to: 8
            duration: 3200
            easing.type: Easing.InOutSine
        }

        NumberAnimation {
            target: root
            property: "driftOffset"
            from: 8
            to: -8
            duration: 3200
            easing.type: Easing.InOutSine
        }
    }
} */

