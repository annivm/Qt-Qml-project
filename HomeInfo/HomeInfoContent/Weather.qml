import QtQuick
import QtQuick.Controls


Rectangle {
    id: weather;
    width: 800;
    height: 500;
    color: "Yellow";

    // propertyina city, temperature ja windSpeed
    // nämä haetaan palvelimelta

    property string city: "Haetaan säätietoja..."
    property double temperature: 0
    property double windSpeed: 0
    property string description: ""
    property string icon: ""
    property string iconSource: "https://openweathermap.org/img/wn/" + icon + "@2x.png"



    Image{
        id: iconImage
        height: 400
        width: 400
        source: iconSource
        anchors.right: weather.Center
        anchors.verticalCenter: weather.verticalCenter

    }
    Text{
        id: temp
        text: temperature + "C"
        font.pixelSize: 60
        font.bold: true
        font.family: "Charcoal NY"
        anchors.left: iconImage.right
        anchors.verticalCenter: weather.verticalCenter
    }

    Text{
        text: description
        font.pixelSize: 30
        anchors.left: iconImage.right
        anchors.top: temp.bottom
    }





    // Haetaan säätiedot, kun komponentti on näytöllä
    Component.onCompleted: fetchWeatherData()

    // javaScript-funktio, jolla haetaan palvelimelta tiedot
    function fetchWeatherData(){
        var url = "https://api.openweathermap.org/data/2.5/weather?q=Tuusula&units=metric&APPID=716d6d488dbbca53e5b76e3788ffa23b"
        const httpRequest = new XMLHttpRequest(); //luokka
        httpRequest.open("GET", url) // luodaan pyyntö, parametrina metodi ja url

        // toteutetaan callbackit valmistuneelle requestille
        httpRequest.onreadystatechange = function(){

            // JSON-datan käsittely
            if(httpRequest.readyState === XMLHttpRequest.DONE){ // request on valmis
                if (httpRequest.status === 200){ // request ok ja data saatu

                    // päivitetään propertyihin haetut arvot
                    const response = JSON.parse(httpRequest.responseText) // muutetaan data JSON objektiksi
                    city = response.name
                    description = response.weather[0].description
                    temperature = response.main.temp
                    windSpeed = response.wind.speed
                    icon = response.weather[0].icon
                }
                else{
                    // Error fetching data
                    city = "Virhe latauksessa"
                }
            }
        }

        httpRequest.send() // lähetetään pyyntö
    }

}

