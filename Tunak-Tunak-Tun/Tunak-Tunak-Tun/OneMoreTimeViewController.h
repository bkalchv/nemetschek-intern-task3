//
//  OneMoreTimeViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 14.12.21.
//

#import <UIKit/UIKit.h>
#import "OneMoreTimeViewControllerDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface OneMoreTimeViewController : UIViewController
@property (nonatomic, strong)id <OneMoreTimeViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
