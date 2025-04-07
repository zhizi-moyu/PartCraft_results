
// Parameters
module main_body() {
    difference() {
        cylinder(h=50, r=20, $fn=100); // Main cylinder
        translate([0, 0, 10]) cylinder(h=40, r=15, $fn=100); // Hollow inner cylinder
        for (z = [5, 15, 25, 35, 45]) {
            translate([0, 0, z]) cylinder(h=2, r=20, $fn=100); // Circular grooves
        }
    }
}

module end_cap() {
    difference() {
        cylinder(h=10, r=20, $fn=100); // Disc shape
        translate([0, 0, 5]) cylinder(h=10, r=10, $fn=100); // Remove center
        for (angle = [0, 90, 180, 270]) {
            rotate([0, 0, angle]) translate([15, 0, 3])
            rotate([90, 0, 0]) cylinder(h=6, r=2.5, $fn=50); // Bolt holes
        }
    }
}

module bolt() {
    union() {
        cylinder(h=50, r=2.5, $fn=50); // Threaded rod
        translate([0, 0, 50]) cylinder(h=5, r=4, $fn=50); // Bolt head
    }
}

module nut() {
    difference() {
        cylinder(h=5, r=4, $fn=50); // Hexagonal base
        translate([0, 0, -1]) cylinder(h=6, r=2.5, $fn=50); // Remove center
    }
}

module retaining_ring() {
    difference() {
        cylinder(h=2, r=20, $fn=100); // Ring
        translate([0, 0, -1]) cylinder(h=4, r=19, $fn=100); // Remove inner
    }
}

module compression_spring() {
    translate([0, 0, 10])
    linear_extrude(height = 30, twist = 720, $fn=100) {
        translate([-1, -1]) circle(r=1, $fn=100); // Spiral extrusion
    }
}

// Assembly of components
module flexible_coupling() {
    main_body();
    translate([0, 0, 50]) end_cap();

    // Bolt and nut placement
    for (angle = [0, 90, 180, 270]) {
        rotate([0, 0, angle]) {
            translate([15, 0, -10]) bolt();
            translate([15, 0, -15]) nut();
        }
    }

    // Spring placement
    compression_spring();

    // Retaining ring
    translate([0, 0, 3]) retaining_ring();
}

// Render the complete model
flexible_coupling();

