
// Basic dimensions
shaft_diameter = 10;
shaft_length = 20;
spacer_thickness = 2;
flange_thickness = 3;
flange_diameter = 12;
nut_size = 3;
bolt_length = 15;
bolt_diameter = 2;

module central_shaft() {
    cylinder(h=shaft_length, d=shaft_diameter);
}

module input_shaft() {
    difference() {
        cylinder(h=shaft_length, d=shaft_diameter);
        translate([0, 0, shaft_length / 2])
            cylinder(h=shaft_length, d=shaft_diameter / 2);
    }
}

module output_shaft() {
    difference() {
        cylinder(h=shaft_length, d=shaft_diameter);
        translate([0, 0, shaft_length / 2])
            cylinder(h=shaft_length, d=shaft_diameter / 2);
    }
}

module spacer_ring() {
    difference() {
        cylinder(h=spacer_thickness, d=shaft_diameter);
        cylinder(h=spacer_thickness, d=shaft_diameter - 3);
    }
}

module flange_plate() {
    difference() {
        cylinder(h=flange_thickness, d=flange_diameter);
        translate([bolt_diameter / 2, bolt_diameter / 2, 0])
            cylinder(h=flange_thickness, d=nut_size);
    }
}

module hexagonal_nut() {
    cylinder(h=nut_size, d=nut_size, $fn=6);
}

module bolt() {
    cylinder(h=bolt_length, d=bolt_diameter);
}

translated_components() {
    translate([-shaft_diameter / 2, 0, -shaft_length / 2]) {
        central_shaft();
    }
    translate([0, 0, shaft_length / 2 + spacer_thickness])
        flange_plate();
    translate([0, 0, shaft_length / 2 + spacer_thickness + flange_thickness])
        spacer_ring();
    translate([0, 0, shaft_length + spacer_thickness + flange_thickness])
        flange_plate();
    translate([-shaft_diameter, 0, shaft_length])
        output_shaft();
    translate([shaft_diameter, 0, shaft_length])
        input_shaft();
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

