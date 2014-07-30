//
//  PAWeapon.m
//  Pirate Adventure
//
//  Created by Daniel Pratt on 7/24/14.
//  Copyright (c) 2014 Daniel Pratt. All rights reserved.
//

#import "PAWeapon.h"

@implementation PAWeapon

-(void) fists {
    self.name = @"Bare hands";
    self.damage = 1;
}

-(void) piratesBane {
    self.name = @"Pirate's Bane";
    self.damage = 10;
}

-(void) woodenSword {
    self.name = @"Wooden sword";
    self.damage = 4;
}

-(void) masumane {
    self.name = @"Masumane";
    self.damage = 17;
}

-(void) regularSword {
    self.name = @"Pirate Sword";
    self.damage = 4;
}

-(void) bossSword {
    self.name = @"Ultimate Blade";
    self.damage = 14;
}

-(void) krakenArms {
    self.name = @"Kraken's tentacles";
    self.damage = 6;
}

@end
