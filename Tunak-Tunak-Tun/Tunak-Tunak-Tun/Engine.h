//
//  Engine.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>

@class Player;
#import "Board.h"
#import "Bot.h"
#import "GameConfigurationManager.h"

// TODO: fwd declaration?

NS_ASSUME_NONNULL_BEGIN

@protocol EngineDelegate <NSObject>
- (void)checkGameOutcome;
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
- (void)printBoardState;
- (NSString*)gameBoardState;
- (BOOL)isCellChecked:(NSIndexPath*)indexPath;
- (NSString*)currentPlayerName;
- (NSIndexPath*)currentPlayerIntendedCellIndexPath;
- (void)setCurrentPlayerIntendedCellIndexPath:(NSIndexPath*)indexPath;
- (Move*)makeIntendedMoveOfCurrentPlayer;
- (BOOL)didCurrentPlayerMakeValidMove:(Move*)move;
- (void)handleSelection:(NSIndexPath *)indexPath;
- (void)handleValidMove:(Move*)move;
- (void)switchCurrentPlayer;
- (BOOL)isGameOver;

- (BOOL)isUndoStackEmpty;

- (NSInteger)calculateRowIndex:(NSInteger)index;
- (NSInteger)calculateColumnIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
