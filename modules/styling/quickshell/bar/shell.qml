import Quickshell // for ShellRoot and PanelWindow
import QtQuick // for text
import QtQuick.Layouts
import QtQuick.Controls
import "workspaces" as Workspaces

ShellRoot {
    PanelWindow {
        anchors {
            top: true
            left : true
            right:true
        }
        height: 30 
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 0 
            Loader {
                active: isSoleBar 
                Layout.preferredHeight: active ? implicitHeight: 0;
                Layout.fillWidth: true 
                sourceComponent: Workspaces.Widget {
                    bar: root 
                    wsBaseIndex: 1
                }
            }
            Workspaces.Widget {
                bar: root 
                Layout.fillWidth: true 
                wsBaseIndex: 1;
                hideWhenEmpty: isSoleBar
            }
        } 
    }
}
