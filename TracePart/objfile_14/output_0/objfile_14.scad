
module end_plate() {
    difference() {
        cylinder(h = 5, d = 30); // Main disc
        translate([0, 0, -1]) cylinder(h = 7, d = 10); // Central hole
        for (i = [0, 180]) {
            rotate([0, 0, i]) translate([12, 0, 0]) cylinder(h = 7, d = 3); // Screw holes
        }
    }
}

module central_body() {
    difference() {
        cylinder(h = 20, d = 30); // Main cylindrical body
        translate([0, 0, -1]) cylinder(h = 22, d = 10); // Central bore
        for (z = [5, 15]) {
            translate([0, 0, z]) cube([30, 5, 5], center = true); // Grooves for cross bars
        }
    }
}

module cross_bar() {
    difference() {
        translate([-10, 0, 0]) cube([20, 5, 10], center = true); // Main bar
        cylinder(h = 10, d = 3); // Central hole for pin
    }
}

module pin() {
    cylinder(h = 20, d = 3); // Pin rod
}

module flexible_coupling() {
    translate([0, 0, 25]) end_plate();
    translate([0, 0, 5]) central_body();
    translate([-15, 0, 15]) rotate([90, 0, 0]) cross_bar();
    translate([-15, 0, 5]) rotate([90, 0, 0]) cross_bar();
    translate([0, 0, 15]) rotate([90, 0, 0]) pin();
    translate([0, 0, 5]) rotate([90, 0, 0]) pin();
    translate([0, 0, -5]) end_plate();
}

flexible_coupling();

