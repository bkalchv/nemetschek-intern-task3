//
//  Board.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

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

-(Cell*)cellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)colIndex {
    return self.boardMatrixArray[rowIndex * self.numberOfColumns + colIndex];
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

-(NSString*)stateString {
    NSString* state = [[NSString alloc] init];
    for (NSUInteger r = 0; r < self.numberOfRows; ++r) {
        NSString* rowToString = [[self row:r] componentsJoinedByString:@"   "];
        if (r != self.numberOfRows - 1) rowToString = [NSString stringWithFormat:@"%@\n", rowToString];
        state = [state stringByAppendingString:rowToString];
    }
    return state;
}
@end
