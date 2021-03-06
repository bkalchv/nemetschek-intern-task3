//
//  MovesStack.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 7.01.22.
//

#import "MovesStack.h"

@interface MovesStack ()
@property (nonatomic, strong) NSMutableArray<Move*>* moves;
@end

@implementation MovesStack

- (instancetype)init {
    if (self = [self initWithArray: [[NSMutableArray<Move*> alloc] init]]) {}
    return self;
}

- (instancetype)initWithArray:(NSArray<Move*>*)array {
    if ((self = [super init])) {
        _moves = [[NSMutableArray alloc] initWithArray:array];
        _count = 0;
    }
    return self;
}

- (void)pushMove:(Move*)move {
    if (move != nil) {
        [_moves addObject:move];
        _count = [_moves count];
    }
}

- (Move*)pop {
    if (_count > 0) {
        NSUInteger lastObjectIndex = [_moves count] - 1;
        Move* moveOnTop = [_moves objectAtIndex:lastObjectIndex];
        [_moves removeLastObject];
        _count = [_moves count];
        return moveOnTop;
    }
    
    return nil;
}

- (Move*)peek {
    if (_count > 0) {
        NSUInteger lastObjectIndex = [_moves count] - 1;
        Move* moveOnTop = [_moves objectAtIndex:lastObjectIndex];
        return moveOnTop;
    }
    
    return nil;
}

@end
