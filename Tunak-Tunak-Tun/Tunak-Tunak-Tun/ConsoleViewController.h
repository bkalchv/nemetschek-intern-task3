//
//  ConsoleViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <UIKit/UIKit.h>
#import "OneMoreTimeViewControllerDelegate.h"
#import "SecondPlayerVCDelegate.h"
#import "WelcomeViewController.h"
#import "Engine.h"
NS_ASSUME_NONNULL_BEGIN

@interface ConsoleViewController : UIViewController <UIAdaptivePresentationControllerDelegate, EngineDelegate, OneMoreTimeViewControllerDelegate>
@property (nonatomic) Engine* gameEngine;
@property (nonatomic, strong)id <SecondPlayerVCDelegate> delegateToSecondPlayerVC;
@end

NS_ASSUME_NONNULL_END
