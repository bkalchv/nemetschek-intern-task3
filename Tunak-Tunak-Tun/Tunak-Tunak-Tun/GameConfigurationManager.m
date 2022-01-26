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
@property (assign) Game                     game;
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
        self.game               = GameTicTacToe;
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

- (void) changeToGame:(Game)game {
    switch (game) {
        case GameTicTacToe:
            _game = GameTicTacToe;
            break;
        case GameTunakTunakTun:
            _game = GameTunakTunakTun;
            break;
    }
}

- (NSString*) currentGameAsString {
    switch (self.game) {
        case GameTicTacToe:
            return @"Tic-Tac-Toe";
            break;
        case GameTunakTunakTun:
            return @"Tunak-Tunak-Tun";
            break;
    }
}

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

- (void)resetPlayer1Name {
    _player1Username = nil;
}

-(void)resetPlayer2Name{
    _player2Username = nil;
}

@end
