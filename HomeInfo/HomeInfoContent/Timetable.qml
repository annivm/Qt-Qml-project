import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {
    visible: true
    width: 800
    height: 400
    color: "Transparent"

    property date currentTime: new Date();

    property string line: "";
    property string destinationName: "";
    property var arrival: null;


    property string line1: "";
    property string destinationName1: "";
    property var arrival1: null;


    property string line2: "";
    property string destinationName2: "";
    property var arrival2: null;


    Timer {
       interval: 100
       repeat: true
       running: true
       onTriggered: currentTime = new Date()
    }

    Column {
        anchors.centerIn: parent
        Text {
            text: "Nuijatie - 3549"
            font.pixelSize: 60
            font.family: "Tahoma"
        }

        Row {
            spacing: 20
            Text {
                text: line
                font.pixelSize: 40
                width: 90
            }
            Text {
                text: destinationName
                font.pixelSize: 40
                width: 300
            }

            Text {
                text: Qt.formatTime(arrival, "hh:mm")
                font.pixelSize: 40
                width: 200

            }
            Text {
                text: arrival ? Math.floor((arrival - currentTime) / 60000) + " min" : ""
                font.pixelSize: 40
                width: 190
            }

        }
        Row {
            spacing: 20
            Text {
                text: line1
                font.pixelSize: 40
                width: 90
            }
            Text {
                text: destinationName1
                font.pixelSize: 40
                width: 300
            }

            Text {
                text: Qt.formatTime(arrival1, "hh:mm")
                font.pixelSize: 40
                width: 200
            }
            Text {
                text: arrival1 ? Math.floor((arrival1 - currentTime) / 60000) + " min" : ""
                font.pixelSize: 40
                width: 190
            }

        }
        Row {
            spacing: 20
            Text {
                text: line2
                font.pixelSize: 40
                width: 90
            }
            Text {
                text: destinationName2
                font.pixelSize: 40
                width: 300
            }

            Text {
                text: Qt.formatTime(arrival2, "hh:mm")
                font.pixelSize: 40
                width: 200
            }
            Text {
                text: arrival2 ? (Math.floor((arrival2 - currentTime) / 60000)) + " min" : ""
                font.pixelSize: 40
                width: 190
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
                    if(destinationName === "2017") {
                        destinationName =  "Tahmela"
                    } else if (destinationName === "1005") {
                        destinationName = "Hiedanranta"
                    } else {
                        destinationName = "Keskustori"
                    }
                    arrival = new Date(response.body[3549][0].call.expectedArrivalTime)

                    line1 = response.body[3549][1].lineRef
                    destinationName1 = response.body[3549][1].destinationShortName
                    if(destinationName1 === "2017") {
                        destinationName1 =  "Tahmela"
                    } else if (destinationName1 === "1005") {
                        destinationName1 = "Hiedanranta"
                    } else {
                        destinationName1 = "Keskustori"
                    }
                    arrival1 = new Date(response.body[3549][1].call.expectedArrivalTime)

                    if (response.body[3549].length > 2) {
                        line2 = response.body[3549][2].lineRef
                        destinationName2 = response.body[3549][2].destinationShortName
                        if(destinationName2 === "2017") {
                            destinationName2 =  "Tahmela"
                        } else if (destinationName2 === "1005") {
                            destinationName2 = "Hiedanranta"
                        } else {
                            destinationName2 = "Keskustori"
                        }
                        arrival2 = new Date(response.body[3549][2].call.expectedArrivalTime)
                    }


                }

            } else {
                console.error("Error, could not load data...");
            }
        };

        httpRequest.send();  // Lähetetään pyyntö
    }
}
