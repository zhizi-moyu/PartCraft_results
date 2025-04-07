
// Variables for dimensions
module flange(diameter, thickness) {
    cylinder(h = thickness, d = diameter);
}

module coupling_segment(inner_diameter, outer_diameter, length) {
    difference() {
        cylinder(h = length, d = outer_diameter);
        translate([0, 0, -1]) 
            cylinder(h = length + 2, d = inner_diameter);
    }
}

module flexible_coupling() {
    // Define dimensions
    // Adjust these values to match the proportions of the images
    flange_diameter = 24;
    flange_thickness = 2;
    coupling_length = 10;
    coupling_inner_diameter = 6;
    coupling_outer_diameter = 12;
    spacer_thickness = 3;
    
    // Layout the components
    for (i = [-1, 1]) {
        translate([i * coupling_length, 0, 0])
            coupling_segment(coupling_inner_diameter, coupling_outer_diameter, coupling_length);
            
        translate([i * (coupling_length + flange_thickness/2), 0, 0])
            flange(flange_diameter, flange_thickness);
    }
    
    // Add spacers between the flanges
    for (i = [-1, 1]) {
        translate([0, i * spacer_thickness, 0]) {
            flange(flange_diameter, spacer_thickness);
        }
    }
}

flexible_coupling();

