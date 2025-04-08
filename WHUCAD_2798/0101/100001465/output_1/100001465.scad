module rectangular_housing() {
    difference() {
        // Outer shape with trapezoidal cross-section and flanged edges
        hull() {
            translate([0, 0, 0]) 
                scale([1, 1, 1]) 
                cube([50, 30, 20], center = true);
            translate([0, 0, 20]) 
                scale([1.2, 1.2, 1]) 
                cube([60, 40, 10], center = true);
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
