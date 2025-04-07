module rectangular_loop(length, width, thickness, corner_radius) {
    difference() {
        // Outer rounded rectangular frame
        minkowski() {
            square([length, width], center=true);  // Create the base rectangle
            circle(corner_radius);                // Smooth out corners with a circle
        }
        
        // Inner cutout for thickness
        translate([0, 0, -thickness]) { 
            offset(-thickness) square([length, width], center=true);
        }
    }
}

module flexible_coupling() {
    layer_spacing = 5; // Uniform spacing between layers
    total_layers = 6;  // Number of layers
    
    for (i = [0:total_layers - 1]) {
        translate([0, 0, i * layer_spacing]) {
            rectangular_loop(length = 20, width = 10, thickness = 1, corner_radius = 2);
        }
    }
}

// Render the model
flexible_coupling();
