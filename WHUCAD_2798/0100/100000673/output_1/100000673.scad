
// Parameters for key component dimensions
key_length = 30;  // Total length of the key
key_width = 12;   // Width of the key
key_thickness = 5; // Thickness of the key
rounded_edge_diameter = 6; // Diameter for rounded features

// Parameters for central shaft
central_shaft_diameter = 4; // Reduced diameter for central shaft
central_shaft_length = 20;  // Length of central shaft

// Parameters for input shaft
input_shaft_taper_length = 5; // Length of the taper on input shaft
input_shaft_diameter_min = 3; // Minimum diameter at taper
input_shaft_diameter_max = 4; // Maximum diameter before taper

// Parameters for output shaft
output_shaft_length = 25;  // Extended length of output shaft
output_shaft_diameter = 4; // Diameter of output shaft

// Parameters for spacer rings
spacer_ring_thickness = 2; // Reduced thickness for spacer rings
spacer_ring_diameter = 5;  // Diameter of spacer rings

// Parameters for flange plate
flange_plate_bolt_hole_diameter = 3; // Enlarged bolt hole diameter

// Parameters for nuts and bolts
nut_side_length = 3; // Side length for hexagonal nuts
bolt_length = 7;     // Extended length for bolts
bolt_diameter = 2;   // Diameter of bolts

// Module Definitions
module central_shaft() {
    cylinder(d = central_shaft_diameter, h = central_shaft_length, center = true);
}

module input_shaft() {
    cylinder(d1 = input_shaft_diameter_min, d2 = input_shaft_diameter_max, h = input_shaft_taper_length, center = true);
}

module output_shaft() {
    rotate([90, 0, 0])
        cylinder(d = output_shaft_diameter, h = output_shaft_length, center = true);
}

module spacer_ring() {
    cylinder(d = spacer_ring_diameter, h = spacer_ring_thickness, center = true);
}

module flange_plate() {
    difference() {
        cylinder(d = 15, h = 1, center = true);
        translate([flange_plate_bolt_hole_diameter / 2, 0, 0])
            rotate([0, 90, 0])
            cylinder(d = flange_plate_bolt_hole_diameter, h = 1, center = true);
    }
}

module nut() {
    for (i = [0 : 5])
        rotate([0, 0, i * 60])
            translate([nut_side_length / 2, 0, 0])
            square([nut_side_length, nut_side_length]);
}

module bolt() {
    cylinder(d = bolt_diameter, h = bolt_length, center = true);
}

module key() {
    difference() {
        // Create the base shape of the key with sleek curved design
        resize([key_length, key_width, key_thickness]) 
            cylinder(d = key_width, h = key_thickness, center = true);
        
        // Ensure proper insertion alignment
        translate([0, 0, -key_thickness / 2 + 1]) // Improved positioning
            square([key_width - 2, 2], center = true);
    }
}

// Render the components
translate([0, 0, 10]) central_shaft();
translate([0, 0, -5]) input_shaft();
translate([0, 10, 5]) output_shaft();
translate([10, 0, 0]) spacer_ring();
translate([-10, -10, 0]) flange_plate();
translate([0, -10, 0]) nut();
translate([0, 10, 0]) bolt();
key();

