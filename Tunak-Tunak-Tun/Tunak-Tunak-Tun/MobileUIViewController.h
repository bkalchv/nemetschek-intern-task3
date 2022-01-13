//
//  MobileUIViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import <UIKit/UIKit.h>

#import "Engine.h"
#import "MobileUICollectionViewControllerDelegate.h"
#import "MobileUIViewControllerDelegate.h"
#import "OneMoreTimeViewControllerDelegate.h"
#import "SecondPlayerVCDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MobileUIViewController : UIViewController <MobileUICollectionViewControllerDelegate,OneMoreTimeViewControllerDelegate>
@property (nonatomic, strong)id <MobileUIViewControllerDelegate> delegate;
@property (nonatomic, strong)id <SecondPlayerVCDelegate> delegateToSecondPlayerVC;
@end

NS_ASSUME_NONNULL_END
