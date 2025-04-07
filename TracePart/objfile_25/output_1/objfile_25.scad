
// Central Shaft Component
module central_shaft() {
    difference() {
        // Create a full cylindrical shaft without slots
        cylinder(h = 60, r = 10, center = true); 
        // Add correctly positioned notches for alignment
        for (i = [-20, 0, 20]) {
            translate([i, 0, -5])
                rotate([90, 0, 0])
                cylinder(h = 10, r = 2.5, center = true);
        }
    }
}

// Clamp Ring Component
module clamp_ring() {
    difference() {
        cylinder(h = 15, r = 13, center = true); // Thickened outer ring
        cylinder(h = 15, r = 11, center = true); // Inner cut to create the ring
        // Correctly positioned and sized holes for bolts
        rotate([90, 0, 0])
        translate([0, 0, -7.5])
            cylinder(h = 15, r = 2.5, center = true);
    }
}

// Bolt Component
module bolt() {
    union() {
        cylinder(h = 6, r = 3, center = false); // Bolt head
        translate([0, 0, 6])
            difference() {
                cylinder(h = 25, r = 1.5, center = false); // Length adjusted cylindrical body
                // Threaded section added
                translate([0, 0, 20])
                cylinder(h = 5, r = 1, center = false);
            }
    }
}

// Building the Assembly
module flexible_coupling() {
    // Place central shaft
    central_shaft();

    // Corrected placement of clamp rings for symmetry
    translate([-30, 0, 0]) clamp_ring(); // First clamp ring
    translate([30, 0, 0]) clamp_ring();  // Second clamp ring

    // Corrected alignment of bolts with clamp rings
    translate([-30, 0, 0]) bolt(); // First bolt for the first clamp ring
    translate([30, 0, 0]) bolt();  // First bolt for the second clamp ring
}

// Render the model
flexible_coupling();

