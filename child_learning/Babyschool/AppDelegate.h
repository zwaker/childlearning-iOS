//  AppDelegate.h
//  Babyschool
//  Created by User on 9/15/12.
//  Copyright (c) 2012 User. All rights reserved.

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"

@class ViewController;
@class ViewController_iPad;
@class Tabbarcontroller;

@interface AppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *nav;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) ViewController_iPad *viewController_iPad;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer, *audioPlayerOne;
@property (strong, nonatomic) NSNumber *audioPlayerVolume,*yesOrNot;

@property (retain, nonatomic) NSMutableArray *itemlist;
@property (retain, nonatomic) NSMutableArray *categorylist;
@property (retain, nonatomic) NSMutableArray *alphabet;
@property (retain, nonatomic) NSMutableArray *animallist, *birdlist, *fishlist, *flowerlist, *colorlist, *bodylist, *numberlist;
@property (retain, nonatomic) NSMutableArray *sound_animal, *sound_bird, *sound_itemlist;

@property (retain, nonatomic) NSMutableArray *animalbg, *birdbg, *fishbg;
@property BOOL isAudioFinished;
@property BOOL loopaudio;
@property float xval,yval;

-(void)playAudio:(NSString *)file:(NSString *)type;
-(void)playAudio:(float)volume;
-(void) playAudioOne:(float)volume;
-(NSString *)audiostringFrom:(NSString *)from withValue:(int)value;
-(NSString *)categorystring:(NSString *)from withValue:(int)value;
-(NSString *)audiostringalphabet:(NSString *)from withValue:(NSString *)value;
-(void)showAlert:(NSString*)message setTitle:(NSString*)title;

@end
