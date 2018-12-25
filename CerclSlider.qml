import QtQuick 2.9
import QtQuick.Controls 2.2

Item
{
    id: root
    height: width ? width : 80
    width: height
    property real value: 0

    Rectangle
    {
        id: rect
        anchors.fill: parent
        radius: height / 2
        border.color: "red"
        border.width: 1
        Rectangle
        {
            id: slideRect
            height: parent.height * 0.15
            width: height
            radius: height / 2
            color: "red"
            border.width: 1
            border.color: "white"
            x: parent.radius - radius
            y: - radius
            z: 1
        }
        Canvas
        {
            id: canvas
            anchors.fill: parent
            z:0
            property real theta: 0

            function clear_canvas()
            {
                var ctx = getContext("2d");
                ctx.reset();
                canvas.requestPaint();
            }
            onPaint:
            {
                var ctx=canvas.getContext("2d");

                var cx = rect.radius;
                var cy = rect.radius;
                var radius = rect.radius;
                var startAngle = -Math.PI/2;
                var endAngle = startAngle + theta;
                ctx.beginPath();
                ctx.moveTo(cx,cy);
                ctx.arc(cx,cy,radius,startAngle,endAngle);
                ctx.closePath();
                ctx.fillStyle = "red";
                ctx.strokeStyle = "red";
                ctx.fill();
                ctx.stroke();
            }
        }
        MouseArea
        {
            anchors.fill: parent
            property int mousexy: mouseX * mouseY
            onMousexyChanged:
            {
                var o = {x: root.x + rect.radius, y: root.y + rect.radius}
                var my = - rect.radius + mouseY
                var mx = - rect.radius +  mouseX
                var theta = mx < 0 ? Math.atan(my/mx) + Math.PI:Math.atan(my/mx);
                slideRect.x = rect.radius * Math.cos(theta) + rect.radius - slideRect.radius
                slideRect.y = rect.radius * Math.sin(theta) + rect.radius - slideRect.radius
                canvas.theta = theta + Math.PI / 2
                value = canvas.theta/(2*Math.PI)
                canvas.clear_canvas()
                canvas.requestPaint()
            }
        }
    }
}
