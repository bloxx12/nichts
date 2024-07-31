import Quickshell // for ShellRoot and PanelWindow
import Quickshell.Io // For Processes
import QtQuick // For Text

Scope {
  property string time;

  Variants {
    model: Quickshell.screens

    PanelWindow {
      property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      height: 30

      Text {
        anchors.centerIn: parent

        // now just time instead of root.time
        text: time
      }
    }
  }

  Process {
    id: dateProc
    command: ["date"]
    running: true

    stdout: SplitParser {
      // now just time instead of root.time
      onRead: data => time = data
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }
}
