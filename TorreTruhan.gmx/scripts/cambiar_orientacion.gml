/// cambiar_orientacion(pantalla, pad)
enum OrientacionPad {
    zurdo,
    diestro
}

enum OrientacionPantalla {
    menuIzquierda,
    menuAbajo,
    menuDerecha,
    menuArriba
}

var orientacion    = argument[0];
var orientacionPad = argument[1];

var orientacion_xview = new_array(-512,   0,   0,   0)
var orientacion_yview = new_array(   0,   0,   0,-512)
var orientacion_xmenu = new_array(-512,   0, 512,   0)
var orientacion_ymenu = new_array(   0, 512,   0,-512)

var vertical = ((orientacion mod 2) == 0);

if (vertical) {
    view_hview = 512;
    view_wview = 1024;
    
} else {
    view_hview = 1024;
    view_wview = 512;
}

view_hport = view_hview;
view_wport = view_wview;

surface_resize(application_surface, view_wport,view_hport);
window_set_size(view_wview, view_hview);

view_xview = orientacion_xview[orientacion];
view_yview = orientacion_yview[orientacion];

global.menu_xoffset = orientacion_xmenu[orientacion];
global.menu_yoffset = orientacion_ymenu[orientacion];

if (orientacionPad == OrientacionPad.zurdo) {
    global.pad_xoffset = 120;
    global.pad_yoffset = 256;
} else {
    global.pad_xoffset = 512-120;
    global.pad_yoffset = 256;
}


with (obj_menu) { event_user(0); }
