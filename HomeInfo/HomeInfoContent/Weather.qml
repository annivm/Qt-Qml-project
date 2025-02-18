import QtQuick
import QtQuick.Controls
import QtQuick.Effects


Rectangle {
    id: weather;
    width: 800;
    height: 500;
    color: "Yellow";


    // propertyina city, temperature ja windSpeed
    // nämä haetaan palvelimelta

    property string city: "tampere"
    property double temperature: 0
    property double windSpeed: 0
    property string description: ""
    property string icon: ""
    property string iconSource: "https://openweathermap.org/img/wn/" + icon + "@2x.png"


    Timer{
        id:updateTimer
        interval: 600000 // 10min
        running: true
        repeat:true
        onTriggered: fetchWeatherData()
    }

    Rectangle{
        id:leftWeather
        anchors.left: weather.left
        width: 400;
        height: 500;
        color: "transparent"

        Image{
            id: iconImage
            height: 450
            width: 450
            source: iconSource
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        MultiEffect {
            source: iconImage
            anchors.fill: iconImage
            shadowBlur: 1.7
            shadowEnabled: true
            shadowColor: "black"
            shadowVerticalOffset: 15
            shadowHorizontalOffset: 11
        }
    }
    Rectangle{

        id:rightWeather;
        anchors.left: leftWeather.right;
        width: 400;
        height: 500;
        color: "transparent"


        Rectangle{
            id:topRight
            anchors.top: rightWeather.top
            width: 400
            height: 250
            color: "transparent"
            Text{
                id: temp
                text: temperature.toFixed(0) + "°C"
                font.pixelSize: 130
                font.bold: true
                font.family: "Tahoma"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                bottomPadding: 20
                rightPadding: 30
            }
            MultiEffect {
                source: temp
                anchors.fill: temp
                shadowBlur: 1.7
                shadowEnabled: true
                shadowColor: "black"
                shadowVerticalOffset: 5
                shadowHorizontalOffset: 8
            }
        }
        Rectangle{
            id:bottomRight
            anchors.bottom: rightWeather.bottom
            width: 400
            height: 250
            color: "transparent"
            Text{
                id: descText
                text: description
                font.pixelSize: 60
                font.family: "Tahoma"
                anchors.horizontalCenter: parent.horizontalCenter
                topPadding: 10
                rightPadding: 30
            }
            MultiEffect {
                source: descText
                anchors.fill: descText
                shadowBlur: 1.7
                shadowEnabled: true
                shadowColor: "black"
                shadowVerticalOffset: 5
                shadowHorizontalOffset: 8
            }
        }
    }





    // Haetaan säätiedot, kun komponentti on näytöllä
    Component.onCompleted:{
        fetchWeatherData()
    }


    // javaScript-funktio, jolla haetaan palvelimelta tiedot
    function fetchWeatherData(){
        var url = "https://api.openweathermap.org/data/2.5/weather?q=" + city +"&units=metric&APPID=716d6d488dbbca53e5b76e3788ffa23b"
        const httpRequest = new XMLHttpRequest(); //luokka
        httpRequest.open("GET", url) // luodaan pyyntö, parametrina metodi ja url

        // toteutetaan callbackit valmistuneelle requestille
        httpRequest.onreadystatechange = function(){

            // JSON-datan käsittely
            if(httpRequest.readyState === XMLHttpRequest.DONE){ // request on valmis
                if (httpRequest.status === 200){ // request ok ja data saatu

                    // päivitetään propertyihin haetut arvot
                    const response = JSON.parse(httpRequest.responseText) // muutetaan data JSON objektiksi
                    description = response.weather[0].description
                    temperature = response.main.temp
                    windSpeed = response.wind.speed
                    icon = response.weather[0].icon

                }
                else{
                    // Error fetching data
                    descText.font.pixelSize = 40
                    description = "Error fetching data"
                    temp.text = "--"
                }
            }
        }

        httpRequest.send() // lähetetään pyyntö
    }


}

