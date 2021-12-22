//
//  ConsoleViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <UIKit/UIKit.h>
#import "WelcomeViewController.h"

@class Engine;
NS_ASSUME_NONNULL_BEGIN

@interface ConsoleViewController : UIViewController <UIAdaptivePresentationControllerDelegate>
@property (nonatomic) Engine* gameEngine;
@end

NS_ASSUME_NONNULL_END
