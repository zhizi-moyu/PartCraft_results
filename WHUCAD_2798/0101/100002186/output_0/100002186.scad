
// Define the diameter and length of different parts for a basic coupling model
$fn = 100; // High resolution for smoother surfaces

module central_unit() {
    cylinder(d=30, h=15); // Assuming diameter = 30, height = 15
}

module input_unit() {
    cylinder(d=25, h=20, center=true);
    translate([0, 0, -10]) {
        cylinder(d=15, h=20, center=true); // Hollow center
    }
}

module output_unit() {
    cylinder(d=25, h=15, center=true);
    translate([0, 0, -7.5]) {
        cylinder(d=15, h=15, center=true); // Hollow center
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=30, h=2, center=true);
        cylinder(d=20, h=2, center=true); // Hollow center
    }
}

module flange_plate() {
    rotate([90, 0, 0]) {
        difference() {
            cylinder(d=30, h=5);
            cylinder(d=20, h=5); // Hollow center for seating

            // Add bolt holes around the flange
            for (i = [0:3])
                translate([-(27 * cos(45*i)), -(27 * sin(45*i)), 0])
                cylinder(d=3, h=5, center=true);
        }
    }
}

module nut() {
    cylinder(d=5, h=3, center=true); // Hexagonal nut, simplified as cylinder
    translate([0, 0, 1.5])
        rotate([0, 0, 45])
        color("gray")
        scale([1, 0.85, 1]) // Make it hexagonal-like
            cylinder(d=5, h=3);
}

module bolt() {
    cylinder(d=3, h=30); // Bolt height assumed to fully penetrate the function
}

// Assemble the complete model
translate([0, 0, 0]) central_unit();
translate([0, 0, 8]) input_unit();
translate([0, 0, 24]) output_unit();
translate([0, 0, 38]) spacer_ring();
translate([0, 0, 40]) flange_plate();
translate([0, 0, 50]) spacer_ring();
translate([0, 0, 52]) flange_plate();

// Nuts and bolts - further assembly or placement as needed
translate([0, 0, 60]) for (i = [1:4]) nut();
translate([0, 0, 70]) bolt();

