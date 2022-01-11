//
//  Board.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//
#import <UIKit/UIKit.h>
#import "Board.h"
#import "Cell.h"

@implementation Board
- (instancetype)initWithRows:(NSUInteger)rowsAmount {
    self = [super init];
    if (self) {
        // making sure it is nxn matrix
        
        self.numberOfRows = rowsAmount;
        self.numberOfColumns = rowsAmount;
        self.boardMatrixArray = [[NSMutableArray<Cell*> alloc] init];
        
        for (size_t r = 0; r < self.numberOfRows; ++r) {
            for (size_t c = 0; c < self.numberOfColumns; ++c) {
                [self.boardMatrixArray addObject: [[Cell alloc] initWithState:CellStateEmpty atRow:r atColumn:c]];
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

-(Cell*)cellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)colIndex {
    return self.boardMatrixArray[rowIndex * self.numberOfColumns + colIndex];
}

-(Cell*)cellAt:(NSIndexPath*)indexPath {
    return self.boardMatrixArray[[indexPath indexAtPosition: 0] * self.numberOfColumns + [indexPath indexAtPosition: 1]];
}

-(void)deselectCellAtIndexPath:(NSIndexPath*)indexPath {
    NSUInteger row = [indexPath section];
    NSUInteger col = [indexPath row];
    [self changeCellStateAtRowIndex:row columnIndex:col withSign:CellStateEmpty];
}

-(void)changeCellStateAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex withSign:(CellState)sign {
    [[self cellAtRowIndex:rowIndex columnIndex:columnIndex] setState:sign];
}

-(NSUInteger)calculateFreeCellsAmount {
    NSUInteger freeCellsAmount = 0;
    for (Cell* cell in self.boardMatrixArray) {
        if (![cell isChecked]) freeCellsAmount++;
    }
    return freeCellsAmount;
}

@end
