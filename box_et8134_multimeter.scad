include <NopSCADlib/utils/core/core.scad>

use <box_with_hinges.scad>

ET8134_BOX = ["ET8134", 140, 185, 30, 40, 6, 4];

ET8124_PLACE = [-27,17.5,0];
ET8124_BODY = [76,142,24, 5];

THERM_PLACE = [0,-72.5,0];
THERM_BODY = [130,30,24, 8];

PROBE_PLACE = [40,1,0];
PROBE_BODY = [50,175,24, 8];

// wire columns
module columns() {
    for(y = [-1,1])
    translate([0,y*50,0]) {
        hull() {
            for(x = [-1,1])
                translate([0,x*5,0])
                cylinder(d = 6, h = 10);
        }
        hull() {
            for(x = [-1,1])
                translate([0, x * 5, 0]) {
                    hull() {
                        translate_z(10)
                        cylinder(d = 6, h = .1);
                        translate_z(14)
                        cylinder(d = 10, h = .1);
                    }
                }
        }
    }

}


// draw your own box
module box_with_hinges_bottom_sample_stl() {
    difference(){
        translate_z(-3)
        box_with_hinges_bottom(ET8134_BOX);

        // place pockets
        translate(ET8124_PLACE)
        rounded_cube_xy(ET8124_BODY, r = ET8124_BODY[3], xy_center = true);

        translate(THERM_PLACE)
        rounded_cube_xy(THERM_BODY, r = THERM_BODY[3], xy_center = true);

        translate(PROBE_PLACE)
        rounded_cube_xy(PROBE_BODY, r = PROBE_BODY[3], xy_center = true);
    }
    translate(PROBE_PLACE)
    translate_z(-3)
    columns();
}
// draw your own box
module box_with_hinges_top_sample_stl() {
    difference(){
        translate_z(30-3)
        vflip()
        box_with_hinges_top(ET8134_BOX);

        // place pockets
        translate(ET8124_PLACE)
        rounded_cube_xy(ET8124_BODY, r = ET8124_BODY[3], xy_center = true);

        translate(THERM_PLACE)
        rounded_cube_xy(THERM_BODY, r = THERM_BODY[3], xy_center = true);

        translate(PROBE_PLACE)
        rounded_cube_xy(PROBE_BODY, r = PROBE_BODY[3], xy_center = true);
    }
    translate(PROBE_PLACE)
    translate_z(30-3)
    vflip()
    columns();
}
//translate([50,0,80])
rotate([0,180,0])
box_with_hinges_top_sample_stl();
//box_with_hinges_bottom_sample_stl();

//box_with_hinges_assembly(ET8134_BOX);
