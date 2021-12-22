//
//  SecondPlayerNameInputViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 22.12.21.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondPlayerNameInputViewController : ViewController
@property (nonatomic, weak) NSString* username;
@property (nonatomic) BOOL isUIPreferenceSwitchOn;
@end

NS_ASSUME_NONNULL_END
