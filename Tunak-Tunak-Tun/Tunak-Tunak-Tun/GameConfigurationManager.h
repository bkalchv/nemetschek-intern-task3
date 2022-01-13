//
//  GameConfiguration.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 22.12.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GameMode) {
    GameModeOnePlayer,
    GameModeTwoPlayers
};

typedef NS_ENUM(NSInteger, EnumUI) {
    EnumUIConsole,
    EnumUIMobile
};

@interface GameConfigurationManager : NSObject

+ (instancetype)sharedGameConfigurationManager;
- (void) changeToGameMode:(GameMode)gameMode;
- (void) changeToUI:(EnumUI)UI;
- (GameMode) gameMode;
- (EnumUI) UI;
- (NSString*) player1Username;
- (NSString*) player2Username;
- (void) addPlayer1Username:(NSString*)player1Username;
- (void) addPlayer2Username:(NSString*)player2Username;
- (void) resetPlayer1Name;
- (void) resetPlayer2Name;

@end

NS_ASSUME_NONNULL_END
