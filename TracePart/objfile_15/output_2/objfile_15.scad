
// End Cap Component
module end_cap() {
    difference() {
        rotate([0, 0, 0]) translate([0, 0, 15])
            cylinder(h = 10, r = 22, center = true); // Increased thickness and radius
        for (i = [0:60:360]) {
            rotate([0, 0, i])
                translate([25, 0, 0])
                    cylinder(h = 25, r = 5, center = true); // Adjusted curvature and depth
        }
        for (i = [0:60:360]) {
            rotate([0, 0, i])
                translate([22, 0, 0])
                    cylinder(h = 15, r = 3.5, center = true); // Increased groove depth and spacing
        }
    }
}

// Spacer Ring
module spacer_ring() {
    difference() {
        cylinder(h = 1.5, r = 20, center = true); // Reduced thickness
        translate([0, 0, -1]) cylinder(h = 5, r = 15, center = true); // Adjusted alignment for snug fit
    }
}

// Central Block Component
module central_block() {
    difference() {
        cylinder(h = 25, r = 20, center = true); // Height increased for proper elongation
        cylinder(h = 26, r = 10, center = true);
        for (i = [0:60:360]) {
            rotate([0, 0, i])
                translate([24, 0, 0])
                    cylinder(h = 20, r = 6, center = true); // Refined grooves
        }
        for (i = [0:60:360]) {
            rotate([0, 0, i])
                translate([22, 0, 0])
                    cylinder(h = 16, r = 3, center = true); // Enhanced symmetry
        }
    }
}

// Bolt Component
module bolt() {
    difference() {
        cylinder(h = 8, r = 2, center = false); // Uniform threading length
        translate([0, 0, -1]) cylinder(h = 2, r = 2.5, center = false); // Rounded base improved
    }
}

// Nut Component
module nut() {
    difference() {
        cylinder(h = 2, r = 1.75, center = true); // Refined size for flush fit
        rotate([0, 0, 0])
            hull() { // Enhanced threading compatibility
                translate([1.25, 0, 0])
                    circle(r = 1.5);
                for (j = [60, 120, 180, 240, 300]) {
                    rotate([0, 0, j])
                        translate([1.25, 0, 0])
                            circle(r = 1.5);
                }
            }
    }
}

// Assembly
module assembly() {
    // Layer 1 - Topmost end cap
    end_cap();
    translate([0, 0, 10])
        spacer_ring();
    translate([0, 0, 30])
        central_block();
    translate([0, 0, 55])
        spacer_ring();

    // Layer 5 - Bolts and Nuts
    for (i = [0:60:360]) {
        rotate([0, 0, i])
            translate([25, 0, 7])
                bolt(); // Adjusted bolt position for precise alignment
        rotate([0, 0, i])
            translate([25, 0, 27])
                nut(); // Adjusted nut position for snug fit
    }
    
    // Layer 6 - Bottommost end cap
    translate([0, 0, 60])
        end_cap();
}

assembly();

