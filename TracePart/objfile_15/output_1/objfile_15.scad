
// End Cap Component
module end_cap() {
    difference() {
        rotate([0, 0, 0]) translate([0, 0, 15])
            cylinder(h = 8, r = 20, center = true); // Reduced thickness
        for (i = [0:60:360]) {
            rotate([0, 0, i])
                translate([25, 0, 0])
                    cylinder(h = 20, r = 5, center = true);
        }
        for (i = [0:60:360]) {
            rotate([0, 0, i])
                translate([22, 0, 0])
                    cylinder(h = 12, r = 3, center = true); // Refined grooves
        }
    }
}

// Spacer Ring
module spacer_ring() {
    difference() {
        cylinder(h = 2.5, r = 20, center = true); // Adjusted thickness
        cylinder(h = 5.5, r = 15, center = true);
    }
}

// Central Block Component
module central_block() {
    difference() {
        cylinder(h = 20, r = 20, center = true);
        cylinder(h = 21, r = 10, center = true);
        for (i = [0:60:360]) {
            rotate([0, 0, i])
                translate([25, 0, 0])
                    cylinder(h = 25, r = 5, center = true);
        }
        for (i = [0:60:360]) {
            rotate([0, 0, i])
                translate([22, 0, 0])
                    cylinder(h = 15, r = 3, center = true); // Enhanced symmetry
        }
    }
}

// Bolt
module bolt() {
    difference() {
        cylinder(h = 5, r = 2, round = true, center = false); // Rounded heads
        translate([0, 0, -2]) cylinder(h = 2, r = 2.75, center = false);
    }
}

// Nut
module nut() {
    difference() {
        cylinder(h = 2.5, r = 1.75, center = true); // Reduced size
        rotate([0, 0, 0])
            hull() { // Refined hexagonal shape
                translate([1.5, 0, 0])
                    circle(r = 1.5);
                for (j = [60, 120, 180, 240, 300, 360]) {
                    rotate([0, 0, j])
                        translate([1.5, 0, 0])
                            circle(r = 1.5);
                }
            }
    }
}

// Assembly
module assembly() {
    // Layer 1 - Topmost end cap
    end_cap();
    translate([0, 0, 8])
        spacer_ring();
    translate([0, 0, 28])
        central_block();
    translate([0, 0, 48])
        spacer_ring();
    
    // Layer 5 - Bolts and Nuts
    for (i = [0:60:360]) {
        rotate([0, 0, i])
            translate([25, 0, 5])
                bolt();
        rotate([0, 0, i])
            translate([25, 0, 25])
                nut();
    }
    
    // Layer 6 - Bottommost end cap
    translate([0, 0, 53])
        end_cap();
}

assembly();

