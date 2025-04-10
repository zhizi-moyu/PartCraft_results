module rectangular_housing() {
    difference() {
        // Outer shape
        hull() {
            translate([0, 0, 0]) cube([50, 30, 20], center = true);
            translate([0, 0, 20]) cube([60, 40, 10], center = true);
        }
        // Inner hollow part
        translate([0, 0, 2]) {
            scale([0.9, 0.9, 1]) {
                cube([50, 30, 18], center = true);
            }
        }
    }
}

// Call the module to render the rectangular housing
rectangular_housing();
