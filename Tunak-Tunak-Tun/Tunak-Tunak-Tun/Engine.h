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
@property (nonatomic, strong) Player* player1;
@property (nonatomic, strong) Player* player2;
@property (nonatomic) NSUInteger freeCellsAmount;
@property (nonatomic) BOOL hasFreeCells;
@property (nonatomic) BOOL isGameOver;

- (instancetype)init;
- (instancetype)initWithPlayersName:(NSString*)playersName;
- (void)printBoardState;
- (void)selectCellAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex byPlayer:(Player*)player;
- (void)selectCellAtIndexPath:(NSIndexPath*)indexPath byPlayer:(Player*)player;
- (void)CPUSelects; // not public, yo
- (BOOL)areWinningConditionsFulfilledForSelectionOfCell:(Cell*)cell withSign:(CellState)sign;
@end

NS_ASSUME_NONNULL_END
