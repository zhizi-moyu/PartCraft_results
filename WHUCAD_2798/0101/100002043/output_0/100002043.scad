
// Dimensions for the ring spacer
module ring_spacer(inner_diameter, outer_diameter, thickness) {
    difference() {
        // Outer ring
        cylinder(d = outer_diameter, h = thickness, center = true);
        // Inner hollow section
        translate([0, 0, -thickness / 2])
            cylinder(d = inner_diameter, h = thickness + 1, center = true);
    }
}

// Test render of the ring spacer
translate([0, 0, 0]) ring_spacer(inner_diameter = 30, outer_diameter = 50, thickness = 5);

