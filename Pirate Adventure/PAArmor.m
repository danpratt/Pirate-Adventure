//
//  PAArmor.m
//  Pirate Adventure
//
//  Created by Daniel Pratt on 7/24/14.
//  Copyright (c) 2014 Daniel Pratt. All rights reserved.
//

#import "PAArmor.h"

@implementation PAArmor

-(void) pirateClothes {
    self.name = @"Ruddy Pirate Garb";
    self.damage = 2;
}

-(void) deathBrand {
    self.name = @"Deathbrand Armor";
    self.damage = 11;
}

-(void) regularArmor {
    self.name = @"Pirate's Armor";
    self.damage = 2;
}

-(void) bossArmor {
    self.name = @"Ultimate Armor";
    self.damage = 9;
}

-(void) krakenSkin {
    self.name = @"Kraken";
    self.damage = 5;
}

@end
