//
//  Character.h
//  Pirate Adventure
//
//  Created by Daniel Pratt on 7/25/14.
//  Copyright (c) 2014 Daniel Pratt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAArmor.h"
#import "PAWeapon.h"

@interface Character : NSObject

@property (nonatomic) int health;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) PAWeapon *weapon;
@property (nonatomic, strong) PAArmor *armor;

@end
