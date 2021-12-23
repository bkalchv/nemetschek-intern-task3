//
//  Bot.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 23.12.21.
//

#import "Bot.h"
#import "Board.h"
#import "Cell.h"

@implementation Bot

-(instancetype)initWithSign:(CellState)sign {
    self = [super initPlayerWithName:@"CPU" withId:2 withSign:sign];
    return self;
}

-(NSUInteger)randomIndex:(NSUInteger)maxIndex {
    NSUInteger lowerBoundIndex = 0;
    NSUInteger upperBoundIndex = maxIndex;
    NSUInteger randomIndex = lowerBoundIndex + arc4random() % (upperBoundIndex - lowerBoundIndex + 1);
    return randomIndex;
}

//TODO: - use a separate collection for the free cells instead of recursice calls to random (calculated property
-(NSArray<Cell*> *)freeCellsOfBoard:(Board*)board {
    NSMutableArray<Cell*>* freeCellsArray = [[NSMutableArray<Cell*> alloc] init];
    for (Cell* cell in board.boardMatrixArray) {
        if (!cell.isChecked) [freeCellsArray addObject:cell];
    }
    return freeCellsArray;
}

-(Cell*)randomFreeCell:(Board*)board{
    NSArray<Cell*>* freeCells = [self freeCellsOfBoard:board];
    return [freeCells objectAtIndex: [self randomIndex:([freeCells count] - 1)] ];
}

-(Cell*)makeMoveOnBoard:(Board*)board {
    Cell* cellToSelect = [self randomFreeCell:board];
    [board changeCellStateAtRowIndex:cellToSelect.rowIndex columnIndex:cellToSelect.colIndex withSign: self.sign];
    return cellToSelect;
}

@end
