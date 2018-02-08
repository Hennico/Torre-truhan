/// ds_maze_connect(maze, content)
var maze = argument[0];
var content = argument[1];

var width = ds_grid_width(maze);
var height = ds_grid_height(maze);

var groups = 0;
var used = ds_grid_create(width, height);
ds_grid_clear(used, 0);

var contentCount = 0;
var shuffleIndexes = ds_list_create();
var contentPositions = ds_list_create();
for (var xx = 0; xx < width; xx++) {
for (var yy = 0; yy < height; yy++) {
    if (maze[# xx,yy] == content) {
        ds_list_add(shuffleIndexes,contentCount);
        ds_list_add(contentPositions, xx, yy);
        contentCount++;
    }
}}
ds_list_shuffle(shuffleIndexes);

for (var i = 0; i < contentCount; i++) {
    var positionIndex = shuffleIndexes[| i];
    var xx = contentPositions[| positionIndex*2+0];
    var yy = contentPositions[| positionIndex*2+1];

    if (used[# xx,yy] == 0) {
        groups++;
        var currentX = xx;
        var currentY = yy;
        
        var outter = false;
        
        var contentChain = ds_list_create();
        var nextContent = ds_queue_create();
        ds_queue_enqueue(nextContent,currentX,currentY);
        
        while (!ds_queue_empty(nextContent)) {
            currentX = ds_queue_dequeue(nextContent);
            currentY = ds_queue_dequeue(nextContent);
            ds_list_add(contentChain, currentX, currentY);
            used[# currentX, currentY] = groups;
            
            for (var dir = 0; dir < 360; dir += 90) {
                var nextX = currentX + dcos(dir);
                var nextY = currentY + dsin(dir);
                
                var xOverflow = nextX < 0 || nextX >= width;
                var yOverflow = nextY < 0 || nextY >= height;
                
                if (!xOverflow && !yOverflow) {
                    if (used[# nextX, nextY] == 0 && maze[# nextX, nextY] == content) {
                        ds_queue_enqueue(nextContent, nextX, nextY);
                    }
                } else {
                    outter = true;
                }
            }
        }
        ds_queue_destroy(nextContent);
        
        var tries = ds_list_size(contentChain);
        while (!outter && tries-- > 0) {
            var idx = irandom((ds_list_size(contentChain)/2)-1)*2;
            var randOffset = irandom(3)*90;
            
            var selectX = contentChain[| idx+0];
            var selectY = contentChain[| idx+1];
            
            for (var dir = randOffset; dir < randOffset+360 && !outter; dir += 90) {
                var conectX = selectX + dcos(dir)*2;
                var conectY = selectY + dsin(dir)*2;
                
                outter = used[# conectX, conectY] != used[# selectX, selectY] && used[# conectX, conectY] > 0;
                if (outter) {
                    var newGroup = used[# conectX, conectY];
                    used[# selectX + dcos(dir), selectY + dsin(dir)] = newGroup;
                    maze[# selectX + dcos(dir), selectY + dsin(dir)] = content;
                    
                    for (var ind = 0; ind < ds_list_size(contentChain)/2; ind++){
                        var contentX = contentChain[| ind+0];
                        var contentY = contentChain[| ind+1];
                        
                        used[# contentX,contentY] = newGroup;
                    }
                }
            }
        }
        ds_list_destroy(contentChain);
    }
}
ds_grid_destroy(used);
ds_list_destroy(shuffleIndexes);
ds_list_destroy(contentPositions);
