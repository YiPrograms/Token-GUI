import QtQuick 2.13
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ColumnLayout {
    width: tokensScroll.width
    height: Math.max(tokensScroll.height / tokens.rowCount(), 16)
    RowLayout {
        Label { text: model.name }
        Slider {
            id: slider
            Layout.fillWidth: true
            from: 0
            to: 5
            Component.onCompleted: value = model.value
            onValueChanged: model.value = value.toFixed(2)
            ToolTip {
                parent: slider.handle
                visible: slider.pressed
                text: slider.value.toFixed(2)
            }
        }
        Label {
            text: model.value
            Layout.preferredWidth: 40
        }
    }
}

