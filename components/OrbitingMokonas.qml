
/* import QtQuick

Item {
    id: root

    width: 520
    height: 420

    property real orbitAngle: 0
    property real whiteBob: 0
    property real blackBob: 0

    property real orbitRadius: 115
    property real blackOrbitOffset: 0

    property string blackExpression: "flying"

    Timer {
    id: expressionTimer
    interval: 1200
    repeat: false

    onTriggered: root.blackExpression = "flying"
}

    // White Mokona
    Image {
        id: whiteMokona

        width: 180
        height: 180

        x: root.width / 2
           + Math.cos(root.orbitAngle * Math.PI / 180)
           * root.orbitRadius
           - width / 2

        y: root.height / 2
           + Math.sin(root.orbitAngle * Math.PI / 180)
           * root.orbitRadius
           - height / 2
           + root.whiteBob

        source: "../assets/mokonas/white/floating_white.png"

        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
    }

    // Black Mokona
    Image {
        id: blackMokona

        width: 180
        height: 180

        x: root.width / 2
           + Math.cos((root.orbitAngle + 180 + root.blackOrbitOffset) * Math.PI / 180)
           * root.orbitRadius
           - width / 2

        y: root.height / 2
           + Math.sin((root.orbitAngle + 180 + root.blackOrbitOffset) * Math.PI / 180)
           * root.orbitRadius
           - height / 2
           + root.blackBob

        source: {
            if (root.blackExpression === "kiss")
                return "../assets/mokonas/black/black_wink_kiss_right.png"

                return "../assets/mokonas/black/black_flying.png"
        }

        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
    }

    MouseArea {
        anchors.fill: blackMokona
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            root.blackExpression = "kiss"
            expressionTimer.restart()
        }
    }

    // Slowly drift closer together and farther apart
    SequentialAnimation {
        running: true
        loops: Animation.Infinite

        NumberAnimation {
            target: root
            property: "orbitRadius"
            from: 100
            to: 145
            duration: 7000
            easing.type: Easing.InOutSine
        }

        NumberAnimation {
            target: root
            property: "orbitRadius"
            from: 145
            to: 100
            duration: 7000
            easing.type: Easing.InOutSine
        }
    }

    // Black Mokona occasionally drifts ahead or behind
    SequentialAnimation {
        running: true
        loops: Animation.Infinite

        NumberAnimation {
            target: root
            property: "blackOrbitOffset"
            from: -18
            to: 18
            duration: 5000
            easing.type: Easing.InOutSine
        }

        NumberAnimation {
            target: root
            property: "blackOrbitOffset"
            from: 18
            to: -18
            duration: 5000
            easing.type: Easing.InOutSine
        }
    }

    // Orbit around each other
    NumberAnimation {
        running: true
        target: root
        property: "orbitAngle"
        from: 0
        to: 360
        duration: 18000
        loops: Animation.Infinite
    }

    // White Mokona gently bobs
    SequentialAnimation {
        running: true
        loops: Animation.Infinite

        NumberAnimation {
            target: root
            property: "whiteBob"
            from: -8
            to: 8
            duration: 1700
            easing.type: Easing.InOutSine
        }

        NumberAnimation {
            target: root
            property: "whiteBob"
            from: 8
            to: -8
            duration: 1700
            easing.type: Easing.InOutSine
        }
    }

    // Black Mokona has a slightly different rhythm
    SequentialAnimation {
        running: true
        loops: Animation.Infinite

        NumberAnimation {
            target: root
            property: "blackBob"
            from: 7
            to: -7
            duration: 2100
            easing.type: Easing.InOutSine
        }

        NumberAnimation {
            target: root
            property: "blackBob"
            from: -7
            to: 7
            duration: 2100
            easing.type: Easing.InOutSine
        }
    }
} */
