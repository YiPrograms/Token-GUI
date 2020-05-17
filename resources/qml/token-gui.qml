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
				icon.source: '../images/baseline-menu-24px.svg'
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
				icon.source: '../images/baseline-more_vert-24px.svg'
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
              icon.source: '../images/mic-24px.svg'
              text: 'Record Ref Audio'
              Layout.fillWidth: true
              onClicked: refRecorder.open()
            }
			Repeater {
                width: parent.width
				model: 5
				SideNavButton {
					icon.source: '../images/baseline-category-24px.svg'
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
						placeholderText: '中文輸入'
						selectByMouse: true
					}
                    TextField {
                        Layout.fillWidth: true
						width: parent.width
						placeholderText: '注音輸入'
						selectByMouse: true
					}
                }
                Button {
                    Layout.preferredWidth: 100
                    text: '生成'
//                    Layout.preferredHeight: parent.height * .8

                }
            }
//			RowLayout {
//				width: mainWindow.width - 10
//				spacing: 10
//				Item {
//					id: refplayVar
//					property string timeText
//				}
//				Label {
//					text: "Ref"
//				}
//				Button {
//					id: refplayBtn
//				}
//				Slider {
//					id: refplaySlider
//					Layout.fillWidth: true
//					from: 0
//					to: 180
//					Component.onCompleted: value = 10
//					onValueChanged: {
//						value = Math.floor(value)
//						refplayVar.timeText = Math.floor(refplaySlider.value / 60) + ":" + (refplaySlider.value % 60).toString().padStart(2, "0")
//					}
//					ToolTip {
//						parent: refplaySlider.handle
//						visible: refplaySlider.pressed
//						text: refplayVar.timeText
//					}
//				}
//				Label {
//					Layout.preferredWidth: 40
//					text: refplayVar.timeText
//				}
//			}

			RowLayout {
				Pane {
//				    title: "Style Tokens"
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
        id: refRecorder
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }
}


