
// Parameters for cylindrical body
cylindrical_body_diameter = 50; // Diameter of the cylindrical body
cylindrical_body_height = 30;   // Height of the cylindrical body
recess_diameter = 30;           // Diameter of the recessed hollow at the bottom
recess_depth = 10;              // Depth of the recessed hollow

// Parameters for base cylinder
base_cylinder_diameter = 20;    // Diameter of the base cylinder
base_cylinder_height = 10;      // Height of the base cylinder

// Main cylindrical body
module cylindrical_body() {
    difference() {
        cylinder(d = cylindrical_body_diameter, h = cylindrical_body_height, center = true);
        translate([0, 0, -cylindrical_body_height / 2])
            cylinder(d = recess_diameter, h = recess_depth, center = false);
    }
}

// Base cylinder
module base_cylinder() {
    cylinder(d = base_cylinder_diameter, h = base_cylinder_height, center = true);
}

// Combine components
translate([0, 0, base_cylinder_height / 2])
    cylindrical_body();

translate([0, 0, -cylindrical_body_height / 2 - base_cylinder_height / 2])
    base_cylinder();

