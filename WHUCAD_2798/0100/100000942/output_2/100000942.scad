// Dimensions for the rectangular blocks
block_length = 50;  // length of block
block_width = 20;   // width of block
block_height = 10;  // height of block
hole_diameter = 7;  // slightly increased diameter of holes
hole_spacing = 35;  // adjusted distance to move holes towards one end

module rectangular_block_with_holes() {
    // Create the block
    difference() {
        // Main block
        cube([block_length, block_width, block_height]);

        // Holes in the block
        translate([block_length/2 - hole_spacing, block_width/2, block_height/2])
            rotate([90, 0, 0])  // Align the holes vertically
            cylinder(h = block_height + 2, r = hole_diameter / 2, center = true);

        translate([block_length/2 + hole_spacing - block_length, block_width/2, block_height/2])
            rotate([90, 0, 0])  // Align the holes vertically
            cylinder(h = block_height + 2, r = hole_diameter / 2, center = true);
    }
}

// Single block for the original model
rectangular_block_with_holes();
