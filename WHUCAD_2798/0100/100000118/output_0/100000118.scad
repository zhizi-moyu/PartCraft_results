
// Parameters for the square box
box_size = [40, 40, 20]; // Dimensions: Width, Depth, Height
wall_thickness = 2;      // Thickness of the walls

// Create the solid outer box
difference() {
    cube(box_size, center = true); // The outer box
    
    // Create the hollow inside
    translate([0, 0, wall_thickness])
        cube([box_size[0] - 2*wall_thickness, box_size[1] - 2*wall_thickness, box_size[2]], center = true);
}

