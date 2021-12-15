//
//  Board.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

NS_ASSUME_NONNULL_BEGIN

@interface Board : NSObject
@property (nonatomic, strong) NSMutableArray<Cell*>* boardMatrixArray;
@property (nonatomic) NSUInteger numberOfRows;
@property (nonatomic) NSUInteger numberOfColumns;
- (instancetype)initWithRows:(NSUInteger)rowsAmount;
- (void)printRow:(NSUInteger)row;
- (void)printState;
-(NSString*)stateString;
-(Cell*)cellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)colIndex;
@end

NS_ASSUME_NONNULL_END
