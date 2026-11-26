
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Effects

Rectangle {
    id: root

    width: Screen.width
    height: Screen.height
    color: "#171629"

    // Background wallpaper
    Image {
        id: wallpaper
        anchors.fill: parent
        source: "assets/background.png"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    // Soft dark overlay
    Rectangle {
        anchors.fill: parent
        color: "#30181729"
    }

    // Clock
    Column {
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 120
            topMargin: 120
        }

        spacing: 8

        Text {
            text: Qt.formatTime(new Date(), "hh:mm")
            color: "#E8DCEB"
            font.pixelSize: 160
            font.weight: Font.Light
        }

        Text {
            text: Qt.formatDate(new Date(), "dddd, MMMM d")
            color: '#eccee4'
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }

    //profile picture
    Item {
        id: profilePicture

        width: 100
        height: 100

        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: 370
            bottomMargin: 450
        }

        Image {
            id: pfpImage
            source: "assets/pfp.png"
            visible: false
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }

        Rectangle {
            id: pfpMask
            anchors.fill: parent
            radius: width / 2
            color: "black"
            layer.enabled: true
            visible: false
        }

        MultiEffect {
            anchors.fill: parent
            source: pfpImage
            maskEnabled: true
            maskSource: pfpMask
        }
    }

    // Login panel
    Rectangle {
        id: loginPanel

        property color fieldBackground: "#251329"
        property color fieldBorder: '#6f3359'
        property color fieldFocus: "#A34D83"
        property bool loggingIn: false

        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: 120
            bottomMargin: 120
        }

        width: 600
        height: 315
        radius: 15
        color: "#35FFFFFF"
        clip: true

        Rectangle {
            id: blurMask
            anchors.fill: parent
            anchors.margins: 1
            color: "white"
            radius: 15
            layer.enabled: true
            visible: false
        }

        ShaderEffectSource {
            id: wallpaperCapture
            anchors.fill: parent

            sourceItem: wallpaper
            sourceRect: Qt.rect(
                loginPanel.x,
                loginPanel.y,
                loginPanel.width,
                loginPanel.height
            )

            live: true
            hideSource: false
        }       

        MultiEffect {
            anchors.fill: parent

            source: wallpaperCapture

            maskEnabled: true
            maskSource: blurMask

            blurEnabled: true
            blur: 0.35
            blurMax: 64
        }

        Rectangle {
            id: blurTint
            anchors.fill: parent
            radius: 15
            color: "#30F48C9E"
        }

        Rectangle {
            id: outline
            anchors.fill: parent
            radius: 15
            border.width: 1
            border.color: "#F5C6A5"
            color: "transparent"
        }

        Column {
            anchors.fill: parent
            anchors.margins: 22
            spacing: 12

            Text {
                text: "Welcome back ♡"
                color: "#F48C9E"
                font.pixelSize: 22
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            ComboBox {
                id: userBox
                width: parent.width
                model: userModel
                textRole: "name"
                height: 38

                Component.onCompleted: {
                    for (let i = 0; i < userModel.count; i++) {
                        if (userModel.get(i).name === userModel.lastUser) {
                            currentIndex = i
                            break
                        }
                    }
                }

                background: Rectangle {
                    radius: 50
                    color: loginPanel.fieldBackground
                    border.width: 1
                    border.color: parent.activeFocus
                    ? loginPanel.fieldFocus
                    : loginPanel.fieldBorder
                }

                popup: Popup {
                    y: userBox.height + 8
                    width: userBox.width
                    padding: 4

                    background: Rectangle {
                        color: "#140C20"
                        radius: 15
                        border.color: loginPanel.fieldFocus
                        border.width: 1
                    }

                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        currentIndex: userBox.highlightedIndex

                        model: userBox.delegateModel

                        ScrollIndicator.vertical: ScrollIndicator {}
                    }
                }

                delegate: ItemDelegate {
                    width: userBox.width - userBox.popup.padding * 2
                    height: 32

                    contentItem: Text {
                        text: model.name
                        color: "white"
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                    }

                    highlighted: userBox.highlightedIndex === index

                    background: Rectangle {
                        radius: 8
                        color: parent.highlighted ? "#A34D83" : "transparent"
                    }
                } 

                contentItem: Text {
                    text: parent.displayText
                    color: "white"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 12
                    rightPadding: 32
                    font.pixelSize: 14
                }
            }

            TextField {
                id: passwordField
                width: parent.width
                height: 38
                placeholderText: "Password"
                echoMode: TextInput.Password
                color: "#E8DCEB"
                placeholderTextColor: "#BDB8CE"
                selectByMouse: true

                leftPadding: 12

                background: Rectangle {
                    radius: 50
                    color: loginPanel.fieldBackground
                    border.width: 1
                    border.color: parent.activeFocus
                        ? loginPanel.fieldFocus
                        : loginPanel.fieldBorder
                }

                onAccepted: loginButton.clicked()
            }

            Text {
                id: loginError
                width: parent.width
                text: ""
                color: '#f05050'
                font.pixelSize: 12
                horizontalAlignment: Text.AlighnHCenter
                visible: text !== ""
            }

            Button {
                id: loginButton
                width: parent.width
                text: loginPanel.loggingIn ? "Logging in..." : "Log in"
                enabled: !loginPanel.loggingIn

                background: Rectangle {
                    radius: 50
                    color: parent.down ? '#a35d68'
                    : parent.hovered ? '#eaa4b0'
                    : "#F48C9E"
                }

                contentItem: Text {
                    text: parent.text
                    color: "#E8DCEB"
                    font.pixelSize: 15
                    font.weight: Font.Medium
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    loginError.text = ""
                    loginPanel.loggingIn = true

                    sddm.login(userBox.currentText, passwordField.text, sessionBox.currentIndex)
                }
            }

            Connections {
                target: sddm

                function onLoginFailed() {
                    loginPanel.loggingIn = false
                    loginError.text = "Incorrect Password"
                    passwordField.text = ""
                    passwordField.forceActivateFocus()
                }
            }

            ComboBox {
                id: sessionBox
                width: parent.width
                model: sessionModel
                textRole: "name"
                currentIndex: sessionModel.lastIndex

                height: 38

                background: Rectangle {
                    radius: 50
                    color: loginPanel.fieldBackground
                    border.width: 1
                    border.color: parent.activeFocus
                    ? loginPanel.fieldFocus
                    : loginPanel.fieldBorder
                }

                popup: Popup {
                    y: sessionBox.height + 8
                    width: sessionBox.width
                    height: 100
                    padding: 8

                    background: Rectangle {
                        color: "#140C20"
                        radius: 15
                        border.color: loginPanel.fieldFocus
                        border.width: 1
                    }

                    contentItem: ListView {
                        clip: true
                        model: sessionModel
                        currentIndex: sessionBox.highlightedIndex

                        delegate: sessionBox.delegate

                        ScrollIndicator.vertical: ScrollIndicator {}
                    }
                }

                delegate: ItemDelegate {
                    width: sessionBox.width - sessionBox.popup.padding * 2
                    height: 32

                    contentItem: Text {
                        text: model.name
                        color: "#E8DCEB"
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                        font.pixelSize: 14
                    }

                    highlighted: sessionBox.highlightedIndex === index

                    background: Rectangle {
                        radius: 8
                        color: sessionBox.currentIndex === index
                            ? "#A34D83"
                            : '#683053'
                    }

                    onClicked: {
                        sessionBox.currentIndex = index
                        sessionBox.activated(index)
                        sessionBox.popup.close()
                    }
                }

                contentItem: Text {
                    text: parent.displayText
                    color: "white"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 12
                    rightPadding: 32
                    font.pixelSize: 14
                }
            }

            Row {
                width: parent.width
                spacing: 12

                Button {
                    id: sleepButton
                    text: "sleep"
                    width: (parent.width - 12) / 2

                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 15
                        font.weight: Font.Medium
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        radius: 50

                        color: sleepButton.down ? '#a35d68'
                            : sleepButton.hovered ? '#eaa4b0'
                            : "#F48C9E"
                    }

                    enabled: sddm.canSuspend
                    onClicked: sddm.suspend()
                }

                Button {
                    id: powerButton
                    text: "power off"
                    width: (parent.width - 12) / 2

                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 15
                        font.weight: Font.Medium
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        radius: 50

                        color: powerButton.down ? '#a35d68'
                            : powerButton.hovered ? '#eaa4b0'
                            : "#F48C9E"
                    }

                    enabled: sddm.canPowerOff
                    onClicked: sddm.powerOff()
                }
            }
        }

        Text {
            id: errorMessage
            width: parent.width
            color: "#FFB4AB"
            font.pixelSize: 12
            wrapMode: Text.WordWrap
        }

        Connections {
            target: sddm

            function onLoginFailed() {
                errorMessage.text = "Login failed. Try again."
                passwordField.clear()
                passwordField.forceActiveFocus()
            }

            function onLoginSucceeded() {
                errorMessage.text = ""
            }
        }
    }
}
