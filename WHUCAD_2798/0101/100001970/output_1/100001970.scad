
// Parameters for cylindrical body
cylindrical_body_diameter = 50; // Diameter of the cylindrical body
cylindrical_body_height = 30;   // Height of the cylindrical body
recess_diameter = 30;           // Diameter of the recessed hollow at the bottom
recess_depth = 5;               // Reduced depth of the recessed hollow

// Parameters for base cylinder
base_cylinder_diameter = 25;    // Increased diameter of the base cylinder
base_cylinder_height = 7;       // Reduced height of the base cylinder

// Parameters for smoothing
smooth_edges_radius = 2;        // Radius for edge smoothing

// Main cylindrical body
module cylindrical_body() {
    difference() {
        // Outer cylindrical body with rounded edges
        cylinder(d = cylindrical_body_diameter, h = cylindrical_body_height, center = true, $fn = 100);
        
        // Recessed hollow at the bottom
        translate([0, 0, -cylindrical_body_height / 2])
            cylinder(d = recess_diameter, h = recess_depth, center = false, $fn = 100);
    }
}

// Base cylinder
module base_cylinder() {
    // Base cylinder with rounded edges
    cylinder(d = base_cylinder_diameter, h = base_cylinder_height, center = true, $fn = 100);
}

// Combine components
translate([0, 0, base_cylinder_height / 2 - smooth_edges_radius])
    cylindrical_body();

translate([0, 0, -cylindrical_body_height / 2 - base_cylinder_height / 2 + smooth_edges_radius])
    base_cylinder();

