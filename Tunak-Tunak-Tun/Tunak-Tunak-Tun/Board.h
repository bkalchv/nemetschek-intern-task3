//
//  Board.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Cell;
typedef NS_ENUM(NSInteger, CellState);

@interface Board : NSObject
@property (nonatomic, strong) NSMutableArray<Cell*>* boardMatrixArray;
@property (nonatomic) NSUInteger numberOfRows;
@property (nonatomic) NSUInteger numberOfColumns;
- (instancetype)initWithRows:(NSUInteger)rowsAmount;
- (void)printRow:(NSUInteger)row;
- (void)printState;
-(NSString*)stateString;
-(Cell*)cellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)colIndex;
-(Cell*)cellAtIndex:(NSUInteger)index;

-(void)changeCellStateAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex withSign:(CellState)sign;
-(void)changeCellStateAtIndex:(NSUInteger)index withSign:(CellState)sign;
@end

NS_ASSUME_NONNULL_END
