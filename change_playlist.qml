import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.0

Rectangle {
    id: window2
    width: 1080
    height: 720
    visible: true

    ColumnLayout {
        id: columnLayout_1

        width: window2.width
        height: window2.height
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Image {
                id: image_
                anchors.fill: parent
                source: "test_.jpg"
            }
        }
    }


    RowLayout{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        ColumnLayout {
            id: columnLayout

            width: 405
            height: 517

            
            Item {
                DropArea {
                    id: droparea_picture;
                    anchors.fill: parent
                    onEntered: {
                        // console.log("onEntered")
                    }
                    onDropped: {
                        // console.log("onEntered")
                        // console.log(drop.urls)
                        playlist_changed.get_picture(drop.urls) 
                    }
                    onExited: {
                        // console.log('Canceled')
                    }
                }
                Layout.fillWidth: true
                Layout.fillHeight: true

                Image {
                    id: image_1
                    anchors.fill: parent
                    source: "test.jpg"
                }
            }
        }


        
        ColumnLayout {
            width: 405
            height: 517
            spacing: 16
            
            RowLayout {
                
                DropArea {
                    id: dropArea_picture_1;
                    anchors.fill: parent
                    onEntered: {
                        // console.log("onEntered")

                    }
                    onDropped: {
                        // console.log("onEntered")
                        // console.log(drop.urls)
                        playlist_change.get_picture(drop.urls)
                    }
                    onExited: {
                        // console.log('Canceled')
                    }
                }
                
                TextField {
                    id: textfield_picture_path
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter picture path")
                    onEditingFinished: {
                        playlist_change.upd_info('|picture_path|#' + textfield_picture_path.text)
                    }

                }
                Button {
                    text: qsTr("picture")
                    onClicked: {
                        fileDialog_picture.open()                   
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
                 
                Component {
                    id: music_delegate
                    ItemDelegate {
                        
                        text: model.track + " - " + model.author + " - " + model.publish_year 
                        width: parent.width

                        Button {
                            id: button1
                            // text: qsTr("+")
                            anchors.right: parent.right
                            width: 36
                            height: 36
                            anchors.rightMargin: 4

                            onClicked: {                                
                                model.add = !model.add
                                playlist_change.change_music("add_",id,add)
                            }
                            background: Image {
                                id: image_2
                                anchors.fill: parent
                                source: add ? "checkbox_1.png" : "checkbox_2.png"
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
            
            Label {
                id: label4
                text: qsTr("Playlist name")
            }
            RowLayout {
                TextField {
                    id: textfield_name
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter Playlist name")
                    onEditingFinished: {
                        playlist_change.upd_info('|name|#' + textfield_name.text)
                    }
                }
            }
            RowLayout {
                // layoutDirection: RightToLeft 
                anchors.horizontalCenter: parent.horizontalCenter
                Button {
                    id: button_save
                    // anchors.right: button_cancel.left
                    text: qsTr("Save")
                    onClicked: {
                        // console.log("Save")
                        playlist_change.save()
                        music.upd_playlist_list()
                        playlist_change.clear()
                        music.close_playlist_dialog()                      
                    }
                }
                Button {
                    id: button_cancel
                    // anchors.right: parent.right
                    text: qsTr("Cancel")
                    onClicked: {
                        // console.log("Canceled")
                        playlist_change.clear()
                        music.close_playlist_dialog()                   
                    }
                }
            }


        }
        Shortcut {
            sequence: "Ctrl+Q"
            onActivated: Qt.quit()
        }
        
        
        FileDialog {
            id: fileDialog_picture
            title: "Please choose a picture"
            onAccepted: {
                // console.log("You chose: " + fileDialog_picture.fileUrls)
                playlist_change.get_picture(fileDialog_picture.fileUrls)   
            }
            onRejected: {
                // console.log("Canceled")
            }
        }
        Connections {
            target: playlist_change

            onPicturepath: {
                textfield_picture_path.text = text_
            }
            onPicture : {
                image_1.source = text_
            } 
            onName: {
                textfield_name.text = text_
            }


            onUpdListView_music: {
                listView.model = music_model
                listView.delegate = music_delegate
            }
            onAddListView_music:{
                music_model = music_model.append({id: id_, author: author_,publish_year: publish_year_, track: track_, favorite: liked_,add: add_})
            }
            onDropListView_music: {
                music_model = music_model.remove(id)
            }
            onClearListView_music: {
                music_model = music_model.clear()
            }
        }
    }
}   
/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
