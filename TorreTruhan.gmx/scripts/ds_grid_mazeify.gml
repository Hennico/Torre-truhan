/// ds_grid_mazeify(grid, wallValue, floorValue, startX, startY, polish)
var blueprint = argument[0];
var wallValue = argument[1];
var floorValue = argument[2];
var startX = argument[3];
var startY = argument[4];
var polish = argument[5];

var maze_width  = ds_grid_width (blueprint);
var maze_height = ds_grid_height(blueprint);

enum MazePolishOption {
    no_polish,
    walls,
    floors,
    both
}

ds_grid_clear(blueprint, floorValue);
for (var xx = 0; xx < maze_width ; xx++) {
for (var yy = 0; yy < maze_height; yy++) {
    var borderX = xx == 0 || xx == maze_width-1;
    var borderY = yy == 0 || yy == maze_height-1;
    var startPosition = (xx == startX) && (yy == startY);
    
    if ((borderX || borderY)) {
        if (!startPosition)
            blueprint[# xx,yy] = wallValue;
    } else {
        var oddPosition = (xx mod 2 == (startX-1) mod 2) && (yy mod 2 == (startY-1) mod 2)
       
        if (oddPosition) {
            blueprint[# xx,yy] = wallValue;
            
            var wallDirection = irandom(3) * 90;
            blueprint[# xx + dcos(wallDirection),yy + dsin(wallDirection)] = wallValue;
        }
    }
}
}

if (polish == MazePolishOption.walls || polish == MazePolishOption.both)
    ds_grid_mazeify_conect_value(blueprint,wallValue);
if (polish == MazePolishOption.floors || polish == MazePolishOption.both)
    ds_grid_mazeify_conect_value(blueprint,floorValue);

