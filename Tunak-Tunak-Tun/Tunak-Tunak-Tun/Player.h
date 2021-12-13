//
//  Player.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject
@property NSUInteger playerID;
@property (nonatomic, strong) NSString* name;
-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)id;
@end

NS_ASSUME_NONNULL_END
