import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow
{
    id: mwindow
    height: 640
    width: 340
    visible: true
    CerclSlider
    {
        id: cslider
        width: 200
        anchors.centerIn: parent
        //onValueChanged: console.log(value)
    }
    Text
    {
        width: cslider.width
        y: cslider.y - 2*height
        x: cslider.x
        font.pixelSize: 80 / 6
        text: Math.round(cslider.value*100) + "%"
        horizontalAlignment: Text.AlignHCenter
    }
}
