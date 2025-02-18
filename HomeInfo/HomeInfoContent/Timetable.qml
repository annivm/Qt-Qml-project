import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {
    visible: true
    width: 800
    height: 400

    property date currentTime: new Date();

    property string line: "";
    property string destinationName: "";
    property string arrival: "";


    Timer {
       interval: 100
       repeat: true
       running: true
       onTriggered: currentTime = new Date()
    }

    Column {
        Row {
            spacing: 10
            Text {
                text: line
            }
            Text {
                text: destinationName
            }

            Text {
                text: Qt.formatTime(arrival, "hh:mm")
            }
            Text {
                text: Qt.formatTime(arrival, "mm") - Qt.formatTime(currentTime, "mm") + " min"
            }

        }


    }

    Component.onCompleted: {
        fetchBusSchedule()
    }

    function fetchBusSchedule() {
        var url = "https://data.itsfactory.fi/journeys/api/1/stop-monitoring?stops=3549"

        const httpRequest = new XMLHttpRequest();
        httpRequest.open("GET", url)


        httpRequest.onreadystatechange = function () {
            if (httpRequest.readyState === XMLHttpRequest.DONE) {
                if (httpRequest.status === 200) {
                    const response = JSON.parse(httpRequest.responseText);

                    line = response.body[3549][0].lineRef
                    destinationName = response.body[3549][0].destinationShortName
                    arrival = response.body[3549][0].call.expectedArrivalTime

                    if(destinationName === "2017") {
                        destinationName =  "Tahmela"
                    } else if (destinationName === "1005") {
                        destinationName = "Hiedanranta"
                    } else {
                        destinationName = "Keskustori"
                    }

                }
            } else {
                console.error("Error, could not load data...");
            }
        };

        httpRequest.send();  // Lähetetään pyyntö
    }
}
