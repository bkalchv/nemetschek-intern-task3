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
    [board changeCellStateAtRowIndex:[self.lastSelectedCell indexAtPosition:0]  columnIndex:[self.lastSelectedCell indexAtPosition:1] withSign:self.sign];
}

-(void)setLastSelectedCell:(NSIndexPath *)lastSelectedCell {
    _lastSelectedCell = lastSelectedCell;
}
@end
