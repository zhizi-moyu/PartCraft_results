
// Main parameters for dimensions
$fn = 100;  // Smoothness of circular objects

module cylinder_core() {
    // Central solid cylinder with adjusted length
    cylinder(h=45, r=10, center=true); // Increased length to match original model
}

module large_end_cap() {
    // Large cylindrical cap with central hole and rounded outer surface
    difference() {
        union() {
            cylinder(h=12, r=15, center=true);
            translate([0, 0, 6]) 
                sphere(r=15); // Introducing rounded effect
        }
        translate([0, 0, -6])
            cylinder(h=12, r=5, center=true);
    }
}

module small_end_cap() {
    // Small cylindrical cap with reduced size and depth
    difference() {
        cylinder(h=6, r=8, center=true); // Reduced diameter and profile depth
        translate([0, 0, -3])
            cylinder(h=6, r=5, center=true);
    }
}

module flange() {
    // Flange with increased number of bolt holes and thinner profile
    difference() {
        cylinder(h=2.5, r=13, center=true); // Reduced thickness
        for (i = [0, 45, 90, 135, 180, 225, 270, 315]) // Increased the number of bolt holes
            rotate([0, 0, i])
                translate([10, 0, -1.25])
                    cylinder(h=5, r=1.5, center=true);
    }
}

module spacer() {
    // Thin ring-like spacer with reduced dimensions
    difference() {
        cylinder(h=2, r=10, center=true); // Reduced width and thickness
        translate([0, 0, -1])
            cylinder(h=2, r=7, center=true); 
    }
}

module connector_rod() {
    // Rod connecting components with additional grooves
    difference() {
        cylinder(h=50, r=4, center=true); 
        for (pos = [-20, 0, 20]) { // Adding grooves along the length
            translate([0, 0, pos])
                cylinder(h=2, r=3.5, center=true);
        }
    }
}

module flexible_coupling_assembly() {
    // Assembling all components together

    // Central cylinder
    cylinder_core();

    // Large end cap
    translate([0, 0, 22.5])  // Adjusted position for extended cylinder
        large_end_cap();

    // Small end cap
    translate([0, 0, -22.5]) // Adjusted position for extended cylinder
        small_end_cap();

    // Flanges and spacers
    for (pos = [12, -12]) { // Adjusted distance between flanges
        translate([0, 0, pos])
            flange();
    }
    
    for (pos = [17, -17]) { // Adjusted distance between spacers
        translate([0, 0, pos])
            spacer();
    }

    // Connector rod passing through everything
    connector_rod();
}

// Call the flexible coupling assembly
flexible_coupling_assembly();

