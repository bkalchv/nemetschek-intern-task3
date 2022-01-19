//
//  TicTacToeBoard.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 17.01.22.
//

#import "TicTacToeBoard.h"
#import "TicTacToeCell.h"
#import "TicTacToeCellState.h"

@implementation TicTacToeBoard
- (instancetype)initWithRows:(NSUInteger)rowsAmount {
    self = [super init];
    if (self) {
        // making sure it is nxn matrix
        
        self.numberOfRows = rowsAmount;
        self.numberOfColumns = rowsAmount;
        self.boardMatrixArray = [[NSMutableArray<TicTacToeCell*> alloc] init];
        
        for (size_t r = 0; r < self.numberOfRows; ++r) {
            for (size_t c = 0; c < self.numberOfColumns; ++c) {
                [self.boardMatrixArray addObject: [[TicTacToeCell alloc] initWithState:TicTacToeCellStateEmpty atRow:r atColumn:c]];
            }
        }
    }
    return self;
}

-(NSArray<Cell*>*)row:(NSUInteger)rowIndex {
    NSMutableArray<Cell*>* rowArray = [[NSMutableArray<Cell*> alloc] init];
    for (NSUInteger columnIndex = 0; columnIndex < self.numberOfColumns; ++columnIndex) {
        [rowArray addObject: [self cellAtRowIndex:rowIndex columnIndex:columnIndex]];
    }
    return rowArray;
}

-(void)printRow:(NSUInteger)rowIndex {
    NSString* rowToPrint = [[self row:rowIndex] componentsJoinedByString:@"  "];
    NSLog(@"%@", rowToPrint);
}

-(void)printState {
    for (NSUInteger r = 0 ; r < self.numberOfRows; ++r) {
        [self printRow: r];
        NSLog(@"\n");
    }
}

-(NSString*)stateAsString {
    NSString* state = [[NSString alloc] init];
    for (NSUInteger r = 0; r < self.numberOfRows; ++r) {
        NSString* rowToString = [[self row:r] componentsJoinedByString:@"   "];
        if (r != self.numberOfRows - 1) rowToString = [NSString stringWithFormat:@"%@\n", rowToString];
        state = [state stringByAppendingString:rowToString];
    }
    return state;
}

-(TicTacToeCell*)cellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)colIndex {
    return self.boardMatrixArray[rowIndex * self.numberOfColumns + colIndex];
}

-(TicTacToeCell*)cellAt:(NSIndexPath*)indexPath {
    return self.boardMatrixArray[[indexPath indexAtPosition: 0] * self.numberOfColumns + [indexPath indexAtPosition: 1]];
}

-(void)changeCellStateAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex withSign:(TicTacToeCellState)sign {
    [[self cellAtRowIndex:rowIndex columnIndex:columnIndex] setState:sign];
}

-(NSUInteger)calculateFreeCellsAmount {
    NSUInteger freeCellsAmount = 0;
    for (TicTacToeCell* cell in self.boardMatrixArray) {
        if (![cell isChecked]) freeCellsAmount++;
    }
    return freeCellsAmount;
}
@end
