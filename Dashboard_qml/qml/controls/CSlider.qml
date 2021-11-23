/*************************************************************************************
The MIT License (MIT)

Copyright (c) 2021 Arun Pk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
************************************************************************************/

import QtQuick 2.14
import QtQuick.Controls 2.14

Slider {
    id: control
    stepSize: 1
    property string bgcolor : "#21be2b"

    background: Rectangle {
		x: control.leftPadding
		y: control.topPadding + control.availableHeight / 2 - height / 2
		implicitWidth: 200
		implicitHeight: 4
		width: control.availableWidth
		height: implicitHeight
		radius: 2
		color: "#c0c0c0"

		Rectangle {
			width: control.visualPosition * parent.width
			height: parent.height
			//color: "#21be2b"
			color : bgcolor 
			radius: 2
		}
	}

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 26
        implicitHeight: 26
        radius: 13
        color: control.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
        Label {
            anchors.centerIn: parent
            text: Number(control.value).toFixed()
        }
    }
}
