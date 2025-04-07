
// Define dimensions
cylinder_diameter = 20;
cylinder_height = 20;
hole_diameter = 5;
groove_width = 2;
groove_depth = 4;
spacer_thickness = 1;

// Cylinder Body
module cylinder_body() {
    difference() {
        cylinder(d=cylinder_diameter, h=cylinder_height, $fn=100);
        cylinder(d=hole_diameter, h=cylinder_height, $fn=100);
        
        // Adding grooves
        for (i = [-120, 0, 120]) {
            rotate([0, 0, i]) {
                translate([cylinder_diameter/2, -groove_width/2, cylinder_height / 4]) {
                    cube([groove_depth, groove_width, cylinder_height / 2], center=false);
                }
            }
        }
    }
}

// Internal Spacer
module internal_spacer() {
    difference() {
        cylinder(d=cylinder_diameter, h=spacer_thickness, $fn=100);
        cylinder(d=hole_diameter, h=spacer_thickness, $fn=100);
    }
}

// Assembly
module assembly() {
    translate([0, 0, cylinder_height]) {
        cylinder_body();
    }
    translate([0, 0, (cylinder_height - spacer_thickness) / 2]) {
        internal_spacer();
    }
    translate([0, 0, 0]) {
        cylinder_body();
    }
}

// Main Module
assembly();

