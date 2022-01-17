//
//  TunakCell.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "TunakTunakTunCell.h"
#import "TunakTunakTunCellState.h"

@implementation TunakCell
- (instancetype) initWithState:(TunakTunakTunCellState)state atRow:(NSUInteger)row atColumn:(NSUInteger)col {
    self = [super initAtRow:row atColumn:col];
    if (self) {
        self.state = state;
    }
    return self;
}

- (NSString*)description {
    NSString* result;
    
    switch (self.state){
        case TunakCellStateGreen:
            result = @"g";
            break;
        case TunakCellStateRed:
            result = @"r";
            break;
        case TunakCellStateYellow:
            result = @"y";
            break;
        case TunakCellStateEmpty:
            result = @"-";
            break;
    }
    
    return result;
}

- (BOOL)isChecked {
    return self.state != TunakCellStateEmpty;
}
@end
