
// Parameters
u_shaped_connector_width = 20; // Width of the U-shaped connector
u_shaped_connector_height = 10; // Height of the U arms
u_shaped_connector_thickness = 3; // Adjusted thickness for thinner arms
u_hole_diameter = 5; // Diameter of the holes in the U arms
u_hole_offset = 2; // Adjusted offset for holes closer to the ends
cylindrical_base_diameter = 10; // Diameter of the cylindrical base
cylindrical_base_height = 18; // Reduced height for correct alignment

// U-shaped connector
module u_shaped_connector() {
    difference() {
        // Main U-shape
        union() {
            // Left arm
            translate([-u_shaped_connector_width/2, 0, 0])
                cube([u_shaped_connector_thickness, u_shaped_connector_height, u_shaped_connector_width]);

            // Right arm
            translate([u_shaped_connector_width/2 - u_shaped_connector_thickness, 0, 0])
                cube([u_shaped_connector_thickness, u_shaped_connector_height, u_shaped_connector_width]);

            // Base of the U
            translate([-u_shaped_connector_width/2, 0, 0])
                cube([u_shaped_connector_width, u_shaped_connector_height, u_shaped_connector_thickness]);
        }

        // Holes in the arms
        translate([-u_shaped_connector_width/2 + u_hole_offset, u_shaped_connector_height/2, u_shaped_connector_width/2])
            rotate([90, 0, 0])
                cylinder(r=u_hole_diameter/2, h=u_shaped_connector_thickness*2, center=true);

        translate([u_shaped_connector_width/2 - u_hole_offset, u_shaped_connector_height/2, u_shaped_connector_width/2])
            rotate([90, 0, 0])
                cylinder(r=u_hole_diameter/2, h=u_shaped_connector_thickness*2, center=true);
    }
}

// Cylindrical base
module cylindrical_base() {
    cylinder(r=cylindrical_base_diameter/2, h=cylindrical_base_height);
}

// Assembly
module flexible_coupling() {
    // Cylindrical base
    cylindrical_base();

    // U-shaped connector
    translate([0, 0, cylindrical_base_height])
        rotate([0, 0, 0]) // Adjusted rotation for straight alignment
            u_shaped_connector();
}

// Render the full assembly
flexible_coupling();

