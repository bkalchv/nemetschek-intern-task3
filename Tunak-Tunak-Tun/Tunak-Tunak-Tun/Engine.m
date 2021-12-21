//
//  Engine.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Engine.h"
#import "Cell.h"

@implementation Engine

-(instancetype) init {
    self = [super init];
    if (self) {
        self.gameBoard = [[Board alloc] initWithRows:3];
        self.freeCellsAmount = 9;
        self.hasFreeCells = YES;
        self.isGameOver = NO;
    }
    return self;
}

- (instancetype)initWithPlayersName:(NSString*)playersName {
    self = [self init];
    if (self) {
//        self.players =  [NSArray  arrayWithObjects: [[Player alloc] initPlayerWithName:@"CPU" withId:0 withSign:CellStateO], [[Player alloc] initPlayerWithName:playersName withId:1 withSign:CellStateX], nil];
        self.player1 = [[Player alloc] initPlayerWithName:playersName withId:1 withSign:CellStateX];
        self.player2 = [[Player alloc] initPlayerWithName:@"CPU" withId:1 withSign:CellStateO];
    }
    return self;
}

- (void)printBoardState {
    [self.gameBoard printState];
}

- (void)changeCellStateAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex toState:(CellState)state {
    [[self.gameBoard cellAtRowIndex:rowIndex columnIndex:columnIndex] setState:state];
}

- (void)changeCellStateAtIndex:(NSUInteger)index toState:(CellState)state {
    [[self.gameBoard.boardMatrixArray objectAtIndex:index] setState:state];
}

- (void)selectCellAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex byPlayer:(Player*)player {
    if (self.hasFreeCells) {
        [self changeCellStateAtRowIndex:rowIndex atColumnIndex:columnIndex toState:player.sign];
        Cell* selectedCell = [self.gameBoard cellAtRowIndex:rowIndex columnIndex:columnIndex];
        self.freeCellsAmount -= 1;
        self.hasFreeCells = (self.freeCellsAmount != 0);
        
        if ([self areWinningConditionsFulfilledForSelectionOfCell:selectedCell withSign:player.sign])
        {
            self.isGameOver = YES;
            NSLog(@"%@ won!", player.name);
            NSLog(@"Game over!");
            return;
        } else {
            NSLog(@"Player: %tu selected: %tu %tu", player.playerID, rowIndex, columnIndex);
        }
    } else {
        NSLog(@"No more free cells!");
    }

}

- (void)selectCellAtIndexPath:(NSIndexPath*)indexPath byPlayer:(Player *)player{
    if (self.hasFreeCells) {
        [self changeCellStateAtIndex:[indexPath indexAtPosition:1] toState: player.sign];
        Cell* selectedCell = [self cellAtIndex: [indexPath indexAtPosition:1]];
        self.freeCellsAmount -= 1;
        self.hasFreeCells = (self.freeCellsAmount != 0);
        if ([self areWinningConditionsFulfilledForSelectionOfCell:selectedCell withSign:player.sign])
        {
            self.isGameOver = YES;
            NSLog(@"%@ won!", player.name);
            NSLog(@"Game over!");
            return;
        } else {
            NSLog(@"Player: %tu selected: %tu %tu", player.playerID, selectedCell.rowIndex, selectedCell.colIndex);
        }
    } else {
        NSLog(@"No more free cells!");
    }
}

-(NSUInteger)randomIndex:(NSUInteger)maxIndex {
    NSUInteger lowerBoundIndex = 0;
    NSUInteger upperBoundIndex = maxIndex;
    NSUInteger randomIndex = lowerBoundIndex + arc4random() % (upperBoundIndex - lowerBoundIndex + 1);
    return randomIndex;
}

//TODO: - use a separate collection for the free cells instead of recursice calls to random (calculated property
-(NSArray<Cell*> *)freeCells {
    NSMutableArray<Cell*>* freeCellsArray = [[NSMutableArray<Cell*> alloc] init];
    for (Cell* cell in self.gameBoard.boardMatrixArray) {
        if (!cell.isChecked) [freeCellsArray addObject:cell];
    }
    return freeCellsArray;
}

-(Cell*)getRandomFreeCell{
    NSArray<Cell*>* freeCells = [self freeCells];
    return [freeCells objectAtIndex: [self randomIndex:([freeCells count] - 1)] ];
}

- (Cell*)CPUSelects {
    if (self.hasFreeCells) {
        Cell* CPUCellToSelect = [self getRandomFreeCell];
        [self selectCellAtRowIndex:CPUCellToSelect.rowIndex atColumnIndex:CPUCellToSelect.colIndex byPlayer:self.player2];
        return CPUCellToSelect;
    } else return nil;
}

- (BOOL)checkColumnForCellSelection:(Cell*)cell withSign:(CellState)sign {
    for (size_t i = 0; i < self.gameBoard.numberOfColumns; i++) {
        if ([self.gameBoard cellAtRowIndex:cell.rowIndex columnIndex:i].state != sign) break;
        if (i + 1 == self.gameBoard.numberOfColumns) return true;
    }
    return false;
}

-(BOOL)checkRowForCellSelection:(Cell*)cell withSign:(CellState)sign {
    for (size_t i = 0; i < self.gameBoard.numberOfRows; i++) {
        if ([self.gameBoard cellAtRowIndex:i columnIndex:cell.colIndex].state != sign) break;
        if (i + 1 == self.gameBoard.numberOfRows) return true;
    }
    return false;
}

-(BOOL)checkDiagonalForCellSelection:(Cell*)cell withSign:(CellState)sign {
    if(cell.rowIndex == cell.colIndex) {
        for(int i = 0; i < self.gameBoard.numberOfRows; i++) {
            if([self.gameBoard cellAtRowIndex:i columnIndex:i].state != sign) break;
            if(i + 1 == self.gameBoard.numberOfRows) return true;
        }
    }
    return false;
}

-(BOOL)checkAntiDiagonalForCellSelection:(Cell*)cell withSign:(CellState)sign {
    if(cell.rowIndex + cell.colIndex + 1 == self.gameBoard.numberOfRows) {
        for(int i = 0; i < self.gameBoard.numberOfRows; i++) {
            if([self.gameBoard cellAtRowIndex:i columnIndex:(self.gameBoard.numberOfRows - 1 - i)].state != sign) break;
            if(i + 1 == self.gameBoard.numberOfRows) return true;
        }
    }
    return false;
}

- (BOOL)areWinningConditionsFulfilledForSelectionOfCell:(Cell*)cell withSign:(CellState)sign {
    return [self checkColumnForCellSelection:cell withSign:sign] || [self checkRowForCellSelection:cell withSign:sign] || [self checkDiagonalForCellSelection:cell withSign:sign] || [self checkAntiDiagonalForCellSelection:cell withSign:sign];
}

- (Cell*)cellAtIndex:(NSUInteger)index {
    return [self.gameBoard cellAtIndex:index];
}

- (BOOL)checkAvailabilityOfCellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex {
    return [[[self gameBoard] cellAtRowIndex:rowIndex columnIndex:columnIndex] isChecked];
}


@end
