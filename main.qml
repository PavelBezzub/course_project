import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0


ApplicationWindow {
    id: window
    width: 1000
    height: 720
    visible: true
    title: "Qt Quick Controls 2 - Imagine Style Example: Music Player"

    Component.onCompleted: {
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2
    }

    
    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(parent.width/2, parent.height/2)
        gradient: Gradient {
            GradientStop {
                position: 0.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#ee7752"; to: "#e73c7e"; duration: 2500 }
                    ColorAnimation { from: "#e73c7e"; to: "#23a6d5"; duration: 2500 }
                    ColorAnimation { from: "#23a6d5"; to: "#23d5ab"; duration: 2500 }

                    ColorAnimation { from: "#23d5ab"; to: "#23a6d5"; duration: 2500 }
                    ColorAnimation { from: "#23a6d5"; to: "#e73c7e"; duration: 2500 }
                    ColorAnimation { from: "#e73c7e"; to: "#ee7752"; duration: 2500 }
                }
            }   
            GradientStop { 
                position: 1.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#e73c7e"; to: "#23a6d5"; duration: 2500 }
                    ColorAnimation { from: "#23a6d5"; to: "#23d5ab"; duration: 2500 }
                    ColorAnimation { from: "#23d5ab"; to: "#23a6d5"; duration: 2500 }

                    ColorAnimation { from: "#23a6d5"; to: "#e73c7e"; duration: 2500 }
                    ColorAnimation { from: "#e73c7e"; to: "#ee7752"; duration: 2500 }
                    ColorAnimation { from: "#ee7752"; to: "#e73c7e"; duration: 2500 }
                }
            }
        }
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

    // Label {
    //     text: "Qtify"
    //     font.pixelSize: Qt.application.font.pixelSize * 1.3
    //     anchors.centerIn: header
    //     z: header.z + 1
    // }

    RowLayout {
        spacing: 115
        anchors.fill: parent
        anchors.margins: 70
        anchors.rightMargin: 30
        anchors.topMargin: 42
        anchors.bottomMargin: 38
        anchors.leftMargin: 35

        ColumnLayout {
            width: 362
            spacing: 26
            Layout.preferredWidth: 230

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Image {
                    id: main_img
                    // fillMode: Image.PreserveAspectCrop
                    anchors.fill: parent
                    source: "test.jpg"
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
                    text: "choose music, please"
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
                    // text: "favorite"
                    radius: 100

                    background: Image {
                                id: image_favorite
                                anchors.fill: parent
                                source: "unlike.png"
                            }

                    onClicked: music.favorite()
                }
                RoundButton {
                    // text: "stop"
                    radius: 100
                    background: Image {
                                id: image_stop
                                anchors.fill: parent
                                source: "stop.png"
                            }

                    onClicked: {
                        music.stop()
                        music.clear_now_playlist() 
                        }
                }
                RoundButton {
                    // text: "previous"
                    radius: 100

                    background: Image {
                                id: image_prev
                                anchors.fill: parent
                                source: "prev.png"
                            }
                    onClicked: music.previous()
                }
                RoundButton {
                    // text: "pause"
                    radius: 100
                    background: Image {
                                id: image_pause
                                anchors.fill: parent
                                source: "pause.png"
                            }
                    onClicked: music.pause()
                }
                RoundButton {
                    // text: "next"
                    radius: 100

                    background: Image {
                                id: image_next
                                anchors.fill: parent
                                source: "next.png"
                            }
                    onClicked: music.next_() 
                }
                RoundButton {
                    // text: "repeat"
                    radius: 100
                    background: Image {
                                id: image_repeat
                                anchors.fill: parent
                                source: "repeat.png"
                            }
                    onClicked: music.repeat() 
                }
                // RoundButton {
                //     text:"shuffle"
                //     radius: 200
                //     onClicked: music.shuffle() 
                // }
            }

            Slider {
                id: seekSlider
                value: 0
                to: 261
                snapMode: SnapOnRelease
                Layout.fillWidth: true
                onMoved: music.rewind_music(value)
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

                onPressedChanged:
                {
                    if(pressed)
                    {
                        // console.log("pressed")
                        // returnAnimation.stop()
                        music.pressed()
                    }
                    else
                    {
                        // console.log("released")
                        // returnAnimation.start()
                        music.released(value)
                    }
                }

            }
        }
        ColumnLayout {
            spacing: 5
            Layout.preferredWidth: 50
            Layout.preferredHeight: 640
            Slider {
                id: volume
                // x: 430
                // y: 430
                width: 40
                height: 252
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                focusPolicy: Qt.TabFocus
                font.pointSize: 8
                live: true
                stepSize: 1
                to: 100
                orientation: Qt.Vertical
                value: 50
                onMoved: music.set_volume(value)
            }
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
                    text: "now playing"
                    checkable: true
                    onClicked: music.get_now_playlists()
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Button {
                    text: qsTr("Add Music")
                    onClicked: {
                        // fileDialog.open() 
                        dialog1.open()
                        // music.start_file_dialog()  
                        // test {text: qsTr('Albums')}            
                    }
                }
                Button {
                    text: qsTr("Add PlayList")
                    onClicked: {
                        // fileDialog.open() 
                        playlist_change.set_all() 
                        dialog2.open()          
                    }
                }
            }

            Frame {
                id: filesFrame
                visible: true
                leftPadding: 1
                rightPadding: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                background: Rectangle {
                    width: filesFrame.width
                    height: filesFrame.height
                    color: "#595757"
                    opacity: 0.1
                }

                ListModel {
                    id: music_model
                }
                
                ListModel {
                    id: playlist_model
                }

                ListModel {
                    id: now_playing_model
                }

                Component {
                    id: music_delegate
                    ItemDelegate {
                        
                        // text: model.track + " - " + model.author + " - " + model.publish_year 
                        width: parent.width
                        Text {
                            anchors.left: parent.left
                            anchors.right: button2.left
                            text: model.track + " - " + model.author + " - " + model.publish_year 
                            font.family: "Helvetica"
                            font.pointSize: 10
                            color: "black"
                            wrapMode: Text.WordWrap
                            anchors.verticalCenter: parent.verticalCenter 
                        }
                        Button {
                            id: button
                            // text: qsTr("-")
                            anchors.right: parent.right
                            width: 36
                            height: 36
                            anchors.rightMargin: 8

                            // background: Rectangle {
                            //     implicitWidth: 32
                            //     implicitHeight: 32
                            //     color: "#e8e1e1"
                            // }

                            onClicked: {
                                music.del_music(id)
                                // model.favorite = !model.favorite
                            }
                            background: Image {
                                id: image_10
                                anchors.fill: parent
                                source: "trash.png"
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
                            // text: qsTr("+")
                            anchors.right: button.left
                            width: 36
                            height: 36
                            anchors.rightMargin: 4

                            // background: Rectangle {
                            //     implicitWidth: 32
                            //     implicitHeight: 32
                            //     color: "#e8e1e1"
                            // }
                            background: Image {
                                id: image_8
                                anchors.fill: parent
                                source: "play.png"
                            }
                            onClicked: {
                                music.play_all_music(id)
                                music.play()
                                // model.favorite = !model.favorite
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
                            // text: qsTr("like")
                            anchors.right: button1.left
                            width: 36
                            height: 36
                            anchors.rightMargin: 4
                            onClicked: {
                                music.change_music("like",id,model.favorite)
                                model.favorite = !model.favorite
                            }
                            // background: Rectangle {
                            //     implicitWidth: 32
                            //     implicitHeight: 32
                            //     // color: 'green'
                            //     color: favorite_ ? "#c1ffb8" : "#8a0000"
                            // }
                            background: Image {
                                id: image_1
                                anchors.fill: parent
                                source: favorite ? "like.png" : "unlike.png"
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
                }

                Component {
                    id: playlist_delegate
                    ItemDelegate {    
                        // text: model.name + " - " + model.duration + " - " + model.num_music
                        width: parent.width
                        Text {
                            anchors.left: parent.left
                            anchors.right: button34.left
                            text: model.name + " - " + model.duration + " - " + model.num_music
                            font.family: "Helvetica"
                            font.pointSize: 10
                            color: "black"
                            wrapMode: Text.WordWrap
                            anchors.verticalCenter: parent.verticalCenter 
                        }
                        Button {
                            id: button23
                            // text: qsTr("Play")
                            anchors.right: parent.right
                            width: 36
                            height: 36
                            anchors.rightMargin: 8

                            // background: Rectangle {
                            //     implicitWidth: 32
                            //     implicitHeight: 32
                            //     color: "#e8e1e1"
                            // }
                            background: Image {
                                id: image_playlist_trash
                                anchors.fill: parent
                                source: "trash.png"
                            }
                            onClicked: {
                                console.log('del playlist', id)
                                music.del_playlist(id)
                            }
                        }


                        Button {
                            id: button33
                            // text: qsTr("Play")
                            anchors.right: button23.left
                            width: 36
                            height: 36
                            anchors.rightMargin: 8

                            // background: Rectangle {
                            //     implicitWidth: 32
                            //     implicitHeight: 32
                            //     color: "#e8e1e1"
                            // }
                            background: Image {
                                id: image_playlist_play_
                                anchors.fill: parent
                                source: "play.png"
                            }
                            onClicked: {
                                music.set_now_playlists(id)
                                music.play()
                            }
                        }
                        Button {
                            id: button34
                            // text: qsTr("change")
                            anchors.right: button33.left
                            width: 36
                            height: 36
                            anchors.rightMargin: 8

                            background: Image {
                                id: image_change_playlist
                                anchors.fill: parent
                                source: "edit.png"
                            }
                            // background: Rectangle {
                            //     implicitWidth: 32
                            //     implicitHeight: 32
                            //     color: "#e8e1e1"
                            // }
                            onClicked: {
                                playlist_change.set_playlist(id)
                                dialog2.open()
                            }
                        }
                    }
                }


                Component {
                    id: now_playing_delegate
                    ItemDelegate {
                        
                        // text: model.track + " - " + model.author + " - " + model.publish_year 
                        Text {
                            anchors.left: parent.left
                            anchors.right: button2.left
                            text: model.track + " - " + model.author + " - " + model.publish_year 
                            font.family: "Helvetica"
                            font.pointSize: 10
                            color: "black"
                            wrapMode: Text.WordWrap
                            anchors.verticalCenter: parent.verticalCenter 
                        }
                        width: parent.width
                        Button {
                            id: button1
                            // text: qsTr("+")
                            anchors.right: parent.right
                            width: 36
                            height: 36
                            anchors.rightMargin: 4

                            background: Image {
                                id: image_98
                                // anchors.fill: parent
                                source: "play.png"
                            }

                            onClicked: {
                                music.play_music_in_playlist(id)
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
                            // text: qsTr("like")
                            anchors.right: button1.left
                            width: 36
                            height: 36
                            anchors.rightMargin: 4
                            onClicked: {
                                music.change_music("like now playlist",id,model.favorite)
                                model.favorite = !model.favorite
                            }
                            // background: Rectangle {
                            //     implicitWidth: 32
                            //     implicitHeight: 32
                            //     // color: 'green'
                            //     color: favorite_ ? "#c1ffb8" : "#8a0000"
                            // }
                            background: Image {
                                id: image_1
                                anchors.fill: parent
                                source: favorite ? "like.png" : "unlike.png"
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
                }



                ListView {
                    id: listView
                    clip: true
                    anchors.fill: parent
                    model: music_model
                    delegate: music_delegate

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
        onCloseDialog1: {
            dialog1.accept()
        }

        onCloseDialog2: {
            dialog2.accept()
        }

        // Обработчик сигнала 
        onSeekSlider: {
            // longer_ было задано через arguments=['longer_']
            seekSlider.to  = longer_
        }
        onSeekSlider2: {
            // longer_2 было задано через arguments=['longer_2']
            seekSlider.value  = longer_2
            // console.log('value ',longer_2)
        }
        //////////////////////////////////////////////////////
        onUpdListView_music: {
            listView.model = music_model
            listView.delegate = music_delegate
            // delegate_loader.sourceComponent = music_delegate
        }
        onAddListView_music:{
            music_model = music_model.append({id: id_, author: author_,publish_year: publish_year_, track: track_, favorite: liked_})
            // console.log('onAddListView_music',liked_)
        }
        onDropListView_music: {
            music_model = music_model.remove(id)
        }
        onClearListView_music: {
            music_model = music_model.clear()
        }


        //////////////////////////////////////////////////////
        onUpdListView_Now_playlist: {
            listView.model = now_playing_model
            // listView.delegate = music_delegate
            listView.delegate = now_playing_delegate
        }
        onAddListView_Now_playlist:{
            now_playing_model = now_playing_model.append({id: id_, author: author_,publish_year: publish_year_, track: track_, favorite: liked_})
        }
        onDropListView_Now_playlist: {
            now_playing_model = now_playing_model.remove(id)
        }
        onClearListView_Now_playlist: {
            now_playing_model = now_playing_model.clear()
        }


        //////////////////////////////////////////////////////
        onUpdListView_playlist: {
            listView.model = playlist_model
            listView.delegate = playlist_delegate
            console.log('onUpdListView__playlist')
        }
        onAddListView_playlist:{
            playlist_model = playlist_model.append({id: id_, name: name_, num_music: num_music_,duration: duration_})
            console.log('onAddListView_playlist',id_,name_)
        }
        onDropListView_playlist: {
            playlist_model = playlist_model.remove(id)
        }
        onClearListView_playlist: {
            playlist_model = playlist_model.clear()
        }
        ////////////////////////////////////////////////////////
        onSetProperty_music_list: {
            music_model.setProperty(id_, property_, liked_)
        }

        onSetProperty_now_music_list: {
            now_playing_model.setProperty(id_, property_, liked_)
        }
        ////////////////////////////////////////////////////////
        onSet_songNameLabel: {
            songNameLabel.text = text_
        }
        onSet_main_picture: {
            main_img.source = path_
        }
    }



    Dialog {
        id: dialog1
        width: 1080 
        height: 720 
        title: 'Add Music'
        contentItem: Loader {
                id: loader_

                anchors.centerIn: dialog1
                source: "add_file.qml"
            }

        Connections {
            target: music_add
        }

    }
    Dialog {
        id: dialog2
        width: 1080 
        height: 720 
        title: 'Add Music'
        contentItem: Loader {
                id: loader_2

                anchors.centerIn: dialog2
                source: "change_playlist.qml"
            }

        Connections {
            target: playlist_change
        }

    }


}
/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
