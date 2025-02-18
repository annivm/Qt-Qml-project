import QtQuick
import QtQuick.Controls

Rectangle {
    id: calendar

    width: 600;
    height: 700;
    color: "Blue";

    property date currentTime: new Date();
    property var nameday: [];

    Timer {
           interval: 100
           repeat: true
           running: true
           onTriggered: currentTime = new Date();
       }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            topPadding: 80
            font.pixelSize: 160
            font.bold: true
            font.family: "Tahoma"

            color: "black"
            text: Qt.formatTime(currentTime, "hh:mm")
        }

        Text {
            font.pixelSize: 90
            font.family: "Tahoma"
            color: "black"
            text: Qt.formatDate(currentTime, "dddd")
        }

        Text {
            font.pixelSize: 80
            color: "black"
            font.family: "Tahoma"
            text: Qt.formatDate(currentTime, "d. MMMM")
        }

        Text {
            topPadding: 10
            font.pixelSize: 30
            color: "black"
            font.family: "Tahoma"
            text: "Todays namedays: " + nameday
        }

    }


    Component.onCompleted: fetchNameDay()

    function fetchNameDay() {
        const url = "https://nameday.abalin.net/api/V1/today";
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("GET", url); // luodaan pyyntö GET requestille
        // Toteutetaan callbackit valmistuneelle resurssille
        httpRequest.onreadystatechange = function() {
            if( httpRequest.readyState === XMLHttpRequest.DONE ) { // request valmis
                if( httpRequest.status === 200 ) { // request ok, pitäisi olla data
                    const response = JSON.parse( httpRequest.responseText );
                    nameday = response.nameday.fi;
                }
                else {
                    // Error fetching data (ilmoita käyttöliittymälle)
                    nameday = "Error..."
                }
            }

        }
        httpRequest.send(); // lähetetään pyyntö
    }




}
