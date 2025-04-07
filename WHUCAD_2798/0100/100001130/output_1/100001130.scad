// Define bracket dimensions
module bracket_A() {
    // Longer arm with corrected proportions
    cube([14, 2, 2]); // Length adjusted to match original model

    // Shorter arm with improved rounded edge and alignment
    translate([0, 2.5, 0]) {
        cube([2, 6, 2], center = false);
        translate([0.5, 6.5, 0]) // Adjusted alignment
            rotate([0, 0, 45])
            cylinder(h = 2, r = 1.25, center = false); // Improved curve smoothness
    }
}

module bracket_B() {
    // Rectangular features with pronounced corner curve and corrected proportions
    hull() {
        cube([10, 2, 2]);
        translate([2, 6, 0])
            cube([2, 8, 2], center = false); // Adjusted length
        translate([1, 10, 0]) // Corrected placement
            cylinder(h = 2, r = 1.75, center = false); // More pronounced curve
    }
}

module bracket_C() {
    // Adjusted corner rounding, lengths, and angles to match original
    translate([2, 0, 0]) {
        cube([8, 8, 2]);
        translate([0, 7, 0]) // Corrected alignment
            cylinder(h = 2, r = 2.25, center = false); // Improved smooth corner
    }
}

// Assembly of the brackets based on positional relationships
module assembly() {
    translate([0, 0, 12]) // Adjusted spacing to better align with the original model
        bracket_A();
    translate([0, 0, 6]) // Corrected alignment and spacing
        bracket_B();
    translate([0, 0, 0]) // Position adjustment for bracket_C
        bracket_C();
}

// Generate the model
assembly();
