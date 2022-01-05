//
//  Bot.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 23.12.21.
//

#import "Bot.h"
#import "Board.h"
#import "Cell.h"
#import <UIKit/UIKit.h>

@implementation Bot

-(instancetype)initWithSign:(CellState)sign withBoard:(Board*)board {
    self = [super initPlayerWithName:@"CPU" withId:2 withSign:sign withBoard:board];
    return self;
}

-(NSUInteger)randomIndex:(NSUInteger)maxIndex {
    NSUInteger lowerBoundIndex = 0;
    NSUInteger upperBoundIndex = maxIndex;
    NSUInteger randomIndex = lowerBoundIndex + arc4random() % (upperBoundIndex - lowerBoundIndex + 1);
    return randomIndex;
}

//TODO: - use a separate collection for the free cells instead of recursice calls to random (calculated property
-(NSArray<Cell*> *)freeCellsOfBoard {
    NSMutableArray<Cell*>* freeCellsArray = [[NSMutableArray<Cell*> alloc] init];
    for (Cell* cell in self.board.boardMatrixArray) {
        if (!cell.isChecked) [freeCellsArray addObject:cell];
    }
    return freeCellsArray;
}

-(Cell*)randomFreeCell {
    NSArray<Cell*>* freeCells = [self freeCellsOfBoard];
    return [freeCells objectAtIndex: [self randomIndex:([freeCells count] - 1)] ];
}

-(void)makeMove {
    Cell* cellToSelect = [self randomFreeCell];
    NSIndexPath* indexPathOfSelectedCell = [NSIndexPath indexPathForRow:cellToSelect.colIndex inSection:cellToSelect.rowIndex];
    [self setLastSelectedCell: indexPathOfSelectedCell];
    [self.board changeCellStateAtRowIndex:cellToSelect.rowIndex columnIndex:cellToSelect.colIndex withSign: self.sign];
}

-(void)yourTurnBaby {
    [self makeMove];
}

@end
	
		
