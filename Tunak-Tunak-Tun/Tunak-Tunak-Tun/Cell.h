//
//  Cell.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cell : NSObject
@property (nonatomic) NSUInteger rowIndex;
@property (nonatomic) NSUInteger colIndex;
- (instancetype)initAtRow:(NSUInteger)row atColumn:(NSUInteger)col;
- (BOOL)isChecked;
- (void)setState:(NSInteger)integerOfState;
- (NSInteger)stateInteger;
@end

NS_ASSUME_NONNULL_END
