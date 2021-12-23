//
//  Player.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Player.h"
#import "Board.h"


@interface Player ()
@end

@implementation Player
-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerID withSign:(CellState)sign {
    self = [super init];
    if (self) {
        self.name = name;
        self.playerID = playerID;
        self.sign = sign;
    }
    return self;
}

-(void)makeMoveOnBoard:(Board*)board {
    [board changeCellStateAtRowIndex:self.lastCellSelectionRowIndex columnIndex:self.lastCellSelectionColIndex withSign:self.sign];
}

-(void)setLastCellSelectionRowIndex:(NSUInteger)rowIndex {
    _lastCellSelectionRowIndex = rowIndex;
}

-(void)setLastCellSelectionColIndex:(NSUInteger)colIndex {
    _lastCellSelectionColIndex = colIndex;
}

-(void)makeMoveOnBoard:(Board*)board atIndex:(NSUInteger)index {
    [board changeCellStateAtIndex:index withSign:self.sign];
}
@end
