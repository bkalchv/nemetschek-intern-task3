//
//  TunakCell.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TunakCellState) {
    TunakCellStateGreen,
    TunakCellStateRed,
    TunakCellStateYellow,
    TunakCellStateUnchecked
};

@interface TunakCell : NSObject
@property (nonatomic) TunakCellState state;
@property Boolean isChecked;
- (instancetype)initWithState:(TunakCellState) state;
@end

NS_ASSUME_NONNULL_END