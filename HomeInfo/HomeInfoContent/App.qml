// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import HomeInfo
import QtQuick.Shapes

Window {
    id: main
    width: 1400
    height: 900

    visible: true
    title: "HomeInfo"


    // Add a Rectangle to serve as the background
    Rectangle {
        width: parent.width
        height: parent.height
        color: "Red"
        anchors.fill: parent // Ensure the Rectangle fills the entire window
        gradient: Gradient{
            GradientStop{
                position: 0.00
                color: "#15719f"
            }
            GradientStop{
                position: 0.50
                color: "#62a1c7"
            }
            GradientStop{
                position: 1.20
                color: "#D4D8DD"
            }
        }



        // Ensure the background stays behind other components
        //ZIndex: -1


    // Calendar, JokeOfTheDay, Weather, Timetable components go here
    Calendar {
        anchors.left: parent.left
        anchors.top: parent.top
    }

    JokeOfTheDay {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    Weather {
        anchors.right: parent.right
        anchors.top: parent.top
    }

    Timetable {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

}


}

