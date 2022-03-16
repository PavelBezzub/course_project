import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.0

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: true
    title: "Qt Quick Controls 2 - Imagine Style Example: Music Player"

    Component.onCompleted: {
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2
    }

    Shortcut {
        sequence: "Ctrl+Q"
        onActivated: Qt.quit()
    }
    
//    header: ToolBar {
//        RowLayout {
//            id: headerRowLayout
//            anchors.fill: parent
//            spacing: 0

//            ToolButton {
//                icon.name: "grid"
//            }
//            ToolButton {
//                icon.name: "settings"
//            }
//            ToolButton {
//                icon.name: "filter"
//            }
//            ToolButton {
//                icon.name: "message"
//            }
//            ToolButton {
//                icon.name: "music"
//            }
//            ToolButton {
//                icon.name: "cloud"
//            }
//            ToolButton {
//                icon.name: "bluetooth"
//            }
//            ToolButton {
//                icon.name: "cart"
//            }

//            Item {
//                Layout.fillWidth: true
//            }

//            ToolButton {
//                icon.name: "power"
//                onClicked: Qt.quit()
//            }
//        }
//    }

    Label {
        text: "Qtify"
        font.pixelSize: Qt.application.font.pixelSize * 1.3
        anchors.centerIn: header
        z: header.z + 1
    }

    RowLayout {
        spacing: 115
        anchors.fill: parent
        anchors.margins: 70
        anchors.rightMargin: 30
        anchors.topMargin: 42
        anchors.bottomMargin: 38
        anchors.leftMargin: 35

        ColumnLayout {
            spacing: 0
            Layout.preferredWidth: 230

            Dial {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 50
            }

            Label {
                text: "Volume"

                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 12
            }
        }

        ColumnLayout {
            spacing: 26
            Layout.preferredWidth: 230

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Image {
                    fillMode: Image.PreserveAspectCrop
                    source: "images/album-cover.jpg"
                }
            }

            Item {
                id: songLabelContainer
                clip: true

                Layout.fillWidth: true
                Layout.preferredHeight: songNameLabel.implicitHeight

                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite

                    PauseAnimation {
                        duration: 2000
                    }
                    ParallelAnimation {
                        XAnimator {
                            target: songNameLabel
                            from: 0
                            to: songLabelContainer.width - songNameLabel.implicitWidth
                            duration: 5000
                        }
                        OpacityAnimator {
                            target: leftGradient
                            from: 0
                            to: 1
                        }
                    }
                    OpacityAnimator {
                        target: rightGradient
                        from: 1
                        to: 0
                    }
                    PauseAnimation {
                        duration: 1000
                    }
                    OpacityAnimator {
                        target: rightGradient
                        from: 0
                        to: 1
                    }
                    ParallelAnimation {
                        XAnimator {
                            target: songNameLabel
                            from: songLabelContainer.width - songNameLabel.implicitWidth
                            to: 0
                            duration: 5000
                        }
                        OpacityAnimator {
                            target: leftGradient
                            from: 0
                            to: 1
                        }
                    }
                    OpacityAnimator {
                        target: leftGradient
                        from: 1
                        to: 0
                    }
                }

                Rectangle {
                    id: leftGradient
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#dfe4ea"
                        }
                        GradientStop {
                            position: 1
                            color: "#00dfe4ea"
                        }
                    }

                    width: height
                    height: parent.height
                    anchors.left: parent.left
                    z: 1
                    rotation: -90
                    opacity: 0
                }

                Label {
                    id: songNameLabel
                    text: "Edvard Grieg - In the Hall of the Mountain King"
                    font.pixelSize: Qt.application.font.pixelSize * 1.4
                }

                Rectangle {
                    id: rightGradient
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#00dfe4ea"
                        }
                        GradientStop {
                            position: 1
                            color: "#dfe4ea"
                        }
                    }

                    width: height
                    height: parent.height
                    anchors.right: parent.right
                    rotation: -90
                }
            }

            RowLayout {
                spacing: 8
                Layout.alignment: Qt.AlignHCenter

                RoundButton {
                    text: "favorite"
                    radius: 200
                    onClicked: music.play()
                }
                RoundButton {
                    text: "stop"
                    radius: 200
                }
                RoundButton {
                    text: "previous"
                    radius: 200
                }
                RoundButton {
                    text: "pause"
                    radius: 200
                    onClicked: music.pause()
                }
                RoundButton {
                    text: "next"
                    radius: 200
                    onClicked: {
                        music.next()
                     }
                }
                RoundButton {
                    text: "repeat"
                    radius: 200
                }
                RoundButton {
                    text:"shuffle"
                    radius: 200
                }
            }

            Slider {
                id: seekSlider
                value: 0
                to: 261

                Layout.fillWidth: true

                ToolTip {
                    parent: seekSlider.handle
                    visible: seekSlider.pressed
                    text: pad(Math.floor(value / 60)) + ":" + pad(Math.floor(value % 60))
                    y: parent.height

                    readonly property int value: seekSlider.valueAt(seekSlider.position)

                    function pad(number) {
                        if (number <= 9)
                            return "0" + number;
                        return number;
                    }
                }
            }

