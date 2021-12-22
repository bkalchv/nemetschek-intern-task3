//
//  MobileUICollectionViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import <UIKit/UIKit.h>
#import "Engine.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MobileUICollectionViewControllerDelegate <NSObject>
- (void)showDrawAlert:(NSString*)gameBoardState;
- (void)showPlayerWonAlert:(Player*)player withGameBoardState:(NSString*)gameBoardState;
- (void)showOneMoreTimeViewController;
- (void)showAlreadySelectedAlertForCell:(Cell*)cell;

@end

@interface MobileUICollectionViewController : UICollectionViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) Engine* gameEngine;
@property (nonatomic, strong) NSString* username;
@property (nonatomic) GameMode gameMode;
@property (nonatomic, strong)id <MobileUICollectionViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
