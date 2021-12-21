//
//  Player.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Player.h"
#import "Board.h"

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

-(void)makeMoveOnBoard:(Board*)board atRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex {
    [board changeCellStateAtRowIndex:rowIndex columnIndex:columnIndex withSign:self.sign];
}


-(void)makeMoveOnBoard:(Board*)board atIndex:(NSUInteger)index {
    [board changeCellStateAtIndex:index withSign:self.sign];
}
@end
