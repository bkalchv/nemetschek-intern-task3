//
//  MobileUIViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import <UIKit/UIKit.h>

#import "Engine.h"

NS_ASSUME_NONNULL_BEGIN

@interface MobileUIViewController : UIViewController
@property (nonatomic, strong) Engine* gameEngine;
@property (nonatomic, weak) NSString* username;
@end

NS_ASSUME_NONNULL_END
