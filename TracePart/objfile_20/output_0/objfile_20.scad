
// Parameters
bolt_radius = 2;
bolt_length = 15;
nut_size = 4;
shaft_radius = 5;
shaft_length = 50;
plate_radius = 10;
plate_thickness = 2;
spacer_radius = 8;
spacer_thickness = 3;
end_plate_hole_spacing = 14;
bolt_positions = [
    [7, 7],
    [-7, 7],
    [-7, -7],
    [7, -7]
];

// Central Shaft
module central_shaft() {
    cylinder(h=shaft_length, r=shaft_radius, $fn=100);
}

// End Plate
module end_plate() {
    difference() {
        cylinder(h=plate_thickness, r=plate_radius, $fn=100);
        for (position = bolt_positions) {
            translate([position[0], position[1], 0])
                cylinder(h=2*plate_thickness, r=bolt_radius, $fn=50); // Holes for bolts
        }
    }
}

// Spacer Ring
module spacer_ring() {
    difference() {
        cylinder(h=spacer_thickness, r=spacer_radius, $fn=100);
        cylinder(h=2*spacer_thickness, r=shaft_radius, $fn=100);
    }
}

// Full Assembly
module coupling() {
    // Layer 1: Upper end plate and bolts
    translate([0, 0, shaft_length - plate_thickness])
        end_plate();
    
    // Layer 2: Spacer ring
    translate([0, 0, shaft_length/2 + spacer_thickness])
        spacer_ring();
    
    // Layer 3: Central shaft
    central_shaft();
    
    // Layer 4: Spacer ring
    translate([0, 0, shaft_length/2 - spacer_thickness - plate_thickness])
        spacer_ring();
    
    // Layer 5: Lower end plate and bolts
    translate([0, 0, 0])
        end_plate();
    
    // Nuts and bolts for both end plates
    for (position = bolt_positions) {
        translate([position[0], position[1], shaft_length-plate_thickness])
            cylinder(h=shaft_length + 2*bolt_length, r=bolt_radius, $fn=50); // Bolts
        
        translate([position[0], position[1], shaft_length])
            cylinder(h=nut_size, r=nut_size, $fn=6); // Nuts at the upper end
        
        translate([position[0], position[1], -bolt_length])
            cylinder(h=nut_size, r=nut_size, $fn=6); // Nuts at the lower end
    }
}

// Preview the combined model
coupling();

