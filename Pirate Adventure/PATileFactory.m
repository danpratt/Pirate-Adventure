//
//  PATileFactory.m
//  Pirate Adventure
//
//  Created by Daniel Pratt on 7/14/14.
//  Copyright (c) 2014 Daniel Pratt. All rights reserved.
//

#import "PATileFactory.h"
#import "PATile.h"
#import "PAWeapon.h"
#import "PAArmor.h"

@implementation PATileFactory

-(void) factorySetup {
    _usedTiles = [[NSMutableArray alloc] initWithCapacity:12];
    [self setupTileProperties];
    [self setupColumns];
    _tiles = [[NSArray alloc] initWithObjects:_columnOneTiles, _columnTwoTiles, _columnThreeTiles, _columnFourTiles, nil];
}

-(void) setupColumns {
    // Use up starting tile first so it doesn't randomly get used up in another place
    [_usedTiles addObject:[NSNumber numberWithInt:8]];
    
    // Create the columns
    _columnOneTiles = [[NSArray alloc] initWithObjects: _pirateStartTile, [self assignTile:[self getRandom]], [self assignTile:[self getRandom]], nil];
    
    _columnTwoTiles = [[NSArray alloc] initWithObjects:[self assignTile:[self getRandom]], [self assignTile:[self getRandom]], [self assignTile:[self getRandom]], nil];
    
    _columnThreeTiles = [[NSArray alloc] initWithObjects:[self assignTile:[self getRandom]], [self assignTile:[self getRandom]], [self assignTile:[self getRandom]], nil];
    
    _columnFourTiles = [[NSArray alloc] initWithObjects:[self assignTile:[self getRandom]], [self assignTile:[self getRandom]], [self assignTile:[self getRandom]], nil];
    
}

-(int) getRandom {
    int randInt = arc4random() % 12;
    NSNumber *random = [NSNumber numberWithInt:randInt];
    
    if ([_usedTiles containsObject:[NSNumber numberWithInt:randInt]]) {
        return [self getRandom];
    } else {
        [_usedTiles addObject:random];
        return randInt;
    }
}

-(PATile *) assignTile: (int) tileNumber {
    switch (tileNumber) {
        case 0:
            return _pirateAttackTile;
            break;
            
        case 1:
            return _pirateBlackSmitTile;
            break;
            
        case 2:
            return _pirateBossTile;
            break;
            
        case 3:
            return _pirateFriendlyDockTile;
            break;
            
        case 4:
            return _pirateOctopusAttackTile;
            break;
            
        case 5:
            return _pirateParrotTile;
            break;
            
        case 6:
            return _piratePlankTile;
            break;
            
        case 7:
            return _pirateShipBattleTile;
            break;
            
        case 8:
            return _pirateStartTile;
            break;
            
        case 9:
            return _pirateTreasureTile;
            break;
            
        case 10:
            return _pirateTreasureTwoTile;
            break;
            
        default:
            return _pirateWeaponsTile;
            break;
    }
}

