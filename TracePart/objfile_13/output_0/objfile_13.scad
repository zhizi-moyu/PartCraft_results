
module flexible_coupling() {
    difference() {
        // Base cylinder
        cylinder(h = 40, d = 30, center = true);
        
        // Through hole
        cylinder(h = 42, d = 10, center = true, $fn = 100);
    }
    
    // Connector part
    translate([0, 0, 15])
    cylinder(h = 10, d = 25, center = true, $fn = 100);
    
    translate([0, 0, -25])
    cylinder(h = 10, d = 25, center = true, $fn = 100);

    // Apply teeth-like feature based on images in-between
    translate([0, 0, -5])
    rotate([0, 0, 0])
    cylinder(h = 10, d = 25, center = true, $fn = 30);

    // End cap
    translate([0, 0, -35])
    cylinder(h = 10, d = 20, center = true, $fn = 100);

    // End cap
    translate([0, 0, 35])
    cylinder(h = 10, d = 20, center = true, $fn = 100);
}

flexible_coupling();

