//
//  TunakCell.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TunakTunakTunCellState);

@interface TunakCell : Cell
@property (nonatomic) TunakTunakTunCellState state;
- (instancetype)initWithState:(TunakTunakTunCellState)state atRow:(NSUInteger)row atColumn:(NSUInteger)col;
- (NSString*)description;
- (BOOL)isChecked;
@end

NS_ASSUME_NONNULL_END
