
// Main parameters for dimensions
$fn = 100;  // Smoothness of circular objects

module cylinder_core() {
    // Central solid cylinder
    cylinder(h=40, r=10, center=true);
}

module large_end_cap() {
    // Large cylindrical cap with central hole
    difference() {
        cylinder(h=12, r=15, center=true);
        translate([0, 0, -6])
            cylinder(h=12, r=5, center=true);
    }
}

module small_end_cap() {
    // Small cylindrical cap with flat face and central hole
    difference() {
        cylinder(h=8, r=10, center=true);
        translate([0, 0, -4])
            cylinder(h=8, r=5, center=true);
    }
}

module flange() {
    // Flange with multiple bolt holes
    difference() {
        cylinder(h=3, r=13, center=true);
        for (i = [0, 90, 180, 270])
            rotate([0, 0, i])
                translate([10, 0, -1.5])
                    cylinder(h=5, r=1.5, center=true);
    }
}

module spacer() {
    // Thin ring-like spacer
    difference() {
        cylinder(h=3, r=11, center=true);
        translate([0, 0, -1.5])
            cylinder(h=3, r=8, center=true);
    }
}

module connector_rod() {
    // Rod connecting multiple components
    cylinder(h=50, r=4, center=true);
}

module flexible_coupling_assembly() {
    // Assembling all components together

    // Central cylinder
    cylinder_core();

    // Large end cap
    translate([0, 0, 20])  // Positioned to the top of the cylinder
        large_end_cap();

    // Small end cap
    translate([0, 0, -20]) // Positioned to the bottom of the cylinder
        small_end_cap();

    // Flanges and spacers
    for (pos = [10, -10]) {
        translate([0, 0, pos])
            flange();
    }
    
    for (pos = [15, -15]) {
        translate([0, 0, pos])
            spacer();
    }

    // Connector rod passing through everything
    connector_rod();
}

// Call the flexible coupling assembly
flexible_coupling_assembly();

