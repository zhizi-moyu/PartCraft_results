
// Parameters for the components
$fn = 100; // Smoothing parameter for rounded shapes

// 1. Solid Cylinder
module solid_cylinder() {
    union() {
        // The main solid cylinder with slight taper (reduced the taper as requested)
        cylinder(h = 20, r1 = 10, r2 = 9.5, center = true);
    }
}

// 2. Hollow Cylinder
module hollow_cylinder() {
    difference() {
        // Base cylinder
        cylinder(h = 10, r = 9, center = true);
        
        // Hollow inside (recessed area)
        translate([0, 0, -5]) 
            cylinder(h = 15, r = 6, center = true);
    }
}

// Assemble the model layers
module model() {
    // Layer 1: Solid Cylinder (Topmost layer, slightly lowered as requested)
    translate([0, 0, 14.5]) 
        solid_cylinder();
    
    // Layer 2: Hollow Cylinder (Base layer remains unchanged)
    hollow_cylinder();
}

// Render the final model
model();

