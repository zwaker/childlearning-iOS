//  AppDelegate.m
//  Babyschool
//  Created by User on 9/15/12.
//  Copyright (c) 2012 User. All rights reserved.

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate
@synthesize window = _window, audioPlayer,audioPlayerVolume,audioPlayerOne;
@synthesize itemlist;
@synthesize categorylist;
@synthesize nav;
@synthesize alphabet;
@synthesize animallist, birdlist, fishlist, flowerlist, colorlist, bodylist, numberlist;
@synthesize sound_animal,sound_bird,sound_itemlist;
@synthesize isAudioFinished, loopaudio;
@synthesize animalbg, birdbg, fishbg;
@synthesize viewController_iPad, viewController;
@synthesize xval,yval;

- (void)dealloc
{
    
    [_window release];
    [alphabet release];
    [nav release];
    [itemlist release];
    [categorylist release];
    [animallist release];
    [birdlist release];
    [fishlist release];
    [flowerlist release];
    [colorlist release];
    [bodylist release];
    [numberlist release];
    [sound_animal release];
    [sound_bird release];
    [sound_itemlist release];
    [audioPlayerOne release];
    [animalbg release];
    [birdbg release];
    [fishbg release];
    [super dealloc];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
   // [NSThread sleepForTimeInterval:5];
    
    //UserDefaults For getting category menu serially
    NSUserDefaults *uDef = [NSUserDefaults standardUserDefaults];
    
    if( ![uDef integerForKey:@"0"] )
    {
        [uDef setInteger:0 forKey:@"0"];
        [uDef setInteger:2 forKey:@"1"];
        [uDef setInteger:4 forKey:@"2"];
        [uDef setInteger:3 forKey:@"3"];
        [uDef setInteger:5 forKey:@"4"];
        [uDef setInteger:6 forKey:@"5"];
        [uDef setInteger:7 forKey:@"6"];
        [uDef setInteger:8 forKey:@"7"];
        [uDef setInteger:1 forKey:@"8"];
        [uDef setInteger:9 forKey:@"9"];
        
        [uDef synchronize];
    }
    
    //loopaudio helper variable to stop playing audio in color and humanbody category
    loopaudio=YES;
    
    self.itemlist=[[[NSMutableArray alloc]init]autorelease];
    [self.itemlist addObject:@"aligator"];
    [self.itemlist addObject:@"balloon"];
    [self.itemlist addObject:@"car"];
    [self.itemlist addObject:@"dragon"];
    [self.itemlist addObject:@"elephant"];
    [self.itemlist addObject:@"frog"];
    [self.itemlist addObject:@"goat"];
    [self.itemlist addObject:@"house"];
    [self.itemlist addObject:@"iceCream"];
    [self.itemlist addObject:@"jaguar"];
    [self.itemlist addObject:@"kite"];
    [self.itemlist addObject:@"lion2"];
    [self.itemlist addObject:@"mermaid"];
    [self.itemlist addObject:@"nine"];
    [self.itemlist addObject:@"octopus"];
    [self.itemlist addObject:@"plane"];
    [self.itemlist addObject:@"queen"];
    [self.itemlist addObject:@"rainbow"];
    [self.itemlist addObject:@"santa"];
    [self.itemlist addObject:@"truck"];
    [self.itemlist addObject:@"umbrella"];
    [self.itemlist addObject:@"violine"];
    [self.itemlist addObject:@"whale"];
    [self.itemlist addObject:@"xylophone"];
    [self.itemlist addObject:@"yoyo"];
    [self.itemlist addObject:@"zebra"];
    
    self.sound_itemlist=[[[NSMutableArray alloc]init]autorelease];
    [self.sound_itemlist addObject:@"itemsound_aligator"];
    [self.sound_itemlist addObject:@"sound_balloon"];
    [self.sound_itemlist addObject:@"itemsound_car"];
    [self.sound_itemlist addObject:@"itemsound_dragon"];
    [self.sound_itemlist addObject:@"itemsound_elephant"];
    [self.sound_itemlist addObject:@"itemsound_frog"];
    [self.sound_itemlist addObject:@"itemsound_goat"];
    [self.sound_itemlist addObject:@"sound_house"];
    [self.sound_itemlist addObject:@"sound_iceCream"];
    [self.sound_itemlist addObject:@"itemsound_jaguar"];
    [self.sound_itemlist addObject:@"sound_kite"];
    [self.sound_itemlist addObject:@"itemsound_lion"];
    [self.sound_itemlist addObject:@"sound_mermaid"];
    [self.sound_itemlist addObject:@"sound_nine"];
    [self.sound_itemlist addObject:@"sound_octopus"];
    [self.sound_itemlist addObject:@"itemsound_plane"];
    [self.sound_itemlist addObject:@"sound_queen"];
    [self.sound_itemlist addObject:@"sound_rainbow"];
    [self.sound_itemlist addObject:@"itemsound_santa"];
    [self.sound_itemlist addObject:@"itemsound_truck"];
    [self.sound_itemlist addObject:@"sound_umbrella"];
    [self.sound_itemlist addObject:@"itemsound_violine"];
    [self.sound_itemlist addObject:@"itemsound_whale"];
    [self.sound_itemlist addObject:@"itemsound_xylophone"];
    [self.sound_itemlist addObject:@"sound_yoyo"];
    [self.sound_itemlist addObject:@"itemsound_zebra"];
    
    
    self.categorylist=[[[NSMutableArray alloc]init]autorelease];
    [self.categorylist addObject:@"alphabet"];
    [self.categorylist addObject:@"number"];
    [self.categorylist addObject:@"alphabetwithitem"];
    [self.categorylist addObject:@"bird"];
    [self.categorylist addObject:@"animal"];
    [self.categorylist addObject:@"fish"];
    [self.categorylist addObject:@"flower"];
    [self.categorylist addObject:@"color"];
    [self.categorylist addObject:@"humanbody"];
    [self.categorylist addObject:@"video"];

    
    self.alphabet=[[[NSMutableArray alloc]init]autorelease];
    [self.alphabet addObject:@"a"];
     [self.alphabet addObject:@"b"];
     [self.alphabet addObject:@"c"];
     [self.alphabet addObject:@"d"];
     [self.alphabet addObject:@"e"];
     [self.alphabet addObject:@"f"];
     [self.alphabet addObject:@"g"];
     [self.alphabet addObject:@"h"];
     [self.alphabet addObject:@"i"];
     [self.alphabet addObject:@"j"];
     [self.alphabet addObject:@"k"];
     [self.alphabet addObject:@"l"];
     [self.alphabet addObject:@"m"];
     [self.alphabet addObject:@"n"];
     [self.alphabet addObject:@"o"];
     [self.alphabet addObject:@"p"];
     [self.alphabet addObject:@"q"];
     [self.alphabet addObject:@"r"];
     [self.alphabet addObject:@"s"];
     [self.alphabet addObject:@"t"];
     [self.alphabet addObject:@"u"];
     [self.alphabet addObject:@"v"];
     [self.alphabet addObject:@"w"];
     [self.alphabet addObject:@"x"];
     [self.alphabet addObject:@"y"];
     [self.alphabet addObject:@"z"];
   
    self.animallist=[[[NSMutableArray alloc]init]autorelease];
    [self.animallist addObject:@"bear"];
    [self.animallist addObject:@"cat"];
    [self.animallist addObject:@"cow"];
    [self.animallist addObject:@"dinosaur"];
    [self.animallist addObject:@"dog"];
    [self.animallist addObject:@"horse"];
    [self.animallist addObject:@"kangaroo"];
    [self.animallist addObject:@"monkey"];
    [self.animallist addObject:@"rabbit"];
    [self.animallist addObject:@"sheep"];
    [self.animallist addObject:@"tortoise"];
    [self.animallist addObject:@"ziraffe"];
    
    self.animalbg=[[[NSMutableArray alloc]init]autorelease];
    [self.animalbg addObject:@"ice.png"];
    [self.animalbg addObject:@"farm.png"];
    [self.animalbg addObject:@"farm.png"];
    [self.animalbg addObject:@"jungle.png"];
    [self.animalbg addObject:@"farm.png"];
    [self.animalbg addObject:@"farm.png"];
    [self.animalbg addObject:@"empty.png"];
    [self.animalbg addObject:@"jungle.png"];
    [self.animalbg addObject:@"farm.png"];
    [self.animalbg addObject:@"farm.png"];
    [self.animalbg addObject:@"empty.png"];
    [self.animalbg addObject:@"jungle.png"];
    
    self.sound_animal=[[[NSMutableArray alloc]init]autorelease];
    [self.sound_animal addObject:@"sound_bear"];
    [self.sound_animal addObject:@"sound_cat"];
    [self.sound_animal addObject:@"sound_cow"];
    [self.sound_animal addObject:@"sound_dinosaur"];
    [self.sound_animal addObject:@"sound_dog"];
    [self.sound_animal addObject:@"sound_horse"];
    [self.sound_animal addObject:@"kangaroo"];
    [self.sound_animal addObject:@"sound_monkey"];
    [self.sound_animal addObject:@"sound_rabbit"];
    [self.sound_animal addObject:@"sound_sheep"];
    [self.sound_animal addObject:@"sound_tortoise"];
    [self.sound_animal addObject:@"ziraffe"];

  
    self.birdlist=[[[NSMutableArray alloc]init]autorelease];
    [self.birdlist addObject:@"chicken"];
    [self.birdlist addObject:@"cockatoo"];
    [self.birdlist addObject:@"emu"];
    [self.birdlist addObject:@"humming bird"];
    [self.birdlist addObject:@"kiwi"];
    [self.birdlist addObject:@"magpie"];
    [self.birdlist addObject:@"owl"];
    [self.birdlist addObject:@"parrot"];
    [self.birdlist addObject:@"peacock"];
    [self.birdlist addObject:@"penguin"];
    
    self.sound_bird=[[[NSMutableArray alloc]init]autorelease];
    [self.sound_bird addObject:@"sound_chicken"];
    [self.sound_bird addObject:@"sound_cockatoo"];
    [self.sound_bird addObject:@"sound_emu"];
    [self.sound_bird addObject:@"sound_humming bird"];
    [self.sound_bird addObject:@"sound_kiwi"];
    [self.sound_bird addObject:@"sound_magpie"];
    [self.sound_bird addObject:@"sound_owl"];
    [self.sound_bird addObject:@"sound_parrot"];
    [self.sound_bird addObject:@"sound_peacock"];
    [self.sound_bird addObject:@"penguin"];
    
    self.birdbg=[[[NSMutableArray alloc]init]autorelease];
    [self.birdbg addObject:@"jungle.png"];
    [self.birdbg addObject:@"empty.png"];
    [self.birdbg addObject:@"empty.png"];
    [self.birdbg addObject:@"mountain.png"];
    [self.birdbg addObject:@"mountain.png"];
    [self.birdbg addObject:@"jungle.png"];
    [self.birdbg addObject:@"jungle.png"];
    [self.birdbg addObject:@"jungle.png"];
    [self.birdbg addObject:@"jungle.png"];
    [self.birdbg addObject:@"ice.png"];
  
    
    self.fishlist=[[[NSMutableArray alloc]init]autorelease];
    [self.fishlist addObject:@"angel fish"];
    [self.fishlist addObject:@"cray fish"];
    [self.fishlist addObject:@"dolphin"];
    [self.fishlist addObject:@"gold fish"];
    [self.fishlist addObject:@"jelly fish"];
    [self.fishlist addObject:@"puffer fish"];
    [self.fishlist addObject:@"sea horse"];
    [self.fishlist addObject:@"shark"];
    [self.fishlist addObject:@"star fish"];
    [self.fishlist addObject:@"stingray"];
    
    self.fishbg=[[[NSMutableArray alloc]init]autorelease];
    [self.fishbg addObject:@"seabed.png"];
    [self.fishbg addObject:@"beach.png"];
    [self.fishbg addObject:@"sea.png"];
    [self.fishbg addObject:@"seabed.png"];
    [self.fishbg addObject:@"beach.png"];
    [self.fishbg addObject:@"seabed.png"];
    [self.fishbg addObject:@"seabed.png"];
    [self.fishbg addObject:@"seabed.png"];
    [self.fishbg addObject:@"seabed.png"];
    [self.fishbg addObject:@"seabed.png"];


      
     self.flowerlist=[[[NSMutableArray alloc]init]autorelease];
     [self.flowerlist addObject:@"cherry blossom"];
     [self.flowerlist addObject:@"daffodil"];
     [self.flowerlist addObject:@"daisy"];
     [self.flowerlist addObject:@"lavender"];
     [self.flowerlist addObject:@"lily"];
     [self.flowerlist addObject:@"lotus"];
     [self.flowerlist addObject:@"orchid"];
     [self.flowerlist addObject:@"rose"];
     [self.flowerlist addObject:@"sunflower"];
     [self.flowerlist addObject:@"tulip"];
    
     
    self.colorlist=[[[NSMutableArray alloc]init]autorelease];
    [self.colorlist addObject:@"red"];
    [self.colorlist addObject:@"orange"];
    [self.colorlist addObject:@"yellow"];
    [self.colorlist addObject:@"green"];
    [self.colorlist addObject:@"blue"];
    [self.colorlist addObject:@"indigo"];
    [self.colorlist addObject:@"violate"];
    
    
    self.bodylist=[[[NSMutableArray alloc]init]autorelease];
    [self.bodylist addObject:@"head"];
    [self.bodylist addObject:@"nose"];
    [self.bodylist addObject:@"ear"];
    [self.bodylist addObject:@"hand"];
    [self.bodylist addObject:@"leg"];
    [self.bodylist addObject:@"eye"];
    [self.bodylist addObject:@"lip"];
    [self.bodylist addObject:@"neck"];
    [self.bodylist addObject:@"chest"];
    [self.bodylist addObject:@"belly"];
    [self.bodylist addObject:@"mouth"];
    [self.bodylist addObject:@"neck"];
    [self.bodylist addObject:@"nose"];
    [self.bodylist addObject:@"thigh"];
    [self.bodylist addObject:@"toe"];
    
    
    self.numberlist=[[[NSMutableArray alloc]init]autorelease];
    [self.numberlist addObject:@"1"];
    [self.numberlist addObject:@"2"];
    [self.numberlist addObject:@"3"];
    [self.numberlist addObject:@"4"];
    [self.numberlist addObject:@"5"];
    [self.numberlist addObject:@"6"];
    [self.numberlist addObject:@"7"];
    [self.numberlist addObject:@"8"];
    [self.numberlist addObject:@"9"];
    
    
    self.isAudioFinished=YES;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        self.xval=1;
        self.yval=1;
        
        viewController = [[[ViewController alloc] init] autorelease];
        }
    else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        
        //ipad setting goes here
        
        self.xval=2.133333;
        self.yval=2.4;
        viewController = [[[ViewController alloc] init] autorelease];
        }

    self.nav = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = self.nav;
    self.audioPlayerVolume = [NSNumber numberWithFloat:1.0f];
    self.yesOrNot = [NSNumber numberWithFloat:0.0f];
    [[UIApplication sharedApplication] setStatusBarHidden:YES  withAnimation:UIStatusBarAnimationNone ];
    [self.window makeKeyAndVisible];
    return YES;
}

