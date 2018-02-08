/// instance_create_ext(x, y, obj, arg0, ... , arg12)
var xx = argument[0];
var yy = argument[1];
var obj = argument[2];

var argsSize = argument_count - 3;
global.inst_arguments = undefined;

for (var i = 0; i < argsSize; i++)
    global.inst_arguments[i] = argument[i+3];

instance_create(xx,yy,obj);
