import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.0



ApplicationWindow {
    id: window
    width: 1080
    height: 720
    visible: true
    title: "Qt Quick Controls 2 - Imagine Style Example: Music Player"
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
}