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

// Adjusted detailed_coupling_segment to match original model's proportions and structure
module detailed_coupling_segment(inner_diameter, outer_diameter, length) {
    difference() {
        cylinder(h = length, d = outer_diameter, $fn=100);
        translate([0, 0, -1])
            cylinder(h = length + 2, d = inner_diameter);
        
        for (i = [1:3]) {
            translate([0, 0, i])
                cylinder(h = 0.9, d = outer_diameter - i*1.5, $fn=100); // Reduced thickness and adjusted gap
        }
    }
}

// Incorporating changes to improve alignment and shape accuracy
module flexible_coupling() {
    flange_diameter = 24;
    flange_thickness = 2;
    coupling_length = 10;
    coupling_inner_diameter = 6;
    coupling_outer_diameter = 12;
    spacer_thickness = 2.5; // Slight adjustment to spacer thickness
    
    for (i = [-1, 1]) {
        translate([i * coupling_length, 0, 0])
            detailed_coupling_segment(coupling_inner_diameter, coupling_outer_diameter, coupling_length + 4); // Reduced overall length to enhance proportion
        
        translate([i * (coupling_length + flange_thickness/2), 0, 0])
            flange(flange_diameter, flange_thickness); // Kept consistent, as indicated
    }
    
    for (i = [-1, 1]) {
        translate([0, i * (spacer_thickness + 0.8), 0]) { // Adjusted translation for better spacing alignment
            difference(){
                flange(flange_diameter, spacer_thickness);
                translate([0, 0, 1])
                    cylinder(h = spacer_thickness - 0.8, d = coupling_inner_diameter); // Tweaked to reduce thickness
            }
        }
    }
    
    for (angle = [0, 45]) {
        rotate([0, 0, angle])
            translate([0, spacing * spacer_thickness, 0]) {
                flange(flange_diameter + 2, spacer_thickness - 0.9); // Adjusted for sharper edges
            }
    }
}

flexible_coupling();
