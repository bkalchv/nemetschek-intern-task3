//
//  Engine.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>
#import "Board.h"
#import "Player.h"
#import "Bot.h"
#import "GameConfigurationManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface Engine : NSObject
@property (nonatomic, strong)       Board* gameBoard;
@property (nonatomic, strong)       Player* currentPlayer;
@property (nonatomic)               GameMode gameMode;
@property (nonatomic)               BOOL hasFreeCells;
@property (nonatomic)               BOOL winningConditionsFulfiled;

- (instancetype)init;
- (instancetype)initWithPlayersName:(NSString*)playersName;
- (instancetype)initWithPlayer1Name:(NSString*)player1Name player2Name:(NSString*)player2Name;
- (void)printBoardState;
- (void)selectCellAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex;
- (void)selectCellAtIndex:(NSUInteger)index;
//- (Cell*)CPUSelects; // not public, yo
- (Cell*)randomFreeCell;
- (BOOL)areWinningConditionsFulfilledForSelectionOfCell:(Cell*)cell withSign:(CellState)sign;
- (Cell*)cellAtIndex:(NSUInteger)index;

- (BOOL)isCellCheckedAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex;
- (BOOL)isCellCheckedAtIndex:(NSUInteger)index;
- (NSString*)gameBoardState;
- (void)updateGameEngineStateOnPlayerSelectionOfCellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex;
- (void)updateGameEngineStateOnPlayerSelectionOfCellAtIndex:(NSUInteger)index;
- (void)switchCurrentPlayer;
- (BOOL)isGameOver;
@end

NS_ASSUME_NONNULL_END
