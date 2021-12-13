//
//  Engine.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Engine.h"

@implementation Engine

-(instancetype) init {
    self = [super init];
    if (self) {
        self.gameBoard = [[Board alloc] initWithRows:3];
        self.freeCellsAmount = 9;
        self.hasFreeCells = YES;
    }
    return self;
}

- (instancetype)initWithPlayersName:(NSString*)playersName {
    self = [self init];
    if (self) {
        self.players =  [NSArray  arrayWithObjects: [[Player alloc] initPlayerWithName:@"CPU" withId:0 withSign:CellStateO], [[Player alloc] initPlayerWithName:playersName withId:1 withSign:CellStateX], nil];
    }
    return self;
}

- (void)printBoardState {
    [self.gameBoard printState];
}

- (void)changeCellStateAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex toState:(CellState)state {
    [self.gameBoard.boardMatrix[rowIndex][columnIndex] setState:state];
    [self.gameBoard.boardMatrix[rowIndex][columnIndex] setIsChecked:YES];
}

- (void)selectCellAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex byPlayer:(Player*)player {
    if (self.hasFreeCells) {
        [self changeCellStateAtRowIndex:rowIndex atColumnIndex:columnIndex toState:player.sign];
        Cell* selectedCell = self.gameBoard.boardMatrix[rowIndex][columnIndex];
        [self.players[player.playerID].selectedCells addObject: selectedCell];
        self.freeCellsAmount -= 1;
        self.hasFreeCells = self.freeCellsAmount != 0;
        NSLog(@"Player: %tu selected: %tu %tu", player.playerID, rowIndex, columnIndex);
    } else {
        NSLog(@"No more free cells!");
    }

}

-(NSUInteger)getRandomRowIndex{
    NSUInteger lowerBoundIndex = 0;
    NSUInteger upperBoundIndex = self.gameBoard.numberOfRows - 1;
    NSUInteger randomRowIndex = lowerBoundIndex + arc4random() % (upperBoundIndex - lowerBoundIndex + 1);
    
    return randomRowIndex;
}

-(NSUInteger)getRandomColIndex{
    NSUInteger lowerBoundIndex = 0;
    NSUInteger upperBoundIndex = self.gameBoard.numberOfColumns - 1;
    NSUInteger randomColumnIndex = lowerBoundIndex + arc4random() % (upperBoundIndex - lowerBoundIndex + 1);
    
    return randomColumnIndex;
}

-(Cell*)getRandomFreeCell{
    Cell* currentCell = self.gameBoard.boardMatrix[[self getRandomRowIndex]][[self getRandomColIndex]];
    return (currentCell.isChecked) ? [self getRandomFreeCell] : currentCell;
}

- (void)CPUSelects {
    if (self.hasFreeCells) {
    Cell* CPUCellToSelect = [self getRandomFreeCell];
    [self selectCellAtRowIndex:CPUCellToSelect.rowIndex atColumnIndex:CPUCellToSelect.colIndex byPlayer:self.players[0]];
    }
    
}
@end
