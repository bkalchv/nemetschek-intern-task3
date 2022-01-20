//
//  Engine.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>

@class TicTacToePlayer;
@class Move;
#import "Board.h"
#import "TicTacToeBoard.h"
#import "Bot.h"
#import "GameConfigurationManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EngineDelegate <NSObject>
//TODO: TicTacMove* -> Move*
- (void)checkGameOutcomeForMove:(Move*)move;
- (void)handleSelection:(NSIndexPath*)indexPath;
@end

@interface Engine : NSObject <BotDelegate>
@property (nonatomic, strong)       Board* gameBoard;
@property (nonatomic)               GameMode gameMode;
@property (nonatomic)               BOOL hasFreeCells;
@property (nonatomic)               BOOL winningConditionsFulfiled;
@property (nonatomic, strong)id     <EngineDelegate> delegate;

- (instancetype)init;
- (instancetype)initWithPlayersName:(NSString*)playersName;
- (instancetype)initWithPlayer1Name:(NSString*)player1Name player2Name:(NSString*)player2Name;
- (NSString*)gameBoardStateAsString;
- (void)printBoardState;
- (NSString*)currentPlayerName;
- (void)handleSelection:(NSIndexPath *)indexPath;
- (Move*)createMoveOfCurrentPlayer:(NSIndexPath*)indexPath;
- (Move*)createMoveOfCurrentPlayer:(NSIndexPath*)indexPath withSign:(NSString*)signAsString;
- (BOOL)didCurrentPlayerCreateValidMove:(Move*)move;
- (void)handleValidMove:(Move*)move;
- (void)switchCurrentPlayer;
- (void)switchCurrentPlayerWithYourTurnBabySideEffect;
- (BOOL)isGameOver;
- (BOOL)isUndoStackEmpty;
- (BOOL)isRedoStackEmpty;
- (void)undo;
- (void)redo;
- (void)emptyRedoStack;
- (NSInteger)calculateRowIndex:(NSInteger)index;
- (NSInteger)calculateColumnIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
