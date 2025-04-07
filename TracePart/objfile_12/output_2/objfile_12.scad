
// Parameters
$fn = 100; // Resolution for smooth circles

// Functions to generate components

// Circular Disk with Holes
module circular_disk_with_holes() {
    difference() {
        cylinder(h = 10, r = 40); // Outer disk
        cylinder(h = 20, r = 12); // Adjusted central hole to reduce size
        for (angle = [0:45:360-45]) { // Adjusted spacing for uniform distribution
            rotate([0, 0, angle]) translate([30, 0, 0])
                cylinder(h = 10, r = 3.5); // Reduced size to enhance proportionality
        }
    }
}

// Cylinder with Flange
module cylinder_with_flange() {
    union() {
        // Flange base
        cylinder(h = 6, r = 40); // Reduced flange thickness

        // Cylinder above the flange
        translate([0, 0, 6]) cylinder(h = 30, r = 20);

        // Accentuated grooved section for mechanical fastening
        for (z_step = [10:10:30]) {
            translate([0, 0, z_step])
                difference() {
                    cylinder(h = 4, r = 22); // Narrow grooves
                    translate([0, 0, -2]) cylinder(h = 6, r = 20); // Core cylinder
                }
        }

        // Central hollow matching original dimensions
        translate([0, 0, 6]) cylinder(h = 50, r = 10);

        // Uniformly spaced bolt holes on flange
        for (angle = [0:60:360-60]) { // Adjusted for six holes
            rotate([0, 0, angle]) translate([30, 0, 3])
                cylinder(h = 10, r = 2.5);
        }
    }
}

// Slotted Cylinder
module slotted_cylinder() {
    difference() {
        // Base cylinder
        translate([0, 0, -5]) cylinder(h = 40, r = 25); // Ensured consistent diameter

        // Wider and precisely positioned slot along cylinder length
        rotate([90, 0, 0]) translate([-25, 0, -20]) cube([50, 10, 50], center = true);

        // Larger hole at one end
        translate([0, 0, 35]) cylinder(h = 10, r = 28); // Enhanced proportional contrast

        // Central hollow
        translate([0, 0, -5]) cylinder(h = 50, r = 10);

        // Bolt holes at the larger diameter end
        for (angle = [0:45:360-45]) {
            rotate([0, 0, angle]) translate([25, 0, 35])
                cylinder(h = 20, r = 3); // Adjusted position and size for precision
        }
    }
}

// Assembly of Components
module flexible_coupling() {
    // Layer 1: Circular disk
    circular_disk_with_holes();

    // Layer 2: Cylinder and Slotted Cylinder
    translate([0, 0, -10]) cylinder_with_flange();
    translate([0, 0, -25]) slotted_cylinder();
}

// Call the main assembly module
flexible_coupling();

