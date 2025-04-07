
module end_plate() {
    difference() {
        cylinder(h = 5, d = 32); // Adjusted size for the main disc
        translate([0, 0, -1]) cylinder(h = 7, d = 10); // Central hole
        for (i = [0, 180]) {
            rotate([0, 0, i]) translate([13, 0, 0]) cylinder(h = 7, d = 3); // Adjusted screw holes position
        }
    }
}

module central_body() {
    difference() {
        cylinder(h = 18, d = 28); // Slimmed down the central body
        translate([0, 0, -1]) cylinder(h = 22, d = 10); // Central bore
        for (z = [4.5, 13.5]) {
            translate([0, 0, z]) cube([28, 3, 3], center = true); // Adjusted grooves for cross bars
        }
    }
}

module cross_bar() {
    difference() {
        translate([-9, 0, 0]) cube([18, 3, 8], center = true); // Adjusted dimensions for snug fit
        cylinder(h = 8, d = 3); // Central hole for pin
    }
}

module pin() {
    cylinder(h = 18, d = 2.5); // Adjusted pin dimensions to fit without protrusion
}

module flexible_coupling() {
    translate([0, 0, 25]) end_plate();
    translate([0, 0, 5]) central_body();
    translate([-14, 0, 12]) rotate([90, 0, 0]) cross_bar();
    translate([-14, 0, 6]) rotate([90, 0, 0]) cross_bar();
    translate([0, 0, 14]) rotate([90, 0, 0]) pin();
    translate([0, 0, 4]) rotate([90, 0, 0]) pin();
    translate([0, 0, -5]) end_plate();
}

flexible_coupling();

