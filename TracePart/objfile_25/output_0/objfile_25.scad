
// Central Shaft Component
module central_shaft() {
    difference() {
        cylinder(h = 60, r = 10, center = true); // Main cylindrical shaft
        // Slots along the shaft
        for (i = [-20, 0, 20]) {
            rotate([0, 90, 0])
            translate([i, 0, 0])
                cube([10, 20, 5], center = true);
        }
        // Holes for bolts at notches
        for (i = [-20, 20]) {
            translate([i, 0, 0])
                rotate([90, 0, 0])
                cylinder(h = 20, r = 2.5, center = true);
        }
    }
}

// Clamp Ring Component
module clamp_ring() {
    difference() {
        cylinder(h = 10, r = 12, center = true); // Outer ring
        cylinder(h = 10, r = 10, center = true); // Inner cut to create the ring
        rotate([90, 0, 0])
        translate([0, 0, -5])
            cylinder(h = 20, r = 2.5, center = true); // Hole for the bolt
    }
}

// Bolt Component
module bolt() {
    union() {
        cylinder(h = 6, r = 3, center = false); // Bolt head
        translate([0, 0, 6])
            cylinder(h = 20, r = 1.5, center = false); // Smooth cylindrical body
    }
}

// Building the Assembly
module flexible_coupling() {
    // Place central shaft
    central_shaft();

    // Place clamp rings
    translate([-20, 0, 0]) clamp_ring(); // First clamp ring
    translate([20, 0, 0]) clamp_ring();  // Second clamp ring

    // Place bolts
    translate([-20, 0, 0]) bolt(); // First bolt for first clamp ring
    translate([20, 0, 0]) bolt();  // First bolt for second clamp ring
}

// Render the model
flexible_coupling();

