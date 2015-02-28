import QtQuick 2.0

Rectangle {
    width: 600
    height: 10
    color: "transparent"

    property int bufferedValue: 0
    property int value: 0

    Rectangle {
        id: wrapper
        width: parent.width
        anchors.centerIn: parent
        height: 5
        color: "#ffffff"
        clip: true

        Canvas {
            id: canvasDash
            anchors.fill: parent
            antialiasing: true

            property int offsetX: 0
            property int radius: 200
            property int spacing: 0

            onOffsetXChanged: requestPaint()
            onRadiusChanged: requestPaint()
            onSpacingChanged: requestPaint()

            onPaint: {
                var ctx = canvasDash.getContext('2d');
                ctx.fillStyle = "#a3c2f6";
                ctx.clearRect(0, 0, canvasDash.width, canvasDash.height);
                for (var i = 0; i < canvasDash.width / 10 + 100; i++) {
                    ctx.beginPath();
                    ctx.arc(i * spacing / 500 + offsetX, 2.5, radius / 100, 0, Math.PI * 2, true);
                    ctx.fill();
                }

                offsetX++;
            }

            Behavior on opacity {

                NumberAnimation {
                    duration: 200
                }
            }

            NumberAnimation {
                id: scrollingAnim
                running: false
                loops: NumberAnimation.Infinite
                target: canvasDash
                property: "offsetX"
                from: 0
                to: -100
                duration: 1600
            }

            NumberAnimation {
                id: stretchingAnim
                running: scrollingAnim.running
                target: canvasDash
                property: "spacing"
                to: 5000
                duration: 1000
                easing.type: Easing.InOutQuad
            }

            SequentialAnimation {
                running: !stretchingAnim.running && scrollingAnim.running
                loops: SequentialAnimation.Infinite

                PauseAnimation {
                    duration: 1000
                }

                NumberAnimation {
                    target: canvasDash
                    property: "radius"
                    duration: 800
                    to: 0
                    easing.type: Easing.InOutQuad
                }

                PauseAnimation {
                    duration: 1000
                }

                NumberAnimation {
                    target: canvasDash
                    property: "radius"
                    duration: 800
                    to: 200
                    easing.type: Easing.InOutQuad
                }

                PauseAnimation {
                    duration: 1500
                }
            }
        }

        Rectangle {
            id: bufferedRect
            width: parent.width * (bufferedValue / 100.0)
            height: 5
            color: "#a3c2f6"

            Behavior on width {
                NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
            }
        }

        Rectangle {
            id: progressRect
            width: parent.width * (value / 100.0)
            height: 5
            color: "#6499f1"

            Behavior on width {
                NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
            }
        }

        Behavior on height {
            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
    }

    onBufferedValueChanged: {
        if (bufferedValue >= 100) {
            end();
        }
    }

    Component.onCompleted: {
        //start();
    }

    function start() {
        wrapper.height = 5;
        canvasDash.opacity = 1;
        canvasDash.spacing = 0;
        scrollingAnim.start();
    }

    function end() {
        scrollingAnim.stop();
        canvasDash.opacity = 0;
    }

    function hide() {
        wrapper.height = 0;
    }
}


