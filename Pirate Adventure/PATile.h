//
//  PATile.h
//  Pirate Adventure
//
//  Created by Daniel Pratt on 7/12/14.
//  Copyright (c) 2014 Daniel Pratt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PAItem.h"

@interface PATile : NSObject

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) NSString *storyText;
@property (nonatomic, strong) NSString *actionButtonText;
@property (nonatomic, strong) NSString *item;
@property (nonatomic) BOOL canMove;

@end
