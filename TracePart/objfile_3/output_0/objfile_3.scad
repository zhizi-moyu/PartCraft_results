
// Parameters
central_body_diameter = 20;
central_body_length = 25;
slot_width = 3;
slot_depth = 18;
bolt_hole_diameter = 4;
bolt_diameter = 3;
bolt_head_diameter = 6;
bolt_head_height = 3;
offset_between_layers = 2;

// Functions for components
module central_cylindrical_body() {
    difference() {
        cylinder(d = central_body_diameter, h = central_body_length, center = true);
        translate([0, 0, -central_body_length / 2])
            cube([slot_width, central_body_diameter, slot_depth], center = false);
        rotate([0, 90, 0])
            for (pos = [-7, 7]) {
                translate([0, pos, 0])
                    cylinder(d = bolt_hole_diameter, h = central_body_length + 5, center = true);
            }
    }
}

module clamping_bolt() {
    union() {
        cylinder(d = bolt_diameter, h = central_body_length / 2, center = true);
        translate([0, 0, central_body_length / 4])
            cylinder(d = bolt_head_diameter, h = bolt_head_height, center = true);
    }
}

// Assembly
module layer_1() {
    translate([0, 0, central_body_length / 2])
        central_cylindrical_body();
    for (pos = [-7, 7])
        translate([0, pos, central_body_length / 2])
            clamping_bolt();
}

module layer_2() {
    translate([0, 0, -central_body_length / 2 - offset_between_layers])
        central_cylindrical_body();
    for (pos = [-7, 7])
        translate([0, pos, -central_body_length / 2 - offset_between_layers])
            clamping_bolt();
}

// Final Assembly
layer_1();
layer_2();

