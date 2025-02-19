import QtQuick
import QtQuick.Controls

import QtQuick.LocalStorage 2.0

Rectangle {
    id: jokeoftheday;
    width: 600;
    height: 300;
    color: "Transparent"


    property string joke: "";
    property string punchline: "";


    Column{
        id: topJoke
        width: 500
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        Text{
            id: jokeText
            text: joke
            width: parent.width - 40
            rightPadding: 20
            fontSizeMode: Text.HorizontalFit
            font.pixelSize: 40
            font.bold: true
            font.family: "Tahoma"
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 60
        }


        Text {
            id: punchlineText
            text: punchline
            width: parent.width - 40
            fontSizeMode: Text.Fit
            font.pixelSize: jokeText.font.pixelSize - 20
            font.family: "Tahoma"
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 30
        }
    }



    Component.onCompleted: fetchJoke()

    function fetchJoke() {
       var url = "https://official-joke-api.appspot.com/random_joke";
       const httpRequest = new XMLHttpRequest();
       httpRequest.open("GET", url);

       httpRequest.onreadystatechange = function() {
           if (httpRequest.readyState === XMLHttpRequest.DONE) {
               if (httpRequest.status === 200) {
                   const response = JSON.parse(httpRequest.responseText);
                    joke = response.setup;
                    punchline = response.punchline;

                   jokeText.text = joke;
                   punchlineText.text = punchline;

               } else {
                   jokeText.text = "Virhe latauksessa";
               }
           }
       };

       httpRequest.send();
    }




}
