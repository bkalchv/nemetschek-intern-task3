//
//  ConsoleViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <UIKit/UIKit.h>
#import "WelcomeViewController.h"

@class Engine;
typedef NS_ENUM(NSInteger, GameMode);

NS_ASSUME_NONNULL_BEGIN

@interface ConsoleViewController : UIViewController <UIAdaptivePresentationControllerDelegate>
@property (nonatomic) Engine* gameEngine;
@property (nonatomic) NSString* username;
@property (nonatomic) NSString* player2Username;
@property (nonatomic) GameMode gameMode;
@end

NS_ASSUME_NONNULL_END
