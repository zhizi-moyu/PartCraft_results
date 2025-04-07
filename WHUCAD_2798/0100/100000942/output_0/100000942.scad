
// Dimensions for the rectangular blocks
block_length = 50;  // length of block
block_width = 20;   // width of block
block_height = 10;  // height of block
hole_diameter = 5;  // diameter of holes
hole_spacing = 15;  // distance between hole centers
layer_spacing = 12; // vertical spacing between layers

module rectangular_block_with_holes() {
    // Create the block
    difference() {
        // Main block
        cube([block_length, block_width, block_height], center = true);

        // Holes in the block
        translate([-hole_spacing / 2, 0, 0])
            cylinder(h = block_height + 2, r = hole_diameter / 2, center = true);

        translate([hole_spacing / 2, 0, 0])
            cylinder(h = block_height + 2, r = hole_diameter / 2, center = true);
    }
}

// Layer arrangement
translate([0, 0, layer_spacing * 2])
    rectangular_block_with_holes();  // Top block (layer_1)

translate([0, 0, layer_spacing])
    rectangular_block_with_holes();  // Middle block (layer_2)

translate([0, 0, 0])
    rectangular_block_with_holes();  // Bottom block (layer_3)

