
// Basic dimensions
shaft_diameter = 10;
shaft_length = 20;
spacer_thickness = 1.5; // Adjusted thickness for better fitting
flange_thickness = 3;
flange_diameter = 12;
nut_size = 3;
bolt_length = 15;
bolt_diameter = 2;

module central_shaft() {
    // Ensure the central shaft is clearly defined and positioned centrally.
    translate([0, 0, -shaft_length / 2])
        cylinder(h=shaft_length, d=shaft_diameter);
}

module input_shaft() {
    // Define the input shaft with an extension for proper alignment.
    translate([shaft_diameter, 0, -shaft_length / 2])
        difference() {
            cylinder(h=shaft_length, d=shaft_diameter / 1.5); // Adjusted for clear output
            translate([0, 0, shaft_length / 3])
                cylinder(h=shaft_length, d=shaft_diameter / 2);
        }
}

module output_shaft() {
    // Adjust the output shaft to match the original cylindrical, hollow shape.
    translate([-shaft_diameter, 0, -shaft_length / 2])
        difference() {
            cylinder(h=shaft_length, d=shaft_diameter / 1.5); // Adjusted for hollow shape
            translate([0, 0, shaft_length / 3])
                cylinder(h=shaft_length, d=shaft_diameter / 2);
        }
}

module spacer_ring() {
    // Thin, circular spacer ring added between components.
    difference() {
        cylinder(h=spacer_thickness, d=shaft_diameter);
        translate([0, 0, -0.1]) // Slightly adjusted for precise separation
            cylinder(h=spacer_thickness + 0.2, d=shaft_diameter - 3);
    }
}

module flange_plate() {
    // Ensure flange plates are uniformly cylindrical with drilled holes.
    difference() {
        cylinder(h=flange_thickness, d=flange_diameter);
        for (x = [-bolt_diameter, bolt_diameter])
            for (y = [-bolt_diameter, bolt_diameter])
                translate([x, y, 0])
                    cylinder(h=flange_thickness + 1, d=nut_size);
    }
}

module hexagonal_nut() {
    // Position hex nuts for effective fastening.
    cylinder(h=nut_size, d=nut_size, $fn=6);
}

module bolt() {
    // Insert bolts into nuts similarly to the original model.
    cylinder(h=bolt_length, d=bolt_diameter);
}

module translated_components() {
    // Assemble components
    central_shaft();
    translate([0, 0, shaft_length / 2 + spacer_thickness / 2])
        flange_plate();
    translate([0, 0, shaft_length / 2 + spacer_thickness + flange_thickness])
        spacer_ring();
    translate([0, 0, shaft_length / 2 + spacer_thickness + flange_thickness + flange_thickness])
        flange_plate();
    input_shaft();
    output_shaft();
}

translated_components();

// Assemble nuts and bolts 
for (i = [-shaft_diameter / 2, shaft_diameter / 2]) {
    for (j = [shaft_length / 2 - nut_size, shaft_length / 2 + nut_size]) {
        translate([i, j, shaft_length + spacer_thickness + flange_thickness])
            hexagonal_nut();
        translate([i, j, -shaft_length / 2])
            bolt();
    }
}

