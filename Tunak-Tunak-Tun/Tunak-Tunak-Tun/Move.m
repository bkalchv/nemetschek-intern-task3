//
//  Move.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 6.01.22.
//

#import "Move.h"
#import "Board.h"
#import "Cell.h"
#import "Player.h"

@implementation Move
- (instancetype)initWithPlayer:(Player*)player withBoard:(Board*)board {
    self = [super init];
    if (self) {
        self.player = player;
        self.board = board;
    }
    return self;
}

-(BOOL) isValidMove {
    return ![self.board cellAt: [self.player intendedCellIndexPath]].isChecked;
}
@end
