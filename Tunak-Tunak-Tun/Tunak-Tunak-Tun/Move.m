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

@interface Move ()
@property (nonatomic, strong) Board *board;
@end

@implementation Move
- (instancetype)initWithIndexPath:(NSIndexPath*)indexPath withBoard:(Board*)board {
    self = [super init];
    if (self) {
        self.indexPath = indexPath;
        self.board = board;
    }
    return self;
}

-(BOOL)isValidMove {
    return ![self.board cellAt: self.indexPath].isChecked;
}

@end
