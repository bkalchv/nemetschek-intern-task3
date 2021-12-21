//
//  Engine.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>
#import "Board.h"
#import "Player.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GameMode) {
    OnePlayerGameMode,
    TwoPlayersGameMode
};

@interface Engine : NSObject
@property (nonatomic, strong)       Board* gameBoard;
@property (nonatomic, strong)       Player* currentPlayer;
@property (nonatomic)               GameMode gameMode;
@property (nonatomic, strong)       Player* player1; // to be made private
@property (nonatomic, strong)       Player* player2; // to be made private
@property (nonatomic) NSUInteger    freeCellsAmount; // to be made private
@property (nonatomic) BOOL          hasFreeCells;
@property (nonatomic) BOOL          winningConditionsFulfiled;

- (instancetype)init;
- (instancetype)initWithPlayersName:(NSString*)playersName;
- (void)printBoardState;
- (void)selectCellAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex byPlayer:(Player*)player;
- (void)selectCellAtIndexPath:(NSIndexPath*)indexPath byPlayer:(Player*)player;
- (Cell*)CPUSelects; // not public, yo
- (Cell*)randomFreeCell;
- (BOOL)areWinningConditionsFulfilledForSelectionOfCell:(Cell*)cell withSign:(CellState)sign;
- (Cell*)cellAtIndex:(NSUInteger)index;

- (BOOL)checkAvailabilityOfCellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex;
- (BOOL)checkAvailabilityOfCellAtIndex:(NSUInteger)index;
- (NSString*)gameBoardState;
- (void)updateGameEngineStateOnPlayerSelectionOfCellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex;
- (void)updateGameEngineStateOnPlayerSelectionOfCellAtIndex:(NSUInteger)index;
- (void)switchCurrentPlayer;
- (BOOL)isGameOver;
@end

NS_ASSUME_NONNULL_END
