
module flexible_coupling() {
    difference() {
        // Base cylinder
        cylinder(h = 40, d = 30, center = true);

        // Through hole
        cylinder(h = 42, d = 10, center = true, $fn = 100);
    }

    // Top elongated cylindrical section
    translate([0, 0, 30])
    cylinder(h = 15, d = 25, center = true, $fn = 100); // Adjusted height and diameter for component_1

    // Enhanced middle grooves and ridges
    translate([0, 0, 0]) {
        for (i = [-10, -5, 0, 5]) {
            rotate([0, 0, i * 10])
            difference() {
                cylinder(h = 10, d = 30, center = true);
                translate([0, 5, 0])
                cylinder(h = 12, d = 25, center = true, $fn = 60); // Intricate detailing for component_2
            }
        }
    }

    // Bottom disc-like section repositioned
    translate([0, 0, -35]) 
    cylinder(h = 10, d = 25, center = true, $fn = 100); // Corrected placement for component_3

    // Deeper chamfered edges and transitions
    translate([0, 0, -20]) 
    difference() {
        cylinder(h = 15, d = 40, center = true);
        translate([5, 0, 0])
        rotate([45, 0, 0])
        cylinder(h = 15, d = 30, center = true, $fn = 30); // Depth adjusted for component_4
    }
}

flexible_coupling();

