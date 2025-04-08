
// Parameters
plate_size = 50; // Size of the square plate
plate_thickness = 2; // Thickness of the plate
hole_diameter = 5; // Diameter of the central hole
corner_radius = 2; // Radius for the rounded corners

// Module to create a rounded square plate
module rounded_square_plate(size, thickness, hole_dia, corner_rad) {
    difference() {
        // Create the main square plate with rounded corners
        offset(r = corner_rad) {
            square([size - 2*corner_rad, size - 2*corner_rad], center = true);
        }
        translate([0, 0, -thickness/2])
            cube([size, size, thickness], center = true);
        
        // Subtract the central hole
        translate([0, 0, thickness/2])
            cylinder(d = hole_dia, h = thickness + 1, center = true);
    }
}

// Create the square plate
rounded_square_plate(plate_size, plate_thickness, hole_diameter, corner_radius);