//playing audio with a file type
-(void)playAudio:(NSString *)file:(NSString *)type
{
    
    self.isAudioFinished = NO;
    
    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:file withExtension:type];
    NSError *error;
    
    if (audioPlayer) {
        [audioPlayer release];
        audioPlayer = nil;
    }
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocationURL error:&error];
    [audioPlayer setNumberOfLoops:0];
    audioPlayer.delegate = self;
    
    if ([self.yesOrNot floatValue] == 1.0f) {
        audioPlayer.volume = [self.audioPlayerVolume floatValue];
    }
    
    else {
        audioPlayer.volume = 1.0f;
    }
    
        if (error) {
     //   NSLog(@"%@", [error localizedDescription]);
    }
    else {
        //Make sure the system follows our playback status
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        [audioPlayer play];
    }
}

//change the volume
-(void) playAudioOne:(float)volume{
    if (audioPlayerOne) {
        audioPlayerOne.volume = volume;
    }
}

//change the volume
-(void) playAudio:(float)volume{
    if (audioPlayer) {
        audioPlayer.volume = volume;
    }
    
}

//audio player finish playing
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"Finish..");
    self.isAudioFinished = YES;
}

//get one string and one integer value and return after adding
-(NSString *)audiostringFrom:(NSString *)from withValue:(int)value;
{
    NSString *audiostring=[[NSString alloc]initWithFormat:@"%@%i", from, value];
    return audiostring;
}

//get two string value and return after adding
-(NSString *)audiostringalphabet:(NSString *)from withValue:(NSString *)value;
{
    NSString *audiostring=[[NSString alloc]initWithFormat:@"%@%@", from, value];
    return audiostring;
}

//get string and a integer value and add .png and return it
-(NSString *)categorystring:(NSString *)from withValue:(int)value;
{
    NSString *categorystring=[[NSString alloc]initWithFormat:@"%@%i.png", from, value];
    return categorystring;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//get the message and title and show the alert
-(void)showAlert:(NSString*)message setTitle:(NSString*)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    
}


@end
