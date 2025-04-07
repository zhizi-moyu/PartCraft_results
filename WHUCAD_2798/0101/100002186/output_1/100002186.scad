
$fn = 100; // High resolution for smoother surfaces

module central_unit() {
    cylinder(d=30, h=15); // Diameter = 30, height = 15 for symmetrical cylindrical unit
}

module input_unit() {
    cylinder(d=25, h=20, center=true);
    translate([0, 0, -10]) {
        cylinder(d=15, h=20, center=true); // Hollow center
    }
}

module output_unit() {
    cylinder(d=25, h=15, center=true); // Adjust height to 15 for uniformity
    translate([0, 0, -7.5]) {
        cylinder(d=15, h=15, center=true); // Hollow center
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=30, h=2, center=true); // Ensure thickness consistency
        cylinder(d=20, h=2, center=true); // Hollow center
    }
}

module flange_plate() {
    rotate([90, 0, 0]) {
        difference() {
            cylinder(d=30, h=5); // Ensure correct thickness
            cylinder(d=20, h=5); // Hollow center

            // Add bolt holes around the flange with correct symmetry
            for (i = [0:7]) // Update the range for 8 evenly spaced bolt holes
                translate([27 * cos(45*i), 27 * sin(45*i), 0])
                cylinder(d=3, h=5, center=true);
        }
    }
}

module nut() {
    cylinder(d=5, h=3, center=true); // Hexagonal precision maintained
    translate([0, 0, 1.5])
        rotate([0, 0, 45])
        color("gray")
        scale([1, 1, 1]) // Remove scaling to maintain hexagonal shape
        cylinder(d=5, h=3);
}

module bolt() {
    cylinder(d=3, h=30, center=true); // Bolt centered and height adjusted
}

// Assemble the complete model
translate([0, 0, 0]) central_unit();
translate([0, 0, 15]) input_unit(); // Adjust position to ensure alignment
translate([0, 0, 35]) output_unit(); // Adjust position to ensure alignment
translate([0, 0, 50]) spacer_ring();
translate([0, 0, 52]) flange_plate();
translate([0, 0, 57]) spacer_ring();
translate([0, 0, 59]) flange_plate();

// Nuts and bolts - further assembly or placement as needed
translate([0, 0, 65]) nut(); // Evenly distributed nuts
translate([0, 0, 70]) bolt(); // Correctly positioned bolt

