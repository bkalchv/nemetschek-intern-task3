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
@property (nonatomic) NSString* username;
@property (nonatomic) NSString* player2Username;
@property (nonatomic) GameMode gameMode;
@end

NS_ASSUME_NONNULL_END
