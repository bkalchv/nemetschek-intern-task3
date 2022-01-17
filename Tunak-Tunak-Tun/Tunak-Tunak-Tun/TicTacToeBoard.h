//
//  TicTacToeBoard.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 17.01.22.
//

#import "Board.h"
#import "TicTacToeCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TicTacToeCellState);

@interface TicTacToeBoard : Board
@property (nonatomic, strong) NSMutableArray<TicTacToeCell*>* boardMatrixArray;
- (instancetype)initWithRows:(NSUInteger)rowsAmount;
- (void)printRow:(NSUInteger)row;
- (void)printState;
-(NSString*)stateAsString;
-(TicTacToeCell*)cellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)colIndex;
-(TicTacToeCell*)cellAt:(NSIndexPath*)indexPath;
-(void)changeCellStateAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex withSign:(TicTacToeCellState)sign;
-(NSUInteger)calculateFreeCellsAmount;
@end

NS_ASSUME_NONNULL_END
