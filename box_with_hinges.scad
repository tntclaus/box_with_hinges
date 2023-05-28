include <NopSCADlib/utils/core/core.scad>

function box_with_hinges_name(type) = type[0];
function box_with_hinges_width(type) = type[1];
function box_with_hinges_depth(type) = type[2];
function box_with_hinges_heigth(type) = type[3];
function box_with_hinges_hinge_width(type) = type[4];
function box_with_hinges_hinge_dia(type) = type[5];
function box_with_hinges_box_r(type) = type[6];


module box_latch(type, top = false) {
    w = box_with_hinges_width(type);
    h = box_with_hinges_heigth(type);
    d = box_with_hinges_depth(type);

    hw = box_with_hinges_hinge_width(type);
    hd = 2;

    if(top) {
        translate([- w / 2, d / 2 - hw / 2 * 1.5, h / 2 - hd]) {
            difference() {
                union() {
                    hull() {
                        translate_z(- 2)
                        cube([.1, hw / 2, 4], center = true);
                        translate([- 1.2, 0, 1])
                            rotate([90, 0, 0])
                                cylinder(d = hd, h = hw / 2, center = true);
                    }
                    hull() {
                        translate([- 1.2, 0, 1])
                            rotate([90, 0, 0])
                                cylinder(d = hd, h = hw / 2, center = true);
                        translate([- 1.2, 0, 5])
                            rotate([90, 0, 0])
                                cylinder(d = hd, h = hw / 2, center = true);
                    }
                }

                translate([0, 0, 4])
                    rotate([90, 0, 0])
                        cylinder(d = hd+.1, h = hw, center = true);
            }

        }
    } else {
        translate([- w / 2, d / 2 - hw / 2 * 1.5, h / 2 - hd]) {
            rotate([90, 0, 0])
                cylinder(d = hd, h = hw / 2, center = true);
        }
    }
}

module box_half_hinge(type, top = false) {
    w = box_with_hinges_width(type);
    h = box_with_hinges_heigth(type);
    d = box_with_hinges_depth(type);

    hw = box_with_hinges_hinge_width(type);
    hd = box_with_hinges_hinge_dia(type);

    translate([w / 2 + hd / 2, d / 2 - hw / 2 * 1.5, h / 2])
        difference() {
            rotate([90, 0, 0])
                hull() {
                    cylinder(d = hd, h = hw, center = true);
                    translate([- 4, - hd / 2 * 2.5, 0])
                        cylinder(d = .1, h = hw + 5, center = true);
                }

            rotate([90, 0, 0]) {
                cylinder(d = hd / 2, h = hw * 1.1, center = true);

                if (top)
                    translate([0, 0, hw / 2 + 1])
                        cylinder(d = hd + .1, h = 2, center = true);
            }

            translate([0, top ? - hw / 4 / 2 : hw / 4 / 2, 0]) {
                translate([0, top ? (hw / 2 + 5) : - (hw / 2 + 5), 0])
                    cube([50, hw / 4 + .5 + 10, 50], center = true);
                cube([50, hw / 4 + .5, 50], center = true);
            }
        }
}

module box_half(type) {
    w = box_with_hinges_width(type);
    h = box_with_hinges_heigth(type);
    d = box_with_hinges_depth(type);
    br = box_with_hinges_box_r(type);

    translate_z(br)
    rounded_cube_xy([w, d, h / 2 - br], r = br, xy_center = true);
    hull() {
        for (x = [- 1, 1])
        for (y = [- 1, 1])
        translate([x * (w / 2 - br), y * (d / 2 - br), br]) {
            sphere(r = br);
        }
    }

}


module box_with_hinges_top(type) {
    stl(str("box_with_hinges_top_", type[0]));

    box_half(type);

    box_half_hinge(type, true);
    box_latch(type, true);

    mirror([0, 1, 0]) {
        box_latch(type, true);
        box_half_hinge(type, true);
    }
}

module box_with_hinges_bottom(type) {
    stl(str("box_with_hinges_bottom_", type[0]));

    box_half(type);

    box_half_hinge(type);
    box_latch(type);
    mirror([0, 1, 0]) {
        box_latch(type);
        box_half_hinge(type);
    }

}

module box_with_hinges_assembly(type) {
    h = box_with_hinges_heigth(type);

    box_with_hinges_bottom(type);

    translate_z(h)
    vflip()
        box_with_hinges_top(type);
}
