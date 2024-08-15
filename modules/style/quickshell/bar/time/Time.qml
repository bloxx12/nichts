// with this line our type becomes a singleton
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// your singletons should always have Singleton as the type
Singleton {
  property string time

  Process {
    id: dateProc
    command: ["date"]
    running: true

    stdout: SplitParser {
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
