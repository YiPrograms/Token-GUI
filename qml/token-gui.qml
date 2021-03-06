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
	Material.accent: Material.Cyan
	Material.primary: '#333333'// Material.Indigo

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
		dim: false
		ColumnLayout {
			width: parent.width
			Item {
				// spacer item
				height: 5
			}
			Label {
				text: 'Tokens Preset'
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				font.pixelSize: 20
				Layout.fillWidth: true
			}
			Item {
				// spacer item
				height: 10
			}
			SideNavButton {
				icon.source: 'qrc:/resources/mic-24px.svg'
				text: 'Record Ref Audio'
				Layout.fillWidth: true
				onClicked: refRecorder.open()
			}
			Repeater {
				width: parent.width
				model: 5
				SideNavButton {
					icon.source: 'qrc:/resources/baseline-category-24px.svg'
					text: 'List ' + index
					width: parent.width
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
				spacing: -4
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
				Pane {
					Layout.fillWidth: true
					Layout.fillHeight: true
					clip: true
					width: parent.width * .5
					ScrollView {
						id: tokensScroll
						width: parent.width
						height: parent.height
						contentWidth: tokensColumn.width
						contentHeight: tokensColumn.height
						Column {
							id: tokensColumn
							width: parent.width
							spacing: 0
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
					value = ~~(value)
					playVar.timeText = ~~(playSlider.value / 60) + ":" + (playSlider.value % 60).toString().padStart(2, "0")
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
	Popup {
		width: parent.width - 50
		height: parent.height - 20
		id: refRecorder
		modal: true
		focus: true
		anchors.centerIn: Overlay.overlay
		closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
		ColumnLayout {
			anchors.fill: parent
			width: parent.width
			height: parent.height
			Label {
				text: 'Record Reference Audio'
				font.pixelSize: 32
			}
			RowLayout {
				Item {
					id: recordPlayVar
					property string timeText
				}
				Button {
					id: recordBtn
				}
				Slider {
					id: recordPlaySlider
					Layout.fillWidth: true
					from: 0
					to: 180
					Component.onCompleted: value = 10
					onValueChanged: {
						value = ~~(value)
						recordPlayVar.timeText = ~~(recordPlaySlider.value / 60) + ":" + (recordPlaySlider.value % 60).toString().padStart(2, "0")
					}
					ToolTip {
						parent: recordPlaySlider.handle
						visible: recordPlaySlider.pressed
						text: recordPlayVar.timeText
					}
				}
				Label {
					Layout.preferredWidth: 40
					text: recordPlayVar.timeText
				}
			}
			RowLayout {
				Layout.alignment: Qt.AlignRight
				Button {
					text: 'Cancel'
					onClicked: refRecorder.close()
				}
				Button {
					text: 'OK'
					onClicked: refRecorder.close() //TODO SAVE
				}
			}
		}
	}
}


