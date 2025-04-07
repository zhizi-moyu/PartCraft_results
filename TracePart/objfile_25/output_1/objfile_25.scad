
// Constants defining dimensions
central_shaft_length = 100; // Length adjusted
central_shaft_diameter = 15; // Diameter thickened for better centering

clamping_section_length = 25; // Shortened length for improved alignment
clamping_section_diameter = 20; // Diameter remains unchanged
screw_hole_diameter = 4; // Increased diameter for countersunk precision

groove_depth = 2; // Groove depth for enhanced splits
groove_width = 3; // Groove width as per the original model

// Functions to create individual components

module central_shaft() {
    // Central shaft properly centered and thickened
    cylinder(h = central_shaft_length, d = central_shaft_diameter, center = true);
}

module clamping_section() {
    difference() {
        // Clamping cylinder
        cylinder(h = clamping_section_length, d = clamping_section_diameter, center = true);
        
        // Countersunk screw holes aligned correctly
        for (i = [0 : 3]) {
            rotate([0, 0, i * 90]) {
                translate([clamping_section_diameter / 2, 0, 0])
                {
                  cylinder(h = clamping_section_length, d1 = screw_hole_diameter, d2 = screw_hole_diameter / 1.5, center = true); // Countersunk design
                }
            }
        }

        // Groove splits repositioned and enhanced
        for (j = [-1, 1]) {
            translate([0, j * clamping_section_diameter / 4, 0]) {
                cube([groove_width, groove_depth, clamping_section_length], center = true);
            }
        }
    }
}

// Assembly of the components

// Layer 1: Central Shaft
translate([0, 0, 0])
central_shaft();

// Layer 2: First Clamping Section
translate([0, 0, central_shaft_length / 2 - clamping_section_length / 2])
clamping_section();

// Layer 3: Second Clamping Section
translate([0, 0, -central_shaft_length / 2 + clamping_section_length / 2])
clamping_section();

