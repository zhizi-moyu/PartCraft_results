module rectangular_housing() {
    difference() {
        // Outer shape with rectangular cross-section and flanged edges
        union() {
            // Base rectangular structure
            cube([50, 30, 20], center = true);
            
            // Flanged edges at the top
            translate([-30, -15, 10]) {
                cube([60, 40, 2], center = false);
            }
        }
        
        // Inner hollow part
        translate([0, 0, 2]) {
            cube([48, 28, 18], center = true);
        }
    }
}

// Call the module to render the rectangular housing
rectangular_housing();
