
// End Cap Component
module end_cap() {
    difference() {
        rotate([0, 0, 0]) translate([0, 0, 15])
            cylinder(h = 10, r = 20, center = true);
        for (i = [0:60:360]) {
            rotate([0, 0, i])
                translate([25, 0, 0])
                    cylinder(h = 20, r = 5, center = true);
        }
        for (i = [0:60:360]) {
            rotate([0, 0, i])
                translate([22, 0, 0])
                    cylinder(h = 12, r = 3, center = true);
        }
    }
}

// Spacer Ring
module spacer_ring() {
    difference() {
        cylinder(h = 3, r = 20, center = true);
        cylinder(h = 5, r = 15, center = true);
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
                    cylinder(h = 15, r = 3, center = true);
        }
    }
}

// Bolt
module bolt() {
    difference() {
        cylinder(h = 5, r = 2, center = false);
        translate([0, 0, -2]) cylinder(h = 2, r = 2.75, center = false);
    }
}

// Nut
module nut() {
    cylinder(h = 2.75, r = 2, center = true);
}

// Assembly
module assembly() {
    // Layer 1 - Topmost end cap
    end_cap();
    translate([0, 0, 10])
        spacer_ring();
    translate([0, 0, 10])
        central_block();
    translate([0, 0, 30])
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
    translate([0, 0, 35])
        end_cap();
}

assembly();

