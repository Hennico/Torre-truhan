/// acc_mover(xAxis, yAxis, usoEnLugar)
var xAxis = argument[0];
var yAxis = argument[1];
var usoEnLugar = argument[2];

if (xAxis != 0 || yAxis != 0) {
    var newX = x + xAxis * xVel;
    var newY = y + yAxis * yVel;
    
    if (!place_meeting(newX, newY, obj_obstaculo)) {
        x = newX;
        y = newY;
    }
    
    image_angle = point_direction(0,0,xAxis,yAxis);
    image_index++;
}
