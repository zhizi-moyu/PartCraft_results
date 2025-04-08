```scad
// Function to create a cuboid with rounded edges
module rounded_cuboid(size, radius) {
    hull() {
        for (x = [-size[0]/2, size[0]/2])
            for (y = [-size[1]/2, size[1]/2])
                for (z = [-size[2]/2, size[2]/2])
                    translate([x, y, z])
                    sphere(radius);
    }
}

// Dimensions for the cuboid components
cuboid_size = [20, 20, 10]; // Width, Depth, Height
corner_radius = 2; // Radius for rounded edges

// Stack the components vertically based on their positional relationships
translate([0, 0, 50]) rounded_cuboid(cuboid_size, corner_radius); // cuboid_component_6 (layer_1)
translate([0, 0, 40]) rounded_cuboid(cuboid_size, corner_radius); // cuboid_component_5 (layer_2)
translate([0, 0, 30]) rounded_cuboid(cuboid_size, corner_radius); // cuboid_component_4 (layer_3)
translate([0, 0, 20]) rounded_cuboid(cuboid_size, corner_radius); // cuboid_component_3 (layer_4)
translate([0, 0, 10]) rounded_cuboid(cuboid_size, corner_radius); // cuboid_component_2 (layer_5)
translate([0, 0, 0]) rounded_cuboid(cuboid_size, corner_radius);  // cuboid_component_1 (layer_6)
```

