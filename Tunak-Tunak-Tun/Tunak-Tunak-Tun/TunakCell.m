//
//  TunakCell.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "TunakCell.h"

@implementation TunakCell
- (instancetype) initWithState:(TunakCellState)state {
    self = [super init];
    if (self) {
        if (state == TunakCellStateUnchecked) {
            self.isChecked = false;
        } else {
            self.isChecked = true;
            self.state = state;
        }
    }
    return self;
}
@end
