//
//  GameConfiguration.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 22.12.21.
//

#import "GameConfigurationManager.h"

@interface GameConfigurationManager ()

@property (assign) GameMode                 gameMode;
@property (assign) EnumUI                   UI;
@property (nonatomic, strong) NSString*     player1Username;
@property (nonatomic, strong) NSString*     player2Username;

@end

@implementation GameConfigurationManager

static GameConfigurationManager* sharedGameConfigurationManager;

+ (instancetype) sharedGameConfigurationManager {
    if (!sharedGameConfigurationManager) {
        sharedGameConfigurationManager = [[GameConfigurationManager alloc] init];
    }
    return sharedGameConfigurationManager;
}

-(instancetype)init {
    if (self = [super init]) {
        self.gameMode           = GameModeOnePlayer;
        self.UI                 = EnumUIConsole;
        self.player1Username    = nil;
        self.player1Username    = nil;
    }
    return self;
}

- (void) changeToGameMode:(GameMode)gameMode {
    switch (gameMode) {
        case GameModeOnePlayer:
            [self setGameMode:GameModeOnePlayer];
            break;
            
        case GameModeTwoPlayers:
            [self setGameMode:GameModeTwoPlayers];
            break;
            
        default:
            break;
    }
}

//-(GameMode) gameMode {
//    return [self gameMode];
//}

- (void) changeToUI:(EnumUI)UI {
    switch (UI) {
        case EnumUIConsole:
            [self setUI:EnumUIConsole];
            break;
        case EnumUIMobile:
            [self setUI:EnumUIMobile];
            break;
    }
}

//-(EnumUI) UI {
//    return [self UI];
//}

- (NSString*) player1Username {
    if (_player1Username == nil) return nil;
    return _player1Username;
}

- (NSString*) player2Username {
    if (_player1Username == nil) return nil;
    return _player2Username;
}


- (void) addPlayer1Username:(NSString*)player1Username {
    if ([self player1Username] == nil) {
        [self setPlayer1Username:[NSString stringWithString:player1Username]];
    } else NSLog(@"addPlayer1Username called more than once! Unexpected behavior for a singleton!");
}

- (void) addPlayer2Username:(NSString*)player2Username {
    if ([self player2Username] == nil) {
        [self setPlayer2Username:[NSString stringWithString:player2Username]];
    } else NSLog(@"addPlayer1Username called more than once! Unexpected behavior for a singleton!");

}



@end
