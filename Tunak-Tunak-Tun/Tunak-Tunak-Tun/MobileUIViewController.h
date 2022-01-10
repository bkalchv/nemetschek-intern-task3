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

NS_ASSUME_NONNULL_BEGIN

@interface MobileUIViewController : UIViewController <MobileUICollectionViewControllerDelegate, UIAdaptivePresentationControllerDelegate>
@property (nonatomic, strong)id <MobileUIViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
