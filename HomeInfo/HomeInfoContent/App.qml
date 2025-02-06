// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import HomeInfo

Window {
    width: 1400
    height: 900

    visible: true
    title: "HomeInfo"


    Calendar {
        anchors.left: parent.left;
        anchors.top: parent.top;
    }

    JokeOfTheDay {
        anchors.left: parent.left;
        anchors.bottom: parent.bottom;
    }

    Weather {
        anchors.right: parent.right;
        anchors.top: parent.top;
    }

    Timetable {
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
    }



}

