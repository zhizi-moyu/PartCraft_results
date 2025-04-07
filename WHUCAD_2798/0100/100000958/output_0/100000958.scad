
// Component: Central Hub
module central_hub() {
    difference() {
        // Main cylinder
        cylinder(h = 20, d = 30, center = true);
        
        // Central bore
        translate([0, 0, -10])
            cylinder(h = 30, d = 10, center = true);

        // Slot
        translate([0, -5, -20])
            cube([30, 10, 40], center = true);
    }
}

// Component: Outer Sleeve
module outer_sleeve() {
    difference() {
        // Hollow cylinder with ribbed texture
        cylinder(h = 40, d = 50, center = true);
        translate([0, 0, -20])
            cylinder(h = 60, d = 40, center = true);
        
        // Flange
        translate([0, 0, -20])
            cylinder(h = 10, d = 60, center = true);
    }
}

// Component: Locking Cap
module locking_cap() {
    difference() {
        // Outer disc
        cylinder(h = 5, d = 50, center = true);

        // Central hole
        translate([0, 0, -2.5])
            cylinder(h = 10, d = 10, center = true);
    }
}

// Component: Inner Ring
module inner_ring() {
    difference() {
        // Ring body
        cylinder(h = 5, d = 40, center = true);

        // Central hole
        translate([0, 0, -2.5])
            cylinder(h = 10, d = 20, center = true);
    }
}

// Full Assembly
module full_model() {
    // Layer 1: Top Locking Cap
    translate([0, 0, 45])
        locking_cap();

    // Layer 2: Outer Sleeve and Inner Ring
    translate([0, 0, 15])
        outer_sleeve();
    translate([0, 0, 15])
        inner_ring();

    // Layer 3: Central Hub
    central_hub();

    // Layer 4: Bottom Outer Sleeve
    translate([0, 0, -15])
        outer_sleeve();

    // Layer 5: Bottom Locking Cap
    translate([0, 0, -35])
        locking_cap();
}

// Render full model
full_model();

