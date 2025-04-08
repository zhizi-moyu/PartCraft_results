```scad
// Parameters
cube_size = 50;          // Size of the cube
cutout_size = 15;        // Size of the hollow square cutouts
cutout_spacing = 10;     // Spacing between cutouts
cutout_depth = cube_size / 2; // Depth of the hollow cutouts

module hollow_cube() {
    difference() {
        // Main solid cube
        cube([cube_size, cube_size, cube_size]);

        // Hollow cutouts
        for (x = [cutout_spacing, cube_size - cutout_spacing - cutout_size]) {
            for (y = [cutout_spacing, cube_size - cutout_spacing - cutout_size]) {
                translate([x, y, 0]) {
                    cube([cutout_size, cutout_size, cutout_depth]);
                }
            }
        }
    }
}

// Assembly
module flexible_coupling() {
    union() {
        // Top hollow cube
        translate([0, 0, cube_size]) {
            hollow_cube();
        }
        
        // Base hollow cube
        hollow_cube();
    }
}

// Render the flexible coupling
flexible_coupling();
```

