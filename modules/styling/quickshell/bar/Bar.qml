import Quickshell // for ShellRoot and PanelWindow
import Quickshell.Io // For Processes
import QtQuick // For Text

Scope {

    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData

            anchors {
                bottom: true
                left: true
                right: true
            }

            height: 30

            ClockWidget {
                anchors.centerIn: parent
            }
        }
    }
}
