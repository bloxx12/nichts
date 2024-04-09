import { Widget, Utils } from "../../../imports.js";
const { Button, Label } = Widget;

export const Lock = () =>
    Button({
        className: "lock",
        cursor: "pointer",
        child: Label(""),
        onClicked: () => Utils.exec("swaylock"),
    });
