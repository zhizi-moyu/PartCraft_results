
// Parameters for the components
$fn = 100; // Smoothing parameter for rounded shapes

// 1. Solid Cylinder
module solid_cylinder() {
    union() {
        // Adjusted taper to be more subtle and increased base width
        cylinder(h = 20, r1 = 10, r2 = 9.8, center = true); 
    }
}

// 2. Hollow Cylinder
module hollow_cylinder() {
    difference() {
        // Adjusted base cylinder dimensions and hollow section
        cylinder(h = 10, r = 9, center = true);
        
        // Enlarged recessed hollow area to match the original model
        translate([0, 0, -4]) 
            cylinder(h = 14, r = 7, center = true); 
    }
}

// Assemble the model layers
module model() {
    // Layer 1: Adjusted position of Solid Cylinder (lowered slightly)
    translate([0, 0, 14]) 
        solid_cylinder();
    
    // Layer 2: Adjusted position of Hollow Cylinder (raised slightly for better separation)
    translate([0, 0, -0.5])
        hollow_cylinder();
}

// Render the final model
model();

