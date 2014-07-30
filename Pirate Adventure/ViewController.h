//
//  ViewController.h
//  Pirate Adventure
//
//  Created by Daniel Pratt on 7/12/14.
//  Copyright (c) 2014 Daniel Pratt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PATile.h"
#import "Character.h"

@interface ViewController : UIViewController

// For the background image
@property (strong, nonatomic) IBOutlet UIImageView *currentBackgroundImage;

// For gameplay objects
@property (strong, nonatomic) PATile *currentTile;
@property (nonatomic) CGPoint currentLocation;
@property (nonatomic, strong) Character *player;
@property (nonatomic, strong) Character *boss;
@property (nonatomic, strong) Character *pirates;
@property (nonatomic, strong) Character *kraken;
@property (nonatomic, strong) Character *pirateShip;

// Bools
@property (nonatomic) BOOL blackSmith;
@property (nonatomic) BOOL canMoveNow;
@property (nonatomic) BOOL hasParrot;
@property (nonatomic) BOOL playerDead;
@property (nonatomic) BOOL bossDead;

// For columns
@property (strong, nonatomic) NSArray *columnOne;
@property (strong, nonatomic) NSArray *columnTwo;
@property (strong, nonatomic) NSArray *columnThree;
@property (strong, nonatomic) NSArray *columnFour;


// Labels
@property (strong, nonatomic) IBOutlet UILabel *healthValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *damageValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *weaponNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *armorNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *theStoryLable;

// Buttons
@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (strong, nonatomic) IBOutlet UIButton *resetGameButton;

// Direction Buttons
@property (strong, nonatomic) IBOutlet UIButton *northButton;
@property (strong, nonatomic) IBOutlet UIButton *eastButton;
@property (strong, nonatomic) IBOutlet UIButton *southButton;
@property (strong, nonatomic) IBOutlet UIButton *westButton;

// Methods for buttons
- (IBAction)actionButtonAction:(UIButton*)sender;
- (IBAction)northButtonAction:(UIButton *)sender;
- (IBAction)eastButtonAction:(UIButton *)sender;
- (IBAction)soutButtunAction:(UIButton *)sender;
- (IBAction)westButtonAction:(UIButton *)sender;
- (IBAction)resetButtonAction:(UIButton *)sender;

// Methods for game events
- (void) checkSurroundings;
- (void) setCurrentTile;
- (void) setupCurrentBoard;
- (void) createNewGame;


@end

