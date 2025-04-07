
// Constants defining dimensions
central_shaft_length = 100; // Example length
central_shaft_diameter = 10; // Example diameter

clamping_section_length = 30; // Length of each clamp section
clamping_section_diameter = 20; // Diameter of the clamps
screw_hole_diameter = 3; // Diameter of screw holes

// Functions to create individual components

module central_shaft() {
    cylinder(h = central_shaft_length, d = central_shaft_diameter, center = true);
}

module clamping_section() {
    difference() {
        cylinder(h = clamping_section_length, d = clamping_section_diameter, center = true);
        for (i = [0 : 3]) {
            rotate([0, 0, i * 90]) {
                translate([clamping_section_diameter/2 - screw_hole_diameter, 0, 0])
                cylinder(h = clamping_section_length, d = screw_hole_diameter, center = true);
            }
        }
        translate([clamping_section_diameter/4, 0, 0]) {
            cube([clamping_section_diameter/2, clamping_section_diameter, clamping_section_length], center = true);
        }
    }
}

// Assembly of the components
    
translate([0, 0, 0])
central_shaft(); // Layer 1: Central Shaft

translate([0, 0, central_shaft_length/2 - clamping_section_length/2])
clamping_section(); // Layer 2: First Clamping Section

translate([0, 0, -central_shaft_length/2 + clamping_section_length/2])
clamping_section(); // Layer 3: Second Clamping Section

