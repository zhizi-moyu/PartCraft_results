
// Define bracket dimensions
module bracket_A() {
    // Longer arm
    cube([10, 2, 2]);
    // Shorter arm with rounded edge
    translate([0, 2, 0]) {
        cube([2, 6, 2], center = false);
        translate([-1, 5, 0])
            rotate([0, 0, 45])
            cylinder(h = 2, r = 1, center = false);
    }
}

module bracket_B() {
    // Rectangular features with more pronounced corner curve
    hull() {
        cube([10, 2, 2]);
        translate([2, 6, 0])
            cube([2, 6, 2], center = false);
        translate([0, 10, 0])
            cylinder(h = 2, r = 1.5, center = false);
    }
}

module bracket_C() {
    // Distinct corner rounding with different lengths
    translate([2, 0, 0]) {
        cube([8, 8, 2]);
        translate([-1, 6, 0])
            cylinder(h = 2, r = 2, center = false);
    }
}

// Assembly of the brackets based on positional relationships
module assembly() {
    translate([0, 0, 8])
        bracket_A();
    translate([0, 0, 4])
        bracket_B();
    bracket_C();
}

// Generate the model
assembly();

