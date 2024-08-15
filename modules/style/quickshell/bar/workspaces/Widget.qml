import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import ".."
import "root:."

MouseArea {
    id: root
    required property var bar;
    required property int wsBaseIndex;
    property int wsCount: 10;
    property bool hideWhenEmpty: false;
    implicitHeight: column.implicitHeight + 10;
    acceptedButtons: Qt.NoButton
    onWheel: event => {
        event.accepted = true;
        const step = -Math.sign(event.angleDelta.y);
        const targetWs = currentIndex + step;
        if (targetWs >= wsBaseIndex && targetWs < wsBaseIndex + wsCount) {
            Hyprland.dispatch(`workspace ${targetWs}`) 
        } 
    }
	readonly property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen);
	property int currentIndex: 0;
	property int existsCount: 0;
	visible: !hideWhenEmpty || existsCount > 0;

	property real animPos: 0;
	Behavior on animPos { SmoothedAnimation { velocity: 100 } }

	// destructor takes care of nulling
	signal workspaceAdded(workspace: HyprlandWorkspace);

	ColumnLayout {
		id: column
		spacing: 0
		anchors {
			fill: parent;
			topMargin: 0;
			margins: 5;
		}

		Repeater {
			model: 10

			MouseArea {
				id: wsItem
				onPressed: Hyprland.dispatch(`workspace ${wsIndex}`);

				Layout.fillWidth: true
				implicitHeight: 15

				required property int index;
				property int wsIndex: wsBaseIndex + index;
				property HyprlandWorkspace workspace: null;
				property bool exists: workspace != null;
				property bool active: (monitor?.activeWorkspace ?? false) && monitor.activeWorkspace == workspace;

				onActiveChanged: {
					if (active) root.currentIndex = wsIndex;
				}

				onExistsChanged: {
					root.existsCount += exists ? 1 : -1;
				}

				Connections {
					target: root

					function onWorkspaceAdded(workspace: HyprlandWorkspace) {
						if (workspace.id == wsItem.wsIndex) {
							wsItem.workspace = workspace;
						}
					}
				}

				property real animActive: active ? 100 : 0
				Behavior on animActive { NumberAnimation { duration: 100 } }

				property real animExists: exists ? 100 : 0
				Behavior on animExists { NumberAnimation { duration: 100 } }

				Rectangle {
					anchors.centerIn: parent
					height: 10
					width: parent.width
					scale: 1 + animActive * 0.003
					radius: height / 2
					border.color: ShellGlobals.colors.widgetOutline
					border.width: 1
					color: ShellGlobals.interpolateColors(animExists * 0.01, ShellGlobals.colors.widget, ShellGlobals.colors.widgetActive);
				}
			}
		}
	}

	Connections {
		target: Hyprland.workspaces

		function onObjectInsertedPost(workspace) {
			root.workspaceAdded(workspace);
		}
	}

	Component.onCompleted: {
		Hyprland.workspaces.values.forEach(workspace => {
			root.workspaceAdded(workspace)
		});
	}
}
