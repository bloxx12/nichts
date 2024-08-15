
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Item {
    property string time

    Text {
        text: time
    }

    Process {
        id: dateProc
        command: ["date", "-u", "+%a, %d %b %H:%M:%S"]
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

