import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.0

// ApplicationWindow {
Rectangle{
    id: window
    width: 1080
    height: 720
    visible: true
    // title: "Qt Quick Controls 2 - Imagine Style Example: Music Player"

    // Component.onCompleted: {
    //     x = Screen.width / 2 - width / 2
    //     y = Screen.height / 2 - height / 2
    // }
    
    // Rectangle {
    //     id :rect_drop
    //     width: 900
    //     height: 600
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     anchors.verticalCenter: parent.verticalCenter

    //     DropArea {
    //         id: dropArea;
    //         anchors.fill: parent
    //         onEntered: {
    //             console.log("onEntered")
    //             // root.color = "gray";
    //             // drag.accept (Qt.LinkAction);
    //         }
    //         onDropped: {
    //             rect_drop.border.color = ''
    //             console.log(drop.urls)
    //             // root.color = "white"
    //         }
    //         onExited: {
    //             rect_drop.border.color = ''
    //             // root.color = "white";
    //             console.log('aaa')
    //         }
    //     }
    // }
    


    ColumnLayout {
        id: columnLayout_1

        width: window.width
        height: window.height
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Image {
                id: image_
                anchors.fill: parent
                // fillMode: Image.PreserveAspectCrop
                source: "test_.jpg"
                // source: 'file:///C:/projects/The_Witcher_3_Wild_Hunt_Cover.jpg'
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
                        console.log("onEntered")
                        // root.color = "gray";
                        // drag.accept (Qt.LinkAction);
                    }
                    onDropped: {
                        console.log("onEntered")
                        console.log(drop.urls)
                        music_add.get_picture(drop.urls) 
                        // root.color = "white"
                    }
                    onExited: {
                        console.log('Canceled')
                    }
                }
                Layout.fillWidth: true
                Layout.fillHeight: true

                Image {
                    id: image_1
                    anchors.fill: parent
                    // fillMode: Image.PreserveAspectCrop
                    source: "test.jpg"
                    // source: 'file:///C:/projects/The_Witcher_3_Wild_Hunt_Cover.jpg'
                }
            }
        }


        
        ColumnLayout {
            // x: 338
            // y: 19
            width: 405
            height: 517
            spacing: 16
            // Layout.preferredWidth: 230

            // ButtonGroup {
            //     buttons: libraryRowLayout.children
            // }

            // RowLayout {
            //     id: libraryRowLayout
            //     Layout.alignment: Qt.AlignHCenter

            //     Button {
            //         text: "Files"
            //         checked: true
            //         // onClicked: music.get_all_music()
            //     }
            //     Button {
            //         text: "Playlists"
            //         checkable: true
            //         // onClicked: music.get_all_playlists()
            //     }
            //     Button {
            //         text: "Favourites"
            //         checkable: true
            //     }
            // }

            
            RowLayout {

                DropArea {
                    id: dropArea_music;
                    anchors.fill: parent
                    onEntered: {
                        console.log("onEntered")
                        // root.color = "gray";
                        // drag.accept (Qt.LinkAction);
                    }
                    onDropped: {
                        console.log("onEntered")
                        console.log(drop.urls)
                        music_add.get_file(drop.urls)
                        // root.color = "white"
                    }
                    onExited: {
                        console.log('Canceled')
                    }
                }

                TextField {
                    id: textfield_music_path
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter music path")
                    onEditingFinished: {
                        music_add.upd_info('|music_path|#' + textfield_music_path.text)
                    }
                }
                Button {
                    text: qsTr("music")
                    onClicked: {
                        fileDialog_music.open()                   
                    }
                }
            }
            RowLayout {
                
                DropArea {
                    id: dropArea_picture_1;
                    anchors.fill: parent
                    onEntered: {
                        console.log("onEntered")
                        // root.color = "gray";
                        // drag.accept (Qt.LinkAction);
                    }
                    onDropped: {
                        console.log("onEntered")
                        console.log(drop.urls)
                        music_add.get_picture(drop.urls)
                        // root.color = "white"
                    }
                    onExited: {
                        console.log('Canceled')
                    }
                }
                
                TextField {
                    id: textfield_picture_path
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter picture path")
                    onEditingFinished: {
                        music_add.upd_info('|picture_path|#' + textfield_picture_path.text)
                    }
                    // editingFinished: {}
                }
                Button {
                    text: qsTr("picture")
                    onClicked: {
                        fileDialog_picture.open()                   
                    }
                }
            }

            
            Label {
                id: label1
                text: qsTr("Artist name")
            }

            RowLayout {
                TextField {
                    id: textfield_artist_name
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter artist name")
                    onEditingFinished: {
                        music_add.upd_info('|artist_name|#' + textfield_artist_name.text)
                    }
                    // editingFinished: {}
                }
            }
            Label {
                id: label2
                text: qsTr("Genre")
            }
            RowLayout {
                TextField {
                    id: textfield_genre
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter genre")
                    // editingFinished: {}
                    onEditingFinished: {
                        music_add.upd_info('|genre|#' + textfield_genre.text)
                    }
                }
            }
            Label {
                id: label3
                text: qsTr("Title")
            }
            RowLayout {
                TextField {
                    id: textfield_title
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter title")
                    onEditingFinished: {
                        music_add.upd_info('|title|#' + textfield_title.text)
                    }
                    // editingFinished: {}
                }
            }
            Label {
                id: label4
                text: qsTr("Album")
            }
            RowLayout {
                TextField {
                    id: textfield_album
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter Album")
                    onEditingFinished: {
                        music_add.upd_info('|Album|#' + textfield_album.text)
                    }
                    // editingFinished: {}
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
                        // fileDialog_music.open()
                        console.log("Save")
                        music_add.save()
                        music.upd_music_list()
                        music_add.clear()
                        music.close_music_dialog()                   
                    }
                }
                Button {
                    id: button_cancel
                    // anchors.right: parent.right
                    text: qsTr("Cancel")
                    onClicked: {
                        // fileDialog_music.open()
                        console.log("Canceled")
                        // music_add.clear()
                        music.close_music_dialogs()                
                    }
                }
            }


        }
        Shortcut {
            sequence: "Ctrl+Q"
            onActivated: Qt.quit()
        }
        
        FileDialog {
            id: fileDialog_music
            title: "Please choose a music"
            onAccepted: {
                console.log("You chose: " + fileDialog_music.fileUrls)
                // textfield1.text = 'hi'
                music_add.get_file(fileDialog_music.fileUrls)            
            }
            onRejected: {
                console.log("Canceled")
            }
        }
        
        FileDialog {
            id: fileDialog_picture
            title: "Please choose a picture"
            onAccepted: {
                console.log("You chose: " + fileDialog_picture.fileUrls)
                music_add.get_picture(fileDialog_picture.fileUrls)   
            }
            onRejected: {
                console.log("Canceled")
            }
        }
        Connections {
            target: music_add

            // Обработчик сигнала сложения
            onMusicpath: {
                // longer_ было задано через arguments=['longer_']
                textfield_music_path.text = text_
                // textfield_picture_path.text = path_to_picture
                // textfield_artist_name.text = artist_name
                // textfield_genre.text = genre
                // textfield_title.text = title
            }
            onPictureath: {
                textfield_picture_path.text = text_
                image_1.source = text_
            }
            onGenre: {
                textfield_genre.text = text_
            }
            onTitle: {
                textfield_title.text = text_
            }
            onArtistname: {
                textfield_artist_name.text = text_
            }
            onAlbum: {
                textfield_album.text = text_
            }
        }
    }
}   
/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
