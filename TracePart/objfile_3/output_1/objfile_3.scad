
```openscad
// Parameters
central_body_diameter = 20;
central_body_length = 20; // Adjusted to be shorter
slot_width = 5; // Enlarged slots
slot_depth = 18;
bolt_hole_diameter = 4;
bolt_diameter = 3;
bolt_head_diameter = 7; // Adjusted head diameter
bolt_head_height = 2.5; // Adjusted head height to be flatter
offset_between_layers = 2;
bolt_positions = [-6, 6]; // Adjusted positions for alignment

// Functions for components
module central_cylindrical_body() {
    difference() {
        cylinder(d = central_body_diameter, h = central_body_length, center = true);
        translate([0, 0, -central_body_length / 2])
            cube([slot_width, central_body_diameter, slot_depth], center = false);
        rotate([0, 90, 0])
            for (pos = bolt_positions) {
                translate([0, pos, 0])
                    cylinder(d = bolt_hole_diameter, h = central_body_length + 5, center = true);
            }
    }
}

module clamping_bolt() {
    union() {
        cylinder(d = bolt_diameter, h = (central_body_length / 2) * 0.8, center = true); // Shorter shaft
        translate([0, 0, (central_body_length / 4) * 0.8]) // Adjusted position
            cylinder(d = bolt_head_diameter, h = bolt_head_height, center = true);
    }
}

// Assembly
module layer_1() {
    translate([0, 0, central_body_length / 2])
        central_cylindrical_body();
    for (pos = bolt_positions)
        translate([0, pos, central_body_length / 2])
            clamping_bolt();
}

module layer_2() {
    translate([0, 0, -central_body_length / 2 - offset_between_layers])
        central_cylindrical_body();
    for (pos = bolt_positions)
        translate([0, pos, -central_body_length / 2 - offset_between_layers])
            clamping_bolt();
}

// Final Assembly
layer_1();
layer_2();
```

