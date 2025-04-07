
// Component: Central Hub
module central_hub() {
    difference() {
        // Adjusted Main cylinder
        cylinder(h = 25, d = 30, center = true); // Increased height for the original design

        // Narrowed Central bore
        translate([0, 0, -12.5])
            cylinder(h = 30, d = 8, center = true); // Reduced diameter for compatibility

        // Deepened and narrowed Slot
        translate([0, -4, -25])
            cube([28, 8, 50], center = true);
    }
}

// Component: Outer Sleeve
module outer_sleeve() {
    difference() {
        // Ribbed texture adjustment
        for (z = [-20, -10, 0, 10, 20]) {
            translate([0, 0, z]) {
                cylinder(h = 10, d1 = 50, d2 = 48, center = true);
            }
        }

        // Thicker Flange
        translate([0, 0, -25])
            cylinder(h = 15, d = 60, center = true);
    }
}

// Component: Locking Cap
module locking_cap() {
    difference() {
        // Taller rim for the cap
        cylinder(h = 8, d = 54, center = true);  // Increased rim height

        // Smaller Central hole
        translate([0, 0, -4])
            cylinder(h = 12, d = 8, center = true);  // Reduced hole size
    }
}

// Component: Inner Ring
module inner_ring() {
    difference() {
        // Increased thickness of the ring
        cylinder(h = 6, d = 42, center = true);  // Made slightly thicker

        // Adjusted Central hole size
        translate([0, 0, -3])
            cylinder(h = 12, d = 22, center = true);  // Enlarged for alignment
    }
}

// Full Assembly
module full_model() {
    // Adjust Layer 1: Top Locking Cap position
    translate([0, 0, 50])
        locking_cap();

    // Adjust Layer 2: Outer Sleeve and Inner Ring
    translate([0, 0, 18])
        outer_sleeve();
    translate([0, 0, 18])
        inner_ring();

    // Adjust Layer 3: Central Hub height
    translate([0, 0, -2.5])
        central_hub();

    // Layer 4: Bottom Outer Sleeve
    translate([0, 0, -18])
        outer_sleeve();

    // Adjust Layer 5: Bottom Locking Cap position
    translate([0, 0, -38])
        locking_cap();
}

// Render full model
full_model();

