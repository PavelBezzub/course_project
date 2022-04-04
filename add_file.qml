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
                        music_add.get_picture(drop.urls) 
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
                    id: dropArea_music;
                    anchors.fill: parent
                    onEntered: {
                        // console.log("onEntered")
                    }
                    onDropped: {
                        // console.log("onEntered")
                        // console.log(drop.urls)
                        music_add.get_file(drop.urls)
                    }
                    onExited: {
                        // console.log('Canceled')
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
                        // console.log("onEntered")
                    }
                    onDropped: {
                        // console.log("onEntered")
                        // console.log(drop.urls)
                        music_add.get_picture(drop.urls)
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
                        music_add.upd_info('|picture_path|#' + textfield_picture_path.text)
                    }
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
                    onEditingFinished: {
                        music_add.upd_info('|genre|#' + textfield_genre.text)
                    }
                }
            }
            Label {
                id: label7
                text: qsTr("Year")
            }
            RowLayout {
                TextField {
                    id: textfield_year
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter year")
                    onEditingFinished: {
                        music_add.upd_info('|year|#' + textfield_year.text)
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
                        // console.log("Canceled")
                        music_add.clear()
                        music.close_music_dialog()                
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
                // console.log("You chose: " + fileDialog_music.fileUrls)
                // textfield1.text = 'hi'
                music_add.get_file(fileDialog_music.fileUrls)            
            }
            onRejected: {
                // console.log("Canceled")
            }
        }
        
        FileDialog {
            id: fileDialog_picture
            title: "Please choose a picture"
            onAccepted: {
                // console.log("You chose: " + fileDialog_picture.fileUrls)
                music_add.get_picture(fileDialog_picture.fileUrls)   
            }
            onRejected: {
                // console.log("Canceled")
            }
        }
        Connections {
            target: music_add

            onMusicpath: {
                textfield_music_path.text = text_
                // textfield_picture_path.text = path_to_picture
                // textfield_artist_name.text = artist_name
                // textfield_genre.text = genre
                // textfield_title.text = title
            }
            onPicturepath: {
                textfield_picture_path.text = text_
            }
            onPicture: {
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
            onYear: {
                textfield_year.text = text_
            }
        }
    }
}   
/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
