module rounded_rectangular_block(length, width, height, radius) {
    hull() {
        translate([radius, radius, radius]) sphere(r = radius);
        translate([length - radius, radius, radius]) sphere(r = radius);
        translate([radius, width - radius, radius]) sphere(r = radius);
        translate([length - radius, width - radius, radius]) sphere(r = radius);
        translate([radius, radius, height - radius]) sphere(r = radius);
        translate([length - radius, radius, height - radius]) sphere(r = radius);
        translate([radius, width - radius, height - radius]) sphere(r = radius);
        translate([length - radius, width - radius, height - radius]) sphere(r = radius);
    }
}

// Parameters for the rectangular block
length = 40;  // Block length
width = 30;   // Block width
height = 15;  // Block height
radius = 3;   // Radius for rounded edges and corners

// Create the block
rounded_rectangular_block(length, width, height, radius);
