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

@interface Engine : NSObject
@property (nonatomic, strong) Board* gameBoard;
@property (nonatomic, strong) NSArray<Player*>* players;
@property (nonatomic) NSUInteger freeCellsAmount;
@property (nonatomic) BOOL hasFreeCells;
@property (nonatomic) BOOL isGameOver;
- (instancetype)init;
- (instancetype)initWithPlayersName:(NSString*)playersName;
- (void)printBoardState;
- (void)changeCellStateAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex toState:(CellState)state;
- (void)selectCellAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex byPlayer:(Player*)player;
- (void)CPUSelects;
- (Cell*)getCellAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex;
- (BOOL)areWinningConditionsFulfilledForSelectionOfCell:(Cell*)cell withSign:(CellState)sign;
@end

NS_ASSUME_NONNULL_END
