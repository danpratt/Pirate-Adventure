//
//  PATileFactory.h
//  Pirate Adventure
//
//  Created by Daniel Pratt on 7/14/14.
//  Copyright (c) 2014 Daniel Pratt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PATile.h"

@interface PATileFactory : NSObject

// Arrays to hold tiles

// Main array
@property (nonatomic, strong) NSArray *tiles;

// Columnar arrays
@property (nonatomic, strong) NSArray *columnOneTiles;
@property (nonatomic, strong) NSArray *columnTwoTiles;
@property (nonatomic, strong) NSArray *columnThreeTiles;
@property (nonatomic, strong) NSArray *columnFourTiles;

// Int array for randomization
@property (nonatomic, strong) NSMutableArray *usedTiles;

// Tiles
@property (nonatomic, strong) PATile *pirateAttackTile;
@property (nonatomic, strong) PATile *pirateBlackSmitTile;
@property (nonatomic, strong) PATile *pirateBossTile;
@property (nonatomic, strong) PATile *pirateFriendlyDockTile;
@property (nonatomic, strong) PATile *pirateOctopusAttackTile;
@property (nonatomic, strong) PATile *pirateParrotTile;
@property (nonatomic, strong) PATile *piratePlankTile;
@property (nonatomic, strong) PATile *pirateShipBattleTile;
@property (nonatomic, strong) PATile *pirateStartTile;
@property (nonatomic, strong) PATile *pirateTreasureTile;
@property (nonatomic, strong) PATile *pirateTreasureTwoTile;
@property (nonatomic, strong) PATile *pirateWeaponsTile;

-(void) factorySetup;

@end
