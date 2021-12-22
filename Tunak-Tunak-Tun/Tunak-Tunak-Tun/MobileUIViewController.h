//
//  MobileUIViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import <UIKit/UIKit.h>

#import "Engine.h"
#import "MobileUICollectionViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MobileUIViewController : UIViewController <MobileUICollectionViewControllerDelegate, UIAdaptivePresentationControllerDelegate>
@end

NS_ASSUME_NONNULL_END
