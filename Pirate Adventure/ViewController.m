//
//  ViewController.m
//  Pirate Adventure
//
//  Created by Daniel Pratt on 7/12/14.
//  Copyright (c) 2014 Daniel Pratt. All rights reserved.
//

#import "ViewController.h"
#import "PATileFactory.h"
#import "PATile.h"

@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup a new game
    [self createNewGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionButtonAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You already have it!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    
    // Check if player has won or is dead.
    
    if (_playerDead) {
        UIAlertView *deadAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Alas captain, ye are dead.  Reset to try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [deadAlert show];
    } else if (_bossDead) {
        UIAlertView *winAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Captain, ye are already victorious!  Reset to play again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [winAlert show];
    }
    
    // Wooden Sword
    if ([_currentTile.actionButtonText isEqualToString: @"Take Wooden Sword"]) {
        if ([_player.weapon.name isEqual: @"Wooden sword"]) {
            [alert show];
        } else {
            [_player.weapon woodenSword];
            [self updateWeapon];
        }
        
        // Blacksmith
    } else if ([_currentTile.actionButtonText isEqualToString: @"Upgrade!"]) {
        if (_blackSmith == NO) {
            NSLog(@"Before upgrade weapon = %i armor = %i", _player.weapon.damage, _player.armor.damage);
            _player.weapon.damage += 5;
            _player.armor.damage += 5;
            _blackSmith = YES;
            NSLog(@"After upgrade weapon = %i armor = %i", _player.weapon.damage, _player.armor.damage);
        } else {
            UIAlertView *blackAlert = [[UIAlertView alloc] initWithTitle:nil message:@"He has already upgraded them for you." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [blackAlert show];
        }
        
        // Pirate boss
    } else if ([_currentTile.actionButtonText isEqualToString: @"Fight!"]) {
        if (_player.health > 0 && _boss.health > 0) {
            int bossDamage = (arc4random() % _boss.weapon.damage) - (arc4random() % _player.armor.damage);
            int playerDamage = (arc4random() % _player.weapon.damage) - (arc4random() % _boss.armor.damage);
            if (playerDamage > 0) {
                _boss.health -= playerDamage;
            }
            if (bossDamage > 0) {
                _player.health -= bossDamage;
            }
            
            [self.healthValueLabel setText:[NSString stringWithFormat:@"%i", _player.health]];
            [self.damageValueLabel setText:[NSString stringWithFormat:@"%i", _boss.health]];
            if (_player.health <= 0) {
                UIAlertView *deadAlert = [[UIAlertView alloc] initWithTitle:nil message:@"You have died." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [deadAlert show];
                [self.healthValueLabel setText:@"Dead"];
                _playerDead = YES;
            } else if (_boss.health <= 0) {
                UIAlertView *winAlert = [[UIAlertView alloc] initWithTitle:nil message:@"You win!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [winAlert show];
                [self.damageValueLabel setText:@"You have won!"];
                _bossDead = YES;
            }
        }
        // Rest up
    } else if ([_currentTile.actionButtonText isEqualToString:@"Rest up"]) {
        if (_hasParrot) {
            _player.health = 75;
        } else {
            _player.health = 50;
        }
        [self.healthValueLabel setText:[NSString stringWithFormat:@"%i", _player.health]];
        
        // Fight the kraken
    } else if ([_currentTile.actionButtonText isEqualToString:@"Kill the Beast!"]) {
        if (_player.health > 0 && _kraken.health > 0) {
            int krakenDamage = (arc4random() % _kraken.weapon.damage) - (arc4random() % _player.armor.damage);
            int playerDamage = (arc4random() % _player.weapon.damage) - (arc4random() % _kraken.armor.damage);
            if (playerDamage > 0) {
                _kraken.health -= playerDamage;
            } if (krakenDamage > 0) {
                _player.health -= krakenDamage;
            }
            [self.healthValueLabel setText:[NSString stringWithFormat:@"%i", _player.health]];
            [self.damageValueLabel setText:[NSString stringWithFormat:@"%i", _kraken.health]];
            if (_player.health <= 0) {
                UIAlertView *deadAlert = [[UIAlertView alloc] initWithTitle:nil message:@"You have died." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [deadAlert show];
                [self.healthValueLabel setText:@"Dead"];
                _playerDead = YES;
            } else if (_kraken.health <= 0) {
                _currentTile.canMove = YES;
                [self.damageValueLabel setText:@"Not currently in battle"];
                [self checkSurroundings];
            }
        }
        
        // Find the parrot
    } else if ([_currentTile.actionButtonText isEqualToString:@"Keep It"]) {
        if (_hasParrot) {
            UIAlertView *parrotAlert = [[UIAlertView alloc] initWithTitle:nil message:@"You already have him!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [parrotAlert show];
        } else {
            _hasParrot = YES;
            _player.health = 75;
            [self.healthValueLabel setText:[NSString stringWithFormat:@"%i", _player.health]];
        }
        
        // Walk the plank
    } else if ([_currentTile.actionButtonText isEqualToString:@"Hold Your Breath"]) {
        _player.health -= 5;
        [self.healthValueLabel setText:[NSString stringWithFormat:@"%i", _player.health]];
        _currentTile.canMove = YES;
        [self checkSurroundings];
        
        // Pirate ship battle
    } else if ([_currentTile.actionButtonText isEqualToString:@"Charge!"]) {
        if (_player.health > 0 && _pirateShip.health > 0) {
            int pirateShipDamage = (arc4random() % _pirateShip.weapon.damage) - (arc4random() % _player.armor.damage);
            int playerDamage = (arc4random() % _player.weapon.damage) - (arc4random() % _pirateShip.armor.damage);
            if (playerDamage > 0) {
                _pirateShip.health -= playerDamage;
            } if (pirateShipDamage > 0) {
                _player.health -= pirateShipDamage;
            }
            [self.healthValueLabel setText:[NSString stringWithFormat:@"%i", _player.health]];
            [self.damageValueLabel setText:[NSString stringWithFormat:@"%i", _pirateShip.health]];
            if (_player.health <= 0) {
                UIAlertView *deadAlert = [[UIAlertView alloc] initWithTitle:nil message:@"You have died." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [deadAlert show];
                [self.healthValueLabel setText:@"Dead"];
                _playerDead = YES;
            } else if (_pirateShip.health <= 0) {
                _currentTile.canMove = YES;
                [self.damageValueLabel setText:@"Not currently in battle"];
                [self checkSurroundings];
            }
        }
        // Found Masumane
    } else if ([_currentTile.actionButtonText isEqualToString:@"Take Masumane"]) {
        [_player.weapon masumane];
        [self updateWeapon];
        NSLog(@"Weapon = %@ damage =%i", _player.weapon.name, _player.weapon.damage);
        
        // Deathbrand armor
    } else if ([_currentTile.actionButtonText isEqualToString:@"Take Deathbrand Armor"]) {
        [_player.armor deathBrand];
        [self updateArmor];
        NSLog(@"Armor = %@ damage =%i", _player.armor.name, _player.armor.damage);
        
        // Guns
    } else if ([_currentTile.actionButtonText isEqualToString:@"Take Pirate's Bane"]) {
        [_player.weapon piratesBane];
        [self updateWeapon];
        NSLog(@"Weapon = %@ damage =%i", _player.weapon.name, _player.weapon.damage);
        
        // Fighting pirates
    } else if ([_currentTile.actionButtonText isEqualToString:@"Defend Yourselves!"]) {
        if (_player.health > 0 && _pirates.health > 0) {
            int piratesDamage = (arc4random() % _pirates.weapon.damage) - (arc4random() % _player.armor.damage);
            int playerDamage = (arc4random() % _player.weapon.damage) - (arc4random() % _pirates.armor.damage);
            if (playerDamage > 0) {
                _pirates.health -= playerDamage;
            } if (piratesDamage > 0) {
                _player.health -= piratesDamage;
            }
            [self.healthValueLabel setText:[NSString stringWithFormat:@"%i", _player.health]];
            [self.damageValueLabel setText:[NSString stringWithFormat:@"%i", _pirates.health]];
            if (_player.health <= 0) {
                UIAlertView *deadAlert = [[UIAlertView alloc] initWithTitle:nil message:@"You have died." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [deadAlert show];
                [self.healthValueLabel setText:@"Dead"];
                _playerDead = YES;
            } else if (_pirates.health <= 0) {
                _currentTile.canMove = YES;
                [self.damageValueLabel setText:@"Not currently in battle"];
                [self checkSurroundings];
            }

        }
    }
    
    else {
        NSLog(@"Ooops, there is a bug!  Current tile title = %@", _currentTile.actionButtonText);
    }
}

- (IBAction)northButtonAction:(UIButton *)sender {
    if (_canMoveNow == YES) {
        _currentLocation.y++;
        [self setCurrentTile];
        [self checkSurroundings];
        [self setupCurrentBoard];
    } else {
        NSLog(@"You can't move");
    }

}

- (IBAction)eastButtonAction:(UIButton *)sender {
    if (_canMoveNow == YES) {
        _currentLocation.x++;
        [self setCurrentTile];
        [self checkSurroundings];
        [self setupCurrentBoard];
    } else {
        NSLog(@"You can't move");
    }
}

- (IBAction)soutButtunAction:(UIButton *)sender {
    if (_canMoveNow == YES) {
        _currentLocation.y--;
        [self setCurrentTile];
        [self checkSurroundings];
        [self setupCurrentBoard];
    } else {
        NSLog(@"You can't move");
    }
}

- (IBAction)westButtonAction:(UIButton *)sender {
    if (_canMoveNow == YES) {
        _currentLocation.x--;
        [self setCurrentTile];
        [self checkSurroundings];
        [self setupCurrentBoard];
    } else {
        NSLog(@"You can't move");
    }
}

- (IBAction)resetButtonAction:(UIButton *)sender {
    [self createNewGame];
}

- (void) checkSurroundings {
    _canMoveNow = _currentTile.canMove;
    
    if (_canMoveNow && _playerDead == NO && _bossDead == NO) {
        if ((int)_currentLocation.x == 0) {
            self.westButton.hidden = YES;
        } else {
            self.westButton.hidden = NO;
        }
        
        if ((int)_currentLocation.x == 3) {
            self.eastButton.hidden = YES;
        } else {
            self.eastButton.hidden = NO;
        }
        
        if ((int)_currentLocation.y == 0) {
            self.southButton.hidden = YES;
        } else {
            self.southButton.hidden = NO;
        }
        
        if ((int)_currentLocation.y == 2) {
            self.northButton.hidden = YES;
        } else {
            self.northButton.hidden = NO;
        }
    } else if (_playerDead) {
        UIAlertView *deadAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Alas captain, ye are dead.  Reset to try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [deadAlert show];
    } else if (_bossDead) {
        UIAlertView *winAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Captain, ye are already victorious!  Reset to play again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [winAlert show];
    } else {
        self.northButton.hidden = YES;
        self.eastButton.hidden = YES;
        self.southButton.hidden = YES;
        self.westButton.hidden = YES;
    }
    
    
}

- (void) setCurrentTile {
    NSLog(@"Current x = %i, current y = %i", (int)_currentLocation.x, (int)_currentLocation.y);
    if ((int)_currentLocation.x == 0) {
        _currentTile = [_columnOne objectAtIndex:(int)_currentLocation.y];
    } else if ((int)_currentLocation.x == 1) {
        _currentTile = [_columnTwo objectAtIndex:_currentLocation.y];
    } else if ((int)_currentLocation.x == 2) {
        _currentTile = [_columnThree objectAtIndex:_currentLocation.y];
    } else if ((int)_currentLocation.x == 3) {
        _currentTile = [_columnFour objectAtIndex:_currentLocation.y];
    } else {
        NSLog(@"Fatal error, incorrect column.");
    }
}

- (void) setupCurrentBoard {
    [self.currentBackgroundImage setImage:_currentTile.backgroundImage];
    [self.actionButton setTitle:_currentTile.actionButtonText forState:UIControlStateNormal];
    [self.theStoryLable setText:_currentTile.storyText];
}

- (void) createNewGame {
    
    PATileFactory *factory = [[PATileFactory alloc] init];
    [factory factorySetup];
    _columnOne = [factory.tiles objectAtIndex:0];
    _columnTwo = [factory.tiles objectAtIndex:1];
    _columnThree = [factory.tiles objectAtIndex:2];
    _columnFour = [factory.tiles objectAtIndex:3];
    
    // Setup player, armor, and weapon.
    _player = [[Character alloc] init];
    _player.health = 50;
    _player.weapon = [[PAWeapon alloc] init];
    [_player.weapon fists];
    _player.armor = [[PAArmor alloc] init];
    [_player.armor pirateClothes];
    
    // Set flags
    _blackSmith = NO;
    _hasParrot = NO;
    _playerDead = NO;
    _bossDead = NO;
    
    // Setup the boss
    _boss = [[Character alloc] init];
    _boss.health = 75;
    _boss.weapon = [[PAWeapon alloc] init];
    [_boss.weapon bossSword];
    _boss.armor = [[PAArmor alloc] init];
    [_boss.armor bossArmor];
    
    // Setup pirates
    _pirates = [[Character alloc] init];
    _pirates.health = 10;
    _pirates.weapon = [[PAWeapon alloc] init];
    [_pirates.weapon regularSword];
    _pirates.armor = [[PAArmor alloc] init];
    [_pirates.armor regularArmor];
    
    // Setup Kraken
    _kraken = [[Character alloc] init];
    _kraken.health = 25;
    _kraken.weapon = [[PAWeapon alloc] init];
    _kraken.armor = [[PAArmor alloc] init];
    [_kraken.weapon krakenArms];
    [_kraken.armor krakenSkin];
    
    // Setup pirate ship
    _pirateShip = [[Character alloc] init];
    _pirateShip.health = 20;
    _pirateShip.weapon = [[PAWeapon alloc] init];
    _pirateShip.armor = [[PAArmor alloc] init];
    [_pirateShip.weapon regularSword];
    [_pirateShip.armor regularArmor];
    
    // Set initial label states
    [self.healthValueLabel setText:[NSString stringWithFormat:@"%i", _player.health]];
    [self.damageValueLabel setText:@"Not currently in battle"];
    [self.weaponNameLabel setText:_player.weapon.name];
    [self.armorNameLabel setText:_player.armor.name];
    
    //    CGPoint start = CGPointMake(0, 0);
    //    _currentLocation = &start;
    _currentLocation = CGPointMake(0, 0);
    NSLog(@"%i, %i", (int)_currentLocation.x, (int)_currentLocation.y);
    [self setCurrentTile];
    
    // Setup current location
    
    [self checkSurroundings];
    [self setupCurrentBoard];
}

-(void) updateWeapon {
    [self.weaponNameLabel setText:_player.weapon.name];
}

-(void) updateArmor {
    [self.armorNameLabel setText:_player.armor.name];
}

@end
