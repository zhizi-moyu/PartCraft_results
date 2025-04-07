module end_plate() {
    difference() {
        cylinder(h = 5, d = 32); // Base disc
        translate([0, 0, -1]) cylinder(h = 7, d = 10); // Central hole
        for (i = [0, 120, 240]) { // Symmetrical hole arrangement
            rotate([0, 0, i]) translate([13, 0, 0]) cylinder(h = 7, d = 3); // Screw holes symmetrically spaced
        }
    }
}

module central_body() {
    difference() {
        cylinder(h = 22, d = 28); // Uniform central body without extra features
        translate([0, 0, -1]) cylinder(h = 24, d = 10); // Central bore
        for (z = [7, 15]) { // Groove positions adjusted to match original depth and width
            translate([0, 0, z]) cube([28, 4, 4], center = true); // Standard grooves for cross bars
        }
    }
}

module cross_bar() {
    difference() {
        translate([-11, 0, 0]) cube([22, 4, 10], center = true); // Length increased and dimensions adjusted
        cylinder(h = 10, d = 3, center = true); // Center hole aligned correctly
    }
}

module pin() {
    cylinder(h = 20, d = 2.5); // Slightly extended length for proper alignment
}

module flexible_coupling() {
    translate([0, 0, 25]) end_plate();
    translate([0, 0, 5]) central_body();
    
    // Adjust position of cross bars symmetrically
    translate([-14, 0, 12]) rotate([90, 0, 0]) cross_bar();
    translate([-14, 0, 6]) rotate([90, 0, 0]) cross_bar();
    
    // Correct alignment of pins
    translate([0, 0, 14]) rotate([90, 0, 0]) pin();
    translate([0, 0, 4]) rotate([90, 0, 0]) pin();
    
    translate([0, 0, -5]) end_plate();
}

flexible_coupling();
