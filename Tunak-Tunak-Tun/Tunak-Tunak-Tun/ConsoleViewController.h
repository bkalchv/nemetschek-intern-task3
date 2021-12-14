//
//  ConsoleViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <UIKit/UIKit.h>
#import "Engine.h"
#import "WelcomeViewController.h"

NS_ASSUME_NONNULL_BEGIN



@interface ConsoleViewController : UIViewController
@property (nonatomic, strong) Engine* gameEngine;
@property (weak, nonatomic) NSString* username;
@end

NS_ASSUME_NONNULL_END