//            RoundButton {
//                id: roundButton
//                text: "+"
//            }
        }

        ColumnLayout {
            spacing: 16
            Layout.preferredWidth: 230

            ButtonGroup {
                buttons: libraryRowLayout.children
            }

            RowLayout {
                id: libraryRowLayout
                Layout.alignment: Qt.AlignHCenter

                Button {
                    text: "Files"
                    checked: true
                    onClicked: music.get_all_music()
                }
                Button {
                    text: "Playlists"
                    checkable: true
                    onClicked: music.get_all_playlists()
                }
                Button {
                    text: "Favourites"
                    checkable: true
                }
            }

            RowLayout {
                TextField {
                    Layout.fillWidth: true
                }
                Button {
//                    icon.name: "folder"
                    text: qsTr("folder")
                    onClicked: {
                        fileDialog.open()                   
                    }
                }
            }

            Frame {
                id: filesFrame
                leftPadding: 1
                rightPadding: 1

                Layout.fillWidth: true
                Layout.fillHeight: true


                ListModel {
                    id: music_model
                    Component.onCompleted: {
                        for (var i = 0; i < 100; ++i) {
                            append({
                                author: "Author",
                                album: "Album",
                                track: "Track 0" + (i % 9 + 1),
                                id: i,
                                favorite_: !(i % 3)
                            });
                        }
                    }
                }
                ListModel {
                    id: playlist_model
                    Component.onCompleted: {
                        for (var i = 0; i < 9; ++i) {
                            append({
                                author: "Playlist",
                                album: " ",
                                track: "num = " + (i % 9 + 1),
                                id: i,
                                favorite_: !(i % 3)
                            });
                        }
                    }
                }




                ListView {
                    id: listView
                    clip: true
                    anchors.fill: parent
                    model: music_model
                    delegate: ItemDelegate {
                        text: model.author + " - " + model.album + " - " + model.track
                        width: parent.width
                        Button {
                            id: button
                            text: qsTr("-")
                            anchors.right: parent.right
                            width: 36
                            height: 36
                            anchors.rightMargin: 8

                            background: Rectangle {
                                implicitWidth: 32
                                implicitHeight: 32
                                color: "#e8e1e1"
                            }

                            contentItem: Text {
                                text: parent.text
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "Segoe MDL2 Assets"
                                font.pixelSize: 16
                                color: "red"
                                renderType: Text.NativeRendering
                            }
                        }
                        Button {
                            id: button1
                            text: qsTr("+")
                            anchors.right: button.left
                            width: 36
                            height: 36
                            anchors.rightMargin: 4

                            background: Rectangle {
                                implicitWidth: 32
                                implicitHeight: 32
                                color: "#e8e1e1"
                            }

                            contentItem: Text {
                                text: parent.text
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "Segoe MDL2 Assets"
                                font.pixelSize: 16
                                color: "green"
                                renderType: Text.NativeRendering
                            }
                        }
                        Button {
                            id: button2
                            text: qsTr("like")
                            anchors.right: button1.left
                            width: 36
                            height: 36
                            anchors.rightMargin: 4
                            onClicked: {
                                music.change_("like",id)
                                favorite_ = !favorite_
                            }
                            background: Rectangle {
                                implicitWidth: 32
                                implicitHeight: 32
                                // color: 'green'
                                color: favorite_ ? "#c1ffb8" : "#8a0000"
                            }

                            contentItem: Text {
                                text: parent.text
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "Segoe MDL2 Assets"
                                font.pixelSize: 16
                                color: "black"
                                renderType: Text.NativeRendering
                            }
                        }
                    }

                    ScrollBar.vertical: ScrollBar {
                        parent: filesFrame
                        policy: ScrollBar.AlwaysOn
                        anchors.top: parent.top
                        anchors.topMargin: filesFrame.topPadding
                        anchors.right: parent.right
                        anchors.rightMargin: 1
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: filesFrame.bottomPadding
                    }
                }
            }
        }
    }


    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
        }
        onRejected: {
            console.log("Canceled")
        }
    }
    // Component.onCompleted: visible = true

    Connections {
        target: music

        // Обработчик сигнала сложения
        onSeekSlider: {
            // longer_ было задано через arguments=['longer_']
            seekSlider.to  = longer_
        }
        onSeekSlider2: {
            // longer_2 было задано через arguments=['longer_2']
            seekSlider.value  = longer_2
        }
        onUpdListView_music: {
            
            listView.model = music_model
        }
        onUpdListView_playlist: {
            // playlist_model = playlist_model.append({author: "Playlist", album: " ", track: "num = " + (1 % 9 + 1), id: 16, favorite_: !(1 % 3)})
            listView.model = playlist_model
            // updateModel()

        }
    }
//    Button {
//        id: button
//        x: 188
//        y: 115
//        text: qsTr("Button")
//    }

//    RoundButton {
//        id: roundButton
//        x: 266
//        y: 144
//        radius: 200
//        text: "+"
//    }
}
/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
