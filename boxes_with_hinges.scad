include <NopSCADlib/utils/core/core.scad>

//            name                           w,   d,  h,hw,hd,r
SAMPLE_BOX = ["ABS_cyclone_with_elements", 100, 150, 30, 40, 8,3];

use <box_with_hinges.scad>

box_with_hinges_assembly(SAMPLE_BOX);
