import QtQuick 2.0

Rectangle {
    width: 100
    height: 100
    color: "transparent"

    readonly property var primaryColors: [ "#03a9f4", "#e51c23", "#ffca28", "#2baf2b" ]
    property int currentColorIndex: 1
    property bool isColorChangable: true

    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true

        property int startDeg: 0
        property int endDeg: 5
        property color primaryColor: primaryColors[0]

        Behavior on primaryColor {
            ColorAnimation { duration: 200 }
        }

        onStartDegChanged: requestPaint()
        onEndDegChanged: requestPaint()
        onPrimaryColorChanged: requestPaint()

        onPaint: {
            function deg2Rad(deg) {
                return (deg / 180) * Math.PI;
            }

            var ctx = canvas.getContext('2d');
            ctx.strokeStyle = primaryColor;
            ctx.lineWidth = 5;
            ctx.lineCap="round";
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.beginPath();
            ctx.arc(canvas.width / 2, canvas.height / 2, (canvas.height > canvas.width ? canvas.width : canvas.height) / 2 - 20, deg2Rad(startDeg - 90), deg2Rad(endDeg - 90), false);
            ctx.stroke();
        }
    }

    NumberAnimation {
        id: anim1
        target: canvas
        property: "endDeg"
        duration: 600
        easing.type: Easing.InOutQuad

        onStopped: {
            interval.start();
        }
    }


    PauseAnimation {
        id: interval
        duration: 300

        property bool animSwitcher: true

        onStopped: {
            canvas.endDeg = canvas.endDeg % 360;
            canvas.startDeg = canvas.startDeg % 360;

            anim1.to = canvas.endDeg + 280;
            anim2.to = canvas.startDeg + 280;

            if (animSwitcher) {
                anim1.start();
            } else {
                anim2.start();
            }

            animSwitcher = !animSwitcher;
        }
    }

    NumberAnimation {
        id: anim2
        target: canvas
        property: "startDeg"
        duration: 600
        easing.type: Easing.InOutQuad

        onStopped: {
            interval.start();

            if (isColorChangable) {
                canvas.primaryColor = primaryColors[currentColorIndex++];
                if (currentColorIndex > 3) currentColorIndex = 0;
            }
        }
    }


    NumberAnimation {
        running: true
        loops: Animation.Infinite
        target: canvas
        property: "rotation"
        duration: 1800
        from: 0
        to: 360
    }

    Component.onCompleted: {
        interval.start();
    }
}


