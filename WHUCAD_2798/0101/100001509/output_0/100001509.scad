
// Define a module for a rectangular plate
module rectangular_plate(x, y, z, hole_diameter) {
    difference() {
        cube([x, y, z], center = true);
        translate([0, 0, -z/2 - 0.1]) // Account for z offset
            cylinder(h = z + 0.2, d = hole_diameter, center = true);
    }
}

// Parameters for the rectangular plate
plate_length = 50;         // Length of the plate
plate_width = 50;          // Width of the plate
plate_thickness = 2;       // Thickness of the plate
hole_diameter = 5;         // Diameter of the central hole
spacing = 2.2;             // Spacing between layers

// Assembly of the stacked plates
for (i = [0:5]) {
    translate([0, 0, -i * (plate_thickness + spacing)])
        rectangular_plate(plate_length, plate_width, plate_thickness, hole_diameter);
}

