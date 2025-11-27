import QtQuick 2.15
import QtQuick.Controls 2.15
import MuseScore.NotationScene 1.0

Rectangle {
    id: root
    color: "lightgray"

    PianoRollController {
        id: controller
    }

    Column {
        id: mainColumn
        anchors.fill: parent

        Rectangle {
            id: header
            width: parent.width
            height: 40
            color: "darkgray"

            Row {
                Rectangle {
                    width: 150
                    height: 40
                    color: "darkgray"
                    border.color: "black"
                    Text {
                        text: "Drums"
                        anchors.centerIn: parent
                        color: "white"
                    }
                }

                ListView {
                    id: timelineHeader
                    width: parent.width - 150
                    height: 40
                    orientation: ListView.Horizontal
                    model: 32 // Number of time steps
                    delegate: Rectangle {
                        width: 40
                        height: 40
                        border.color: "black"
                        color: "darkgray"
                        Text {
                            text: index + 1
                            anchors.centerIn: parent
                            color: "white"
                        }
                    }
                    interactive: false
                }
            }
        }

        ScrollView {
            id: scrollView
            width: parent.width
            height: parent.height - header.height
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOn
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn

            onContentXChanged: timelineHeader.contentX = scrollView.contentX
            onContentYChanged: drumLanes.contentY = scrollView.contentY

            Row {
                id: mainRow

                ListView {
                    id: drumLanes
                    width: 150
                    height: contentHeight
                    model: controller.drumNames()
                    delegate: Rectangle {
                        width: 150
                        height: 40
                        border.color: "black"
                        color: "lightgray"
                        Text {
                            text: modelData
                            anchors.centerIn: parent
                        }
                    }
                    contentHeight: model.length * 40
                    interactive: false
                }

                GridView {
                    id: grid
                    width: Math.max(800 - drumLanes.width, scrollView.width - drumLanes.width)
                    height: drumLanes.contentHeight
                    cellWidth: 40
                    cellHeight: 40
                    model: controller.drumNames().length * 32 // 32 time steps for each drum
                    delegate: Rectangle {
                        width: 40
                        height: 40
                        border.color: "black"
                        color: "white"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                var rowIndex = Math.floor(index / 32);
                                var columnIndex = index % 32;
                                var drumName = controller.drumNames()[rowIndex];
                                var pitch = controller.pitch(drumName);
                                var tick = columnIndex * 480; // Assuming 480 ticks per quarter note
                                controller.addNote(pitch, tick);
                            }
                        }
                    }
                }
            }
        }
    }
}
