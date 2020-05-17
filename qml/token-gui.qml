import QtQuick 2.13
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ApplicationWindow {
	id: mainWindow
    visible: true
    minimumWidth: 800
    minimumHeight: 600
	
    Material.theme: Material.Dark
    Material.accent: Material.Purple
    Material.primary: Material.Orange

    header: ToolBar {
		RowLayout {
			anchors.fill: parent
			ToolButton {
				icon.source: 'qrc:/resources/baseline-menu-24px.svg'
				onClicked: sideNav.open()
			}
			Label {
				text: 'GST Tacotron GUI'
				elide: Label.ElideRight
				horizontalAlignment: Qt.AlignHCenter
				verticalAlignment: Qt.AlignVCenter
				Layout.fillWidth: true
			}
			ToolButton {
				icon.source: 'qrc:/resources/baseline-more_vert-24px.svg'
				onClicked: menu.open()
				Menu {
					id: menu
					y: parent.height
					MenuItem { text: 'New...' }
					MenuItem { text: 'Open...' }
					MenuItem { text: 'Save' }
				}
			}
		}
	}
	Drawer {
		id: sideNav
		width: 200
		height: parent.height
		ColumnLayout {
			width: parent.width
			Label {
					text: 'Drawer'
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
					font.pixelSize: 20
					Layout.fillWidth: true
			}
			Repeater {
				model: 5
				SideNavButton {
					icon.source: 'qrc:/resources/baseline-category-24px.svg'
					text: 'List ' + index
					Layout.fillWidth: true
				}
			}
		}
	}
    Pane {
		padding: 10
		anchors.fill: parent
        ColumnLayout {
			id: main
            anchors.fill: parent
            RowLayout {
                spacing: 10
                ColumnLayout {
                    TextField {
                        Layout.fillWidth: true
						width: parent.width
						placeholderText: qsTr("Chinese Input")
						selectByMouse: true
					}
                    TextField {
                        Layout.fillWidth: true
						width: parent.width
						placeholderText: qsTr("Zhuyin Input")
						selectByMouse: true
					}
                }
                Button {
                    Layout.preferredWidth: 100
                    text: qsTr("Generate")
                    Layout.preferredHeight: parent.height
                }
            }	
			RowLayout {
				width: mainWindow.width - 10
				spacing: 10
				Item {
					id: refplayVar
					property string timeText
				}
				Label {
					text: "Ref"
				}
				Button {
					id: refplayBtn
				}
				Slider {
					id: refplaySlider
					Layout.fillWidth: true
					from: 0
					to: 180
					Component.onCompleted: value = 10
					onValueChanged: {
						value = Math.floor(value)
						refplayVar.timeText = Math.floor(refplaySlider.value / 60) + ":" + (refplaySlider.value % 60).toString().padStart(2, "0")
					}
					ToolTip {
						parent: refplaySlider.handle
						visible: refplaySlider.pressed
						text: refplayVar.timeText
					}
				}
				Label {
					Layout.preferredWidth: 40
					text: refplayVar.timeText
				}
			}
			RowLayout {
				GroupBox {
					Layout.fillWidth: true
					Layout.fillHeight: true
					clip: true
					ScrollView {
						id: tokensScroll
						width: parent.width
						height: parent.height
						contentWidth: tokensColumn.width
						contentHeight: tokensColumn.height
						Column {
							id: tokensColumn
							width: parent.width
							Repeater {
								model: tokens
								delegate: TokenSlider {}
							}
						}
					}
				}
				GroupBox {
					Layout.fillWidth: true
					Layout.fillHeight: true
					clip: true
					Image {
						id: matplotImg
						anchors.centerIn: parent
						width: parent.width
						fillMode: Image.Stretch
					}
				}
			}
		}
    }
	footer: Pane {
		padding: 10
		RowLayout {
			width: mainWindow.width - 10
			spacing: 10
			Item {
				id: playVar
				property string timeText
			}
			Button {
				id: playBtn
			}
			Slider {
				id: playSlider
				Layout.fillWidth: true
				from: 0
				to: 180
				Component.onCompleted: value = 10
				onValueChanged: {
					value = Math.floor(value)
					playVar.timeText = Math.floor(playSlider.value / 60) + ":" + (playSlider.value % 60).toString().padStart(2, "0")
				}
				ToolTip {
					parent: playSlider.handle
					visible: playSlider.pressed
					text: playVar.timeText
				}
			}
			Label {
				Layout.preferredWidth: 40
				text: playVar.timeText
			}
		}
	}
	
}