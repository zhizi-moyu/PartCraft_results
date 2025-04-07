
// Main parameters for dimensions
$fn = 100;  // Smoothness of circular objects

module cylinder_core() {
    // Central solid cylinder with slender profile
    cylinder(h=45, r=8, center=true); // Reduced thickness
}

module large_end_cap() {
    // Large cylindrical cap with adjustments for curvature and symmetry
    difference() {
        union() {
            cylinder(h=12, r=14, center=true); // Slightly reduced radius
            translate([0, 0, 6])
                sphere(r=14); // Adjusting rounded effect
        }
        translate([0, 0, -6])
            cylinder(h=12, r=4, center=true); // Slightly smaller hole
    }
}

module small_end_cap() {
    // Small cylindrical cap adjusted in thickness and diameter
    difference() {
        cylinder(h=4, r=7, center=true); // Adjusted thickness and diameter
        translate([0, 0, -2])
            cylinder(h=4, r=5, center=true);
    }
}

module flange() {
    // Flange with refined shape and bolt spacing
    difference() {
        cylinder(h=2, r=12, center=true); // Adjusted thickness
        for (i = [0, 36, 72, 108, 144, 180, 216, 252, 288, 324]) // Evenly spaced holes
            rotate([0, 0, i])
                translate([9, 0, -1])
                    cylinder(h=4, r=1, center=true); // Smaller bolt holes
    }
}

module spacer() {
    // Spacer with correct width and outer diameter
    difference() {
        cylinder(h=1.8, r=9, center=true); 
        translate([0, 0, -0.9])
            cylinder(h=1.8, r=6.5, center=true); 
    }
}

module connector_rod() {
    // Rod with corrected length
    difference() {
        cylinder(h=48, r=3.5, center=true); 
        for (pos = [-18, 0, 18]) { // Adjusting groove positions
            translate([0, 0, pos])
                cylinder(h=2, r=3, center=true);
        }
    }
}

module flexible_coupling_assembly() {
    // Assembling all components with corrected positioning and sizing

    // Central cylinder
    cylinder_core();

    // Large end cap
    translate([0, 0, 24]) // Adjusted position for resized components
        large_end_cap();

    // Small end cap
    translate([0, 0, -24]) // Adjusted position for resized components
        small_end_cap();

    // Flanges and spacers
    for (pos = [10, -10]) { // Closer positioning
        translate([0, 0, pos])
            flange();
    }
    
    for (pos = [14, -14]) { // Adjusted for alignment
        translate([0, 0, pos])
            spacer();
    }

    // Connector rod passing through everything
    connector_rod();
}

// Call the flexible coupling assembly
flexible_coupling_assembly();

