
// Parameters
mounting_bracket_thickness = 5;  // Thickness of the bracket base and wall
base_width = 40;  // Width of the rectangular base
base_length = 40;  // Length of the rectangular base
cutout_diameter = 20;  // Diameter of the hollow cylindrical cut-out in the center
mounting_hole_diameter = 5;  // Diameter of mounting holes
edge_radius = 2;  // Radius for rounding edges
wall_height = 20;  // Height of the vertical wall
elongated_hole_width = 5;  // Width of the elongated rectangular holes
elongated_hole_height = 10;  // Height of the elongated rectangular holes
elongated_hole_offset_x = 10;  // Horizontal offset of elongated holes from wall edges
elongated_hole_offset_y = 5;   // Vertical offset of elongated holes from wall base

// Base Mounting Bracket Module
module mounting_bracket() {
    // Base with cylindrical cut-out
    difference() {
        cube([base_width, base_length, mounting_bracket_thickness], center = true);
        translate([0, 0, -1])
            cylinder(h = mounting_bracket_thickness + 2, r = cutout_diameter / 2, center = true);
        for (x = [-base_width / 2 + mounting_hole_diameter, base_width / 2 - mounting_hole_diameter]) {
            for (y = [-base_length / 2 + mounting_hole_diameter, base_length / 2 - mounting_hole_diameter]) {
                translate([x, y, 0])
                    cylinder(h = mounting_bracket_thickness + 2, r = mounting_hole_diameter / 2, center = true);
            }
        }
    }
    
    // Vertical wall
    translate([0, -(base_length / 2 + mounting_bracket_thickness / 2), mounting_bracket_thickness / 2])
        cube([base_width, mounting_bracket_thickness, wall_height], center = true);
    
    // Elongated rectangular holes
    for (x = [-base_width / 2 + elongated_hole_offset_x, base_width / 2 - elongated_hole_offset_x]) {
        translate([x, -(base_length / 2 + mounting_bracket_thickness / 2), mounting_bracket_thickness / 2])
            difference() {
                cube([elongated_hole_width, mounting_bracket_thickness + 1, wall_height], center = true);
                translate([0, 0, wall_height / 2])
                    cube([elongated_hole_width, mounting_bracket_thickness + 1, elongated_hole_height], center = true);
            }
    }
    
    // Edge rounding (optional for smoother visualization)
    translate([-base_width / 2, -base_length / 2, 0]) {
        cube([base_width, base_length, mounting_bracket_thickness], corner_radius = edge_radius);
    }
}

// Assembling all brackets in layer_1
module layer_1() {
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) {
            translate([100, 0, 0])  // Adjust distance based on full assembly size
                mounting_bracket();
        }
    }
}

// Render the layer
layer_1();

