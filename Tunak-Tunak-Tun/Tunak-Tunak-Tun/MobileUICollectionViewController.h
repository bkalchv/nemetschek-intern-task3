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
- (void)showPlayerWonAlert:(NSString*)playerName withGameBoardState:(NSString*)gameBoardState;
- (void)showOneMoreTimeViewController;
- (void)showAlreadySelectedAlertForCell:(Cell*)cell;
- (void)updateUsernameLabel:(NSString*)currentPlayerUsername;
- (void)enableUndoButton;
- (void)disableUndoButton;
@end

@interface MobileUICollectionViewController : UICollectionViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, EngineDelegate>
@property (nonatomic, strong) Engine* gameEngine;
@property (nonatomic, strong)id <MobileUICollectionViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
