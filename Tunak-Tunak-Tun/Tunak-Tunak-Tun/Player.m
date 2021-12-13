//
//  Player.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Player.h"

@implementation Player
-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerID {
    self = [super init];
    if (self) {
        self.name = name;
        self.playerID = playerID;
    }
    return self;
}
@end
