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
        self.boardMatrix = [[NSMutableArray<NSMutableArray<TunakCell*>*> alloc] init];
        
        for (size_t r = 0; r < self.numberOfRows; ++r) {
            NSMutableArray<TunakCell*>* currentRow = [[NSMutableArray<TunakCell*> alloc] init];
            for (size_t c = 0; c < self.numberOfColumns; ++c) {
                [currentRow addObject: [[TunakCell alloc] initWithState:TunakCellStateUnchecked]];
            }
            [self.boardMatrix addObject:currentRow];
        }
    }
    return self;
}

-(void)printRow:(NSUInteger)row {
    NSString* rowToPrint = [NSString stringWithFormat:@"%@ %@ %@", self.boardMatrix[row][0], self.boardMatrix[row][1], self.boardMatrix[row][2]];
    NSLog(@"%@", rowToPrint);
}

-(void)printState {
    for (NSUInteger r = 0 ; r < self.numberOfRows; ++r) {
        [self printRow: r];
        NSLog(@"\n");
    }
}
@end
