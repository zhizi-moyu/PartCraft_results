
// Basic dimensions
shaft_diameter = 12; // Adjusted for identical dimensions
shaft_length = 25; // Adjusted for original length
spacer_thickness = 1; // Reduced thickness for delicate structure
flange_thickness = 2; // Reduced thickness as per original model
flange_diameter = 14; // Adjusted diameter for original appearance
nut_size = 3.5; // Matching original nut size
bolt_length = 14; // Adjusted length to match original bolts
bolt_diameter = 1.5; // Adjusted for thinner bolts
extension_length = 5; // Added extension for input shaft

module central_shaft() {
    // Adjusted central shaft for proper structural integrity and uniformity
    cylinder(h=shaft_length, d=shaft_diameter);
}

module input_shaft() {
    // Corrected input shaft by adding extension and refining hollow structure
    translate([shaft_diameter, 0, -shaft_length / 2])
        difference() {
            cylinder(h=shaft_length + extension_length, d=shaft_diameter / 2);
            translate([0, 0, shaft_length / 2])
                cylinder(h=shaft_length, d=shaft_diameter / 2.5);
        }
}

module output_shaft() {
    // Corrected output shaft dimensions and improved hollow coupling
    translate([-shaft_diameter, 0, -shaft_length / 2])
        difference() {
            cylinder(h=shaft_length + extension_length, d=shaft_diameter / 2);
            translate([0, 0, shaft_length / 2])
                cylinder(h=shaft_length, d=shaft_diameter / 2.5);
        }
}

module spacer_ring() {
    // Reduced thickness and centered spacer ring
    difference() {
        cylinder(h=spacer_thickness, d=shaft_diameter);
        cylinder(h=spacer_thickness, d=shaft_diameter - 2);
    }
}

module flange_plate() {
    // Added 4 thinner flange plates with proper drilled holes
    difference() {
        cylinder(h=flange_thickness, d=flange_diameter);
        for (angle = [0, 90, 180, 270])
            rotate([0, 0, angle])
                translate([flange_diameter / 3, 0, 0])
                    cylinder(h=flange_thickness + 0.5, d=bolt_diameter + 1);
    }
}

module hexagonal_nut() {
    // Adjusted for larger nuts matching original model
    cylinder(h=nut_size, d=nut_size, $fn=6);
}

module bolt() {
    // Adjusted for thinner bolts and refined threading
    cylinder(h=bolt_length, d=bolt_diameter, $fn=30);
}

module translated_components() {
    // Assemble components and added additional flange plates
    central_shaft();
    translate([0, 0, shaft_length / 2])
        flange_plate();
    translate([0, 0, shaft_length / 2 + flange_thickness])
        spacer_ring();
    translate([0, 0, shaft_length / 2 + flange_thickness + spacer_thickness])
        flange_plate();
    translate([0, 0, shaft_length / 2 + 2 * flange_thickness + spacer_thickness])
        flange_plate();
    translate([0, 0, shaft_length / 2 + 3 * flange_thickness + spacer_thickness])
        flange_plate();
    input_shaft();
    output_shaft();
}

// Assembling nuts and bolts to align with flange plates

module nuts_bolts_assembly() {
    for (flange_position = [1, 3, 5])
        for (angle = [0, 90, 180, 270]) {
            rotate([0, 0, angle])
                translate([flange_diameter / 3, 0, shaft_length / 2 + flange_position * flange_thickness])
                    hexagonal_nut();
            rotate([0, 0, angle])
                translate([flange_diameter / 3, 0, shaft_length / 2 + flange_position * flange_thickness + nut_size])
                    bolt();
        }
}

translated_components();
nuts_bolts_assembly();

