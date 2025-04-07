
module rectangular_loop(length, width, thickness, corner_radius) {
    difference() {
        // Outer loop
        hull() {
            translate([-length/2 + corner_radius, -width/2, 0]) sphere(corner_radius);
            translate([length/2 - corner_radius, -width/2, 0]) sphere(corner_radius);
            translate([-length/2 + corner_radius, width/2, 0]) sphere(corner_radius);
            translate([length/2 - corner_radius, width/2, 0]) sphere(corner_radius);
        }
        
        // Inner loop cutout (to create thickness)
        translate([0, 0, -1]) difference() {
            scale(0.8)
            linear_extrude(thickness * 2) { 
                 circle(radius=thickness);}
        } {
          
              
            }
    }
}

module flexible_coupling() {
    layer_spacing = 5;
    for (i = [0:5]) {
        translate([0, 0, i * layer_spacing]) {
            rectangular_loop(length = 20, width = 10, thickness = 1, corner_radius = 2);
        }
    }
}

// Render the model
flexible_coupling();

