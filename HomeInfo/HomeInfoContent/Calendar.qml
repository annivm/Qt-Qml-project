import QtQuick
import QtQuick.Controls

Rectangle {
    id: calendar

    width: 600;
    height: 700;
    color: "Blue";

    property date currentTime: new Date();

    Timer {
           interval: 100
           repeat: true
           running: true
           onTriggered: currentTime = new Date();
       }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            font.pixelSize: 60
            font.bold: true
            font.family: "Trebuchet MS"

            color: "black"
            text: Qt.formatTime(currentTime, "hh:mm")
        }

        Text {
            font.pixelSize: 30
            font.family: "Consolas"
            color: "black"
            text: Qt.formatDate(currentTime, "dddd")
        }

        Text {
            font.pixelSize: 40
            color: "black"
            font.family: "Tahoma"
            text: Qt.formatDate(currentTime, "d. MMMM")
        }

        Text {
            text: "Todays namedays: "
        }

    }

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
                    city = "Virhe latauksessa..."
                }
            }


        }
        httpRequest.send(); // lähetetään pyyntö
    }


}
