//
//  MobileUICollectionViewControllerDelegate.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 10.01.22.
//

#ifndef MobileUICollectionViewControllerDelegate_h
#define MobileUICollectionViewControllerDelegate_h

@protocol MobileUICollectionViewControllerDelegate <NSObject>
- (void)showDrawAlert:(NSString*)gameBoardState;
- (void)showPlayerWonAlert:(NSString*)playerName withGameBoardState:(NSString*)gameBoardState;
- (void)showOneMoreTimeViewController;
- (void)showAlreadySelectedAlertForCell:(TicTacToeCell*)cell;
- (void)updateUsernameLabel:(NSString*)currentPlayerUsername;
- (void)enableUndoButton;
- (void)disableUndoButton;
- (void)enableRedoButton;
- (void)disableRedoButton;
@end

#endif /* MobileUICollectionViewControllerDelegate_h */
