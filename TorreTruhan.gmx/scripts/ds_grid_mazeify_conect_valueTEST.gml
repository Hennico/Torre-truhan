/// ds_grid_mazeify_conect_valueTEST(grid, value)
var blueprints = argument[0];
var content = argument[1];

var width = ds_grid_width(blueprints);
var height = ds_grid_height(blueprints);

var groups = 0;
var used = ds_grid_create(width, height);
ds_grid_clear(used, 0);

var contentCount = 0;
var shuffleIndexes = ds_list_create();
var contentPositions = ds_list_create();

var firstX = -1;
var firstY = -1;

for (var xx = 0; xx < width; xx++) {
for (var yy = 0; yy < height; yy++) { 
    if (blueprints[# xx,yy] == content) {
        if (firstX < 0 && firstY < 0) {
            firstX = xx;
            firstY = yy;
        }
        
        ds_list_add(shuffleIndexes,contentCount);
        ds_list_add(contentPositions, xx, yy);
        contentCount++;
    }
}}
//ds_list_shuffle(shuffleIndexes);
ds_list_insert(shuffleIndexes,0,firstX);
ds_list_insert(shuffleIndexes,1,firstY);

var outter = true;
for (var i = 0; i < contentCount; i++) {
    var positionIndex = shuffleIndexes[| i];
    var xx = contentPositions[| positionIndex*2+0];
    var yy = contentPositions[| positionIndex*2+1];

    if (used[# xx,yy] == 0 && groups < global.test_topGroups) {
        groups++;
        var currentX = xx;
        var currentY = yy;
        
        var contentChain = ds_list_create();
        var nextContent = ds_queue_create();
        var shuffleContentIndexes = ds_list_create();
        ds_queue_enqueue(nextContent,currentX,currentY);
        
        while (!ds_queue_empty(nextContent)) {
            currentX = ds_queue_dequeue(nextContent);
            currentY = ds_queue_dequeue(nextContent);
            ds_list_add(shuffleContentIndexes, ds_list_size(contentChain) div 2);
            ds_list_add(contentChain, currentX, currentY);
            used[# currentX, currentY] = groups;
            
            for (var dir = 0; dir < 360; dir += 90) {
                var nextX = currentX + dcos(dir);
                var nextY = currentY + dsin(dir);
                
                var xOverflow = nextX < 0 || nextX >= width;
                var yOverflow = nextY < 0 || nextY >= height;
                
                if (!xOverflow && !yOverflow) {
                    if (used[# nextX, nextY] == 0 && blueprints[# nextX, nextY] == content) {
                        ds_queue_enqueue(nextContent, nextX, nextY);
                    }
                } else {
                    outter = true;
                }
            } 
        }
        ds_queue_destroy(nextContent);
        
        ds_list_shuffle(shuffleContentIndexes);
        for (var idx = 0; !outter && idx < ds_list_size(shuffleContentIndexes); idx++) {
            var randOffset = irandom(3)*90;
            var selectX = contentChain[| shuffleContentIndexes[| idx] +0];
            var selectY = contentChain[| shuffleContentIndexes[| idx] +1];
            
            for (var dir = randOffset; dir < randOffset+360 && !outter; dir += 90) {
                var conectX = selectX + dcos(dir)*2;
                var conectY = selectY + dsin(dir)*2;
                
                if (blueprints[# conectX, conectY] == content)
                    outter = used[# conectX, conectY] != used[# selectX, selectY];// && used[# conectX, conectY] > 0;
                    
                if (outter) {
                    var newGroup = used[# conectX, conectY];
                    used[# selectX + dcos(dir), selectY + dsin(dir)] = newGroup;
                    blueprints[# selectX + dcos(dir), selectY + dsin(dir)] = content;
                    
                    for (var ind = 0; ind < ds_list_size(contentChain)/2; ind++){
                        var contentX = contentChain[| ind+0];
                        var contentY = contentChain[| ind+1];
                        
                        used[# contentX,contentY] = newGroup;
                        used[# contentX,contentY] = groups;
                    }
                }
            }
        }
        ds_list_destroy(contentChain);
        ds_list_destroy(shuffleContentIndexes);
        
        outter = false;
    }
}
ds_grid_destroy(used);
ds_list_destroy(shuffleIndexes);
ds_list_destroy(contentPositions);
