/// ds_grid_maze(width, height, floorValue, wallValue, entrancePos, exitPos, MazeOrientation, MazePolish)
var width = argument[0]; // Must be odd
var height = argument[1]; // Must be odd
var floorValue = argument[2];
var wallValue = argument[3];
var entrancePos = argument[4]; // Must be odd
var exitPos = argument[5]; // Must be odd
var orientation = argument[6];
var polish = argument[7];

enum MazeOrientation {
    north_to_south,
    north_to_east ,
    north_to_weast,
    
    south_to_north,
    south_to_east ,
    south_to_weast,
    
    east_to_weast,
    east_to_north,
    east_to_south,
    
    weast_to_east ,
    weast_to_north,
    weast_to_south,
    ammount
};

enum MazePolish {
    non,
    walls,
    floors,
    both,
    ammount
}

var maze = ds_grid_create(width, height);

// Make unpolished maze
for (var xx = 0; xx < width; xx++) {
for (var yy = 0; yy < height; yy++) {
    var outerWall = xx == 0 || xx == width-1 || yy == 0 || yy == height-1;
    
    if (outerWall) {
        var isExit = false;
        var entrance = false;
        
        switch(orientation) {
            case MazeOrientation.north_to_south:
                isExit = xx == exitPos && yy == height-1;
                entrance = xx == entrancePos && yy == 0;
                break;
            case MazeOrientation.north_to_east:
                isExit = yy == exitPos && xx == width-1;
                entrance = xx == entrancePos && yy == 0;
                break;
            case MazeOrientation.north_to_weast:
                isExit = yy == exitPos && xx == 0;
                entrance = xx == entrancePos && yy == 0;
                break;
            
            case MazeOrientation.south_to_north:
                isExit = xx == exitPos && yy == 0;
                entrance = xx == entrancePos && yy == height-1;
                break;
            case MazeOrientation.south_to_east:
                isExit = yy == exitPos && xx == width-1;
                entrance = xx == entrancePos && yy == height-1;
                break;
            case MazeOrientation.south_to_weast:
                isExit = yy == exitPos && xx == 0;
                entrance = xx == entrancePos && yy == height-1;
                break;
            
            case MazeOrientation.east_to_weast:
                isExit = yy == exitPos && xx == 0;
                entrance = yy == entrancePos && xx == width-1;
                break;
            case MazeOrientation.east_to_north:
                isExit = xx == exitPos && yy == 0;
                entrance = yy == entrancePos && xx == width-1;
                break;
            case MazeOrientation.east_to_south:
                isExit = xx == exitPos && yy == height-1;
                entrance = yy == entrancePos && xx == width-1;
                break;
            
            case MazeOrientation.weast_to_east:
                isExit = yy == exitPos && xx == width-1;
                entrance = yy == entrancePos && xx == 0;
                break;
            case MazeOrientation.weast_to_north:
                isExit = xx == exitPos && yy == 0;
                entrance = yy == entrancePos && xx == 0;
                break;
            case MazeOrientation.weast_to_south:
                isExit = xx == exitPos && yy == height-1;
                entrance = yy == entrancePos && xx == 0;
                break;
        }
        
        
        if (!entrance && !isExit) {
            maze[# xx,yy] = wallValue;
        } else {
            maze[# xx,yy] = floorValue;
        }
    } else {
        var evenPosition = ((xx) mod 2) == 0 && ((yy) mod 2) == 0;
        if (evenPosition) {
            var dir = irandom(3) * 90;
            
            maze[# xx,yy] = wallValue;
            maze[# xx+dcos(dir), yy+dsin(dir)] = wallValue;
        }
    }
}}

if (polish == MazePolish.walls || polish == MazePolish.both)
    ds_maze_connect(maze,wallValue);

if (polish == MazePolish.floors || polish == MazePolish.both)
    ds_maze_connect(maze,floorValue);

return maze;