-(void) setupTileProperties {
    // Under attack Tile 0
    _pirateAttackTile = [[PATile alloc] init];
    _pirateAttackTile.backgroundImage = [UIImage imageNamed:@"PirateAttack.jpg"];
    _pirateAttackTile.actionButtonText = @"Defend Yourselves!";
    _pirateAttackTile.storyText = @"Captain!  We are under attack by a hoard of rouge pirates!";
    _pirateAttackTile.canMove = NO;

    // Arrived at the blacksmith Tile 1
    _pirateBlackSmitTile = [[PATile alloc] init];
    _pirateBlackSmitTile.backgroundImage = [UIImage imageNamed:@"PirateBlacksmith.jpeg"];
    _pirateBlackSmitTile.actionButtonText = @"Upgrade!";
    _pirateBlackSmitTile.storyText = @"You come upon a pirate blacksmith.  He says, \"Arg, blast that scurvey dog, Roberts!  If yer out ta rid da seas o' tha' landlubbin' bastard, I'll gladly sharpen yer steal, and strengthen yer armor.\"";
    _pirateBlackSmitTile.canMove = YES;
    
    // Found the boss Tile 2
    _pirateBossTile = [[PATile alloc] init];
    _pirateBossTile.backgroundImage = [UIImage imageNamed:@"PirateBoss.jpeg"];
    _pirateBossTile.actionButtonText = @"Fight!";
    _pirateBossTile.storyText = @"As the mist clears, you spot the Dread Pirate Robert's ship.  The arrogant fool accepts your challenge for a duel.  As you pull your blade, the sun glints off of the gold in his wicked smile.  Your journey ends here, one way or the other.";
    _pirateBossTile.canMove = NO;
    
    // Rest up Tile 3
    _pirateFriendlyDockTile = [[PATile alloc] init];
    _pirateFriendlyDockTile.backgroundImage = [UIImage imageNamed:@"PirateFriendlyDock.jpg"];
    _pirateFriendlyDockTile.actionButtonText = @"Rest up";
    _pirateFriendlyDockTile.storyText = @"You sigh a silent relief as you spot the shores of a firendly village.  They are no friends to Roberts, which makes them friends of yours.  You can rest your weary bones in this safe harbor.";
    _pirateFriendlyDockTile.canMove = YES;
    
    // Oh no, a giant octupus! Tile 4
    _pirateOctopusAttackTile = [[PATile alloc] init];
    _pirateOctopusAttackTile.backgroundImage = [UIImage imageNamed:@"PirateOctopusAttack.jpg"];
    _pirateOctopusAttackTile.actionButtonText = @"Kill the Beast!";
    _pirateOctopusAttackTile.storyText = @"Your entire ships shudders as a giant beast appears off the bow of the ship.  The legendary Kraken!";
    _pirateOctopusAttackTile.canMove = NO;
    
    // You find a parrot friend Tile 5
    _pirateParrotTile = [[PATile alloc] init];
    _pirateParrotTile.backgroundImage = [UIImage imageNamed:@"PirateParrot.jpg"];
    _pirateParrotTile.actionButtonText = @"Keep It";
    _pirateParrotTile.storyText = @"As the rough sea waves crest the railings of your ship, you spot a bird flying toward you out of the clouds.  He lands on your shoulder and nibbles affectionately at your ear.  The site of the magnificent parrot seems to liven the crew's spirits.  It seems you now have a new member of the crew!";
    _pirateParrotTile.canMove = YES;
    
    // Walk the plank Tile 6
    _piratePlankTile = [[PATile alloc] init];
    _piratePlankTile.backgroundImage = [UIImage imageNamed:@"PiratePlank.jpg"];
    _piratePlankTile.actionButtonText = @"Hold Your Breath";
    _piratePlankTile.storyText = @"You have been captured by rouge pirates and are asked to walk the plank.  The pirates just want to have a bit of fun at your expense, refuse and they will kill you and sink your ship.";
    _piratePlankTile.canMove = NO;
    
    // Fight some other pirates Tile 7
    _pirateShipBattleTile = [[PATile alloc] init];
    _pirateShipBattleTile.backgroundImage = [UIImage imageNamed:@"PirateShipBattle.jpeg"];
    _pirateShipBattleTile.actionButtonText = @"Charge!";
    _pirateShipBattleTile.storyText = @"You glimpse a jolly roger's in the distance.  Could this be it?  Could your journey be near the end?  As you draw closer, and they begin to fire their cannons toward your ship, you realize that this is just an average band of pirates.  You must fight them all the same.  To battle!";
    _pirateShipBattleTile.canMove = NO;
    
    // Starting Tile 8
    _pirateStartTile = [[PATile alloc] init];
    _pirateStartTile.backgroundImage = [UIImage imageNamed:@"PirateStart.jpg"];
    _pirateStartTile.actionButtonText = @"Take Wooden Sword";
    _pirateStartTile.storyText = @"The dread pirate Roberts has been terrorizing these parts.  None are safe until he is killed.  Please help make these waters safe again!  It's dangerous to go alone, take this wooden sword to help you on your way.";
    _pirateStartTile.canMove = YES;
    
    // Sword treasure Tile 9
    _pirateTreasureTile = [[PATile alloc] init];
    _pirateTreasureTile.backgroundImage = [UIImage imageNamed:@"PirateTreasure.jpeg"];
    _pirateTreasureTile.actionButtonText = @"Take Masumane";
    _pirateTreasureTile.storyText = @"Captain!  We have found glorius treasure!  The legendary Masumane, the greatest sword mankind has ever seen!";
    _pirateTreasureTile.canMove = YES;

    // Armor treasure Tile 10
    _pirateTreasureTwoTile = [[PATile alloc] init];
    _pirateTreasureTwoTile.backgroundImage = [UIImage imageNamed:@"PirateTreasurer2.jpeg"];
    _pirateTreasureTwoTile.actionButtonText = @"Take Deathbrand Armor";
    _pirateTreasureTwoTile.storyText = @"You come across a shipwreck.  As you wade through the piles of bones that litter the deck, you spot the legendary armor of the ancient pirate king Haknir Death-Brand.  His armor still looks like is was freshly smithed.  Surely you could never be defeated wearing this; even so, you have to wonder how the pirate king came to meet his doom here.";
    _pirateTreasureTwoTile.canMove = YES;

    // You found some guns Tile 11
    _pirateWeaponsTile = [[PATile alloc] init];
    _pirateWeaponsTile.backgroundImage = [UIImage imageNamed:@"PirateWeapons.jpeg"];
    _pirateWeaponsTile.actionButtonText = @"Take Pirate's Bane";
    _pirateWeaponsTile.storyText = @"As you stop to refill your water supplies on an island oasis, you see a decaying pirate hanging from a tree.  He is wearing dueling guns said to have never lost a duel.  They are also said to be cursed.  Judging from the poor sap hanging in the tree, there may be something to this curse.";
    _pirateWeaponsTile.canMove = YES;

}

@end
