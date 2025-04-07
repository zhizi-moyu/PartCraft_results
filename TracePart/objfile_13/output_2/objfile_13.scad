module flexible_coupling() {
    union() {
        // Base cylinder with spiral pattern
        rotate_extrude($fn = 100)
        translate([15, 0, 0])
        square([10, 1]);

        // Through hole
        translate([0, 0, -40])
        cylinder(h = 80, d = 10, center = true, $fn = 100);

        // Top elongated cylindrical section integrated with main body
        translate([0, 0, 40])
        cylinder(h = 15, d = 25, center = true, $fn = 100);

        // Enhanced middle grooves and ridges combined structure
        for (i = [-10, -5, 0, 5]) {
            rotate([0, 0, i * 72/height_segment])
            translate([0, 0, i])
            difference() {
                cylinder(h = 10, d = 30, center = true);
                translate([0, 5, 0])
                cylinder(h = 12, d = 25, center = true, $fn = 60);
            }
        }

        // Bottom disc-like section with horizontal protrusions
        translate([0, 0, -35]) 
        cylinder(h = 10, d = 30, center = true, $fn = 100);

        // Deeper chamfered edges and transitions removed gap
        translate([0, 0, -20]) 
        difference() {
            cylinder(h = 15, d = 40, center = true);
            translate([5, 0, 0])
            rotate([45, 0, 0])
            cylinder(h = 15, d = 35, center = true, $fn = 30);
        }
    }
}

flexible_coupling();
