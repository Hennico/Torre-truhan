/// ds_grid_mazeify_conect_value(grid, value)
var blueprints = argument[0];
var content = argument[1];

var maze_width = ds_grid_width(blueprints);
var maze_height = ds_grid_height(blueprints);

var used = ds_map_create();
var chain = ds_list_create();
var chained = ds_grid_create(maze_width, maze_height);

var itsChained = true;
ds_grid_clear(chained, false);
for (var xx = 0; xx < maze_width; xx++) {
for (var yy = 0; yy < maze_height ; yy++) {
    var isContent = blueprints[# xx,yy] == content;
    var itsUsed = ds_map_exists(used, xx*10000+yy);
    
    if (isContent && !itsUsed) {
        var queue = ds_queue_create();
        ds_queue_enqueue(queue,xx,yy);
        
        while(!ds_queue_empty(queue)) {
            var xact = ds_queue_dequeue(queue);
            var yact = ds_queue_dequeue(queue);
            ds_list_add(chain,xact,yact);
            used[? xact*10000+yact] = false;
            
            for (var dir = 0; dir < 360; dir += 90) {
                var xnew = xact + dcos(dir);
                var ynew = yact + dsin(dir);
                
                var xvalido = between(xnew,0,maze_width-1);
                var yvalido = between(ynew,0,maze_height-1);
                
                if (!itsChained) { itsChained = !(xvalido && yvalido); }
                
                var posUsed = ds_map_exists(used, xnew*10000+ynew);
                used[? xnew*10000+ynew] = false;
                
                if (xvalido && yvalido && !posUsed) {
                    if (blueprints[# xnew,ynew] == content) {
                        ds_queue_enqueue(queue, xnew, ynew);
                    }
                } 
            }
        }
        
        ds_queue_destroy(queue);
        
        
        while (!itsChained) {
            var imax = ds_list_size(chain)/2;
            var i = irandom(imax-1);
            
            var xact = chain[| 2*i+0];
            var yact = chain[| 2*i+1];
            
            var desv = irandom(3) * 90;
            
            for (var dir = 0; dir < 360 && !itsChained; dir += 90) {
                var deltax = dcos(dir+desv);
                var deltay = dsin(dir+desv);
                
                var chainX = xact+2*deltax;
                var chainY = yact+2*deltay;
                
                var isStart = global.entradaX == chainX && global.entradaY == chainY
                
                if (chained[# chainX,chainY] && !isStart) {
                    blueprints[# xact+deltax,yact+deltay] = content;
                    ds_list_add(chain,xact+deltax,yact+deltay);
                    itsChained = true;
                }
            }
        }
        
        for (var i = 0; i < ds_list_size(chain)/2; i++) {
            var xnew = chain[| 2*i+0];
            var ynew = chain[| 2*i+1];
            
            chained[# xnew,ynew] = itsChained;
        }
        
        itsChained = false;
        ds_list_clear(chain);
    }
}}

ds_map_destroy(used);
ds_list_destroy(chain);
ds_grid_destroy(chained);
