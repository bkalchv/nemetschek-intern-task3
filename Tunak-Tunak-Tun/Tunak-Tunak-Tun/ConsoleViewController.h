//
//  ConsoleViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <UIKit/UIKit.h>
#import "OneMoreTimeViewControllerDelegate.h"
#import "WelcomeViewController.h"
#import "Engine.h"
NS_ASSUME_NONNULL_BEGIN

@interface ConsoleViewController : UIViewController <UIAdaptivePresentationControllerDelegate, EngineDelegate, OneMoreTimeViewControllerDelegate>
@property (nonatomic) Engine* gameEngine;
@end

NS_ASSUME_NONNULL_END
