//
//  Board.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Board.h"

@implementation Board
- (instancetype)initWithRows:(NSUInteger)rowsAmount {
    self = [super init];
    if (self) {
        // making sure it is nxn matrix
        
        self.numberOfRows = rowsAmount;
        self.numberOfColumns = rowsAmount;
        self.boardMatrix = [[NSMutableArray<NSMutableArray<Cell*>*> alloc] init];
        
        for (size_t r = 0; r < self.numberOfRows; ++r) {
            NSMutableArray<Cell*>* currentRow = [[NSMutableArray<Cell*> alloc] init];
            for (size_t c = 0; c < self.numberOfColumns; ++c) {
                [currentRow addObject: [[Cell alloc] initWithState:CellStateEmpty atRow:r atColumn:c]];
            }
            [self.boardMatrix addObject:currentRow];
        }
    }
    return self;
}

-(void)printRow:(NSUInteger)row {
    NSString* rowToPrint = [[[NSArray alloc] initWithArray: self.boardMatrix[row]] componentsJoinedByString:@"  "];
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
        NSString* rowToString = [self.boardMatrix[r] componentsJoinedByString:@"   "];
        if (r != self.numberOfRows - 1) rowToString = [NSString stringWithFormat:@"%@\n", rowToString];
        state = [state stringByAppendingString:rowToString];
    }
    return state;
}
@end
