//  ViewController.m
//  Babyschool
//  Created by User on 9/15/12.
//  Copyright (c) 2012 User. All rights reserved.

#import "ViewController.h"
#import "Alphabets.h"
#import "Numbers.h"
#import "AlphabetsWithItem.h"
#import "Birds.h"
#import "Animals.h"
#import "Fishes.h"
#import "Flowers.h"
#import "Colors.h"
#import "HumanBody.h"
#import "Video.h"
#import "MBProgressHUD.h"
#import "QuartzCore/QuartzCore.h"
#import "AppDelegate.h"
#import "MKStoreManager.h"



@interface ViewController ()

@end

@implementation ViewController
@synthesize btn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
      
    }
    return self;
}

-(void)dealloc
{
    [appdelegate release];
    [super dealloc];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (sv != nil)
    {
        [sv removeFromSuperview];
    }
    
        //horizontal scroll view
        sv = [[UIScrollView alloc] initWithFrame:CGRectMake(125*appdelegate.xval, 55*appdelegate.yval, 249*appdelegate.xval, 292*appdelegate.yval)];
        sv.pagingEnabled = YES;
        sv.clipsToBounds = NO;
        sv.showsHorizontalScrollIndicator = NO;
        sv.delegate = self;
        [self.view addSubview:sv];
    
       [self.navigationController setNavigationBarHidden:YES];
      NSUserDefaults *uDef = [NSUserDefaults standardUserDefaults];
     
    //add ten category from userdefault
    int kk, contentOffset = 0;
    for (kk=0; kk<10; kk++)
    {
		CGRect btnFrame = CGRectMake(contentOffset, 0.0f*appdelegate.yval, 229*appdelegate.xval, 220*appdelegate.yval);
        btn = [[[UIButton alloc] initWithFrame:btnFrame] autorelease];
        btn.tag = 100+[uDef integerForKey:[NSString stringWithFormat:@"%i", kk]];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        NSString *str = [appdelegate categorystring:CATEGORY withValue:[uDef integerForKey:[NSString stringWithFormat:@"%i", kk]]];
        btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
        
        //checking, if unlocked then show, else show alert
        
        switch (btn.tag) {
                
            case 101:
                
            {
                
                if([MKStoreManager isFeaturePurchased:kFeatureAId1])
                {
                    //unlock image if paided
                    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
                }
                else {
                    
                    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lockednumber.png"]];
                    
                }
            }
                break;
                
                
            case 102:
                
            {
                
                if([MKStoreManager isFeaturePurchased:kFeatureAId2])
                {
                    //unlock image if paided
                    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
                }
                else {
                    
                    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lockedalphabetwithitem.png"]];
                    
                }
            }
                break;
                
                
            case 103:
            {
                if([MKStoreManager isFeaturePurchased:kFeatureAId4])
                {
                    //unlock image if paided
                    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
                }
                else {
                    
                    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lockedbird.png"]];
                    
                }
            }
                break;
                
            case 104:
            {
                if([MKStoreManager isFeaturePurchased:kFeatureAId3])
                {
                    //unlock image if paided
                    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
                }
                else {
                    
                    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lockedanimal.png"]];
                    
                }
            }
                break;
                
            case 105:
            {
                if([MKStoreManager isFeaturePurchased:kFeatureAId5])
                {
                    //unlock image if paided
                    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
                }
                else {
                    
                    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lockedfish.png"]];
                    
                }
                break;
                
            case 106:
                {
                    if([MKStoreManager isFeaturePurchased:kFeatureAId6])
                    {
                        //unlock image if paided
                        btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
                    }
                    else {
                        
                        btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lockedflower.png"]];
                        
                    }
                }
                break;
                
                
            default:
                break;
            }
        }
        
        

        
        //make a black glow around the category menu
        CALayer *myLayer = btn.layer;
        myLayer.borderColor = [UIColor blackColor].CGColor;
        myLayer.masksToBounds=NO;
        myLayer.shadowOffset = CGSizeMake(0, 3);
        myLayer.shadowRadius = 5.0;
        myLayer.shadowColor = [UIColor blackColor].CGColor;
        myLayer.shadowOpacity = 0.5;

        contentOffset += btn.frame.size.width + (20*appdelegate.xval);
		sv.contentSize = CGSizeMake(contentOffset+(120*appdelegate.xval), sv.frame.size.height);
        
        [btn setOpaque:YES];
        
        [sv addSubview:btn];
    }
    //return back from a category it will navigate the current category
    [sv scrollRectToVisible:CGRectMake((((scSl*229)+(20*scSl)+20))*appdelegate.xval, 0*appdelegate.yval, 229*appdelegate.xval, 220*appdelegate.yval) animated:YES];
    
    pagecontrol = [[UIPageControl alloc] init];
	pagecontrol.numberOfPages = 10;
	pagecontrol.currentPage = 0;
	[pagecontrol addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    
    //recognize swipe outside the scrollview frame
    UISwipeGestureRecognizer* swipeUpGestureRecognizerleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeleftFrom:)];
    swipeUpGestureRecognizerleft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeUpGestureRecognizerleft];
    
    UISwipeGestureRecognizer* swipeUpGestureRecognizerright = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwiperightFrom:)];
    swipeUpGestureRecognizerright.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeUpGestureRecognizerright];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    appdelegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    scSl = 0; //initial position of the scrollview
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homebg.png"]];
//   backgroundView.autoresizingMask = (UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth);
      [[self view] addSubview:backgroundView];
    
   }

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
}


-(void) btnAction: (UIButton *) tBtn
{
    //an externam framework for activity indicator to load the category
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Please Wait...";
    hud.detailsLabelText = @"The application is loading informations";
   
    int ll = tBtn.tag;
    switch (ll) {
        case 100:
            
        {
            Alphabets *alphabets=[[[Alphabets alloc]init]autorelease];
            [self.navigationController pushViewController:alphabets animated:YES];
        }
            break;
            
        case 101:
        {
            if([MKStoreManager isFeaturePurchased:kFeatureAId1])
            {
            Numbers *numbers=[[Numbers alloc]init];
            [self.navigationController pushViewController:numbers animated:YES];
            }
            else   {
                //Initiate shoping
                [[MKStoreManager sharedManager]
                 buyFeature:kFeatureAId1
                 onComplete:^(NSString* purchasedFeature, NSData*purchasedReceipt, NSArray* availableDownloads)
                 {
                     NSLog(@"Purchased: %@", purchasedFeature);
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"Your item was successfully purchased"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                     
                     Numbers *numbers=[[Numbers alloc]init];
                     [self.navigationController pushViewController:numbers animated:YES];
                 }
                 onCancelled:^
                 { //Negative issue
                     NSLog(@"User Cancelled Transaction");
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"Your purchase was cancelled"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                 }
                 ];
            }

        }
            break;
            
        case 102:
        {
            if([MKStoreManager isFeaturePurchased:kFeatureAId2])
            {
                //unlock it
                AlphabetsWithItem *alphabetwithitem=[[AlphabetsWithItem alloc]init];
                [self.navigationController pushViewController:alphabetwithitem animated:YES];}
            else   {
                //Initiate shoping
                [[MKStoreManager sharedManager]
                 buyFeature:kFeatureAId2
                 onComplete:^(NSString* purchasedFeature, NSData*purchasedReceipt, NSArray* availableDownloads)
                 {
                     NSLog(@"Purchased: %@", purchasedFeature);
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"Your item was successfully purchased"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                     
                     AlphabetsWithItem *alphabetwithitem=[[AlphabetsWithItem alloc]init];
                     [self.navigationController pushViewController:alphabetwithitem animated:YES];
                 }
                 onCancelled:^
                 { //Negative issue
                     NSLog(@"User Cancelled Transaction");
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"Your purchase was cancelled"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                 }
                 ];
            }
        }
            break;
            
            
            
        case 103:
        {
            if([MKStoreManager isFeaturePurchased:kFeatureAId4])
            {
                //unlock it
                Birds *birds=[[Birds alloc]init];
                [self.navigationController pushViewController:birds animated:YES];}
            else   {
                //Initiate shoping
                [[MKStoreManager sharedManager]
                 buyFeature:kFeatureAId4
                 onComplete:^(NSString* purchasedFeature, NSData*purchasedReceipt, NSArray* availableDownloads)
                 {
                     NSLog(@"Purchased: %@", purchasedFeature);
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"Your item was successfully purchased"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                     Birds *birds=[[Birds alloc]init];
                     [self.navigationController pushViewController:birds animated:YES];
                 }
                 onCancelled:^
                 { //Negative issue
                     NSLog(@"User Cancelled Transaction");
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"Your purchase was cancelled"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                 }
                 ];
            }
        }
            break;
            
            
            
        case 104:
        {
            if([MKStoreManager isFeaturePurchased:kFeatureAId3])
            {
                //unlock it
                Animals *animal=[[Animals alloc]init];
                [self.navigationController pushViewController:animal animated:YES];
            }
            else {
                [[MKStoreManager sharedManager]
                 buyFeature:kFeatureAId3
                 onComplete:^(NSString* purchasedFeature, NSData*purchasedReceipt, NSArray* availableDownloads)
                 {
                     NSLog(@"Purchased: %@", purchasedFeature);
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"Your item was successfully purchased"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                     Animals *animal=[[Animals alloc]init];
                     [self.navigationController pushViewController:animal animated:YES];
                 }
                 onCancelled:^
                 {
                     NSLog(@"User Cancelled Transaction");
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"Your purchase was cancelled"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                 }
                 ];
                
            }}
            break;
            
            
        case 105:
            
        {  if([MKStoreManager isFeaturePurchased:kFeatureAId5])
            
        {  //unlock it
            Fishes *fishes=[[Fishes alloc]init];
            [self.navigationController pushViewController:fishes animated:YES];
        }
        else      {
            
            [[MKStoreManager sharedManager]
             buyFeature:kFeatureAId5
             onComplete:^(NSString* purchasedFeature, NSData*purchasedReceipt, NSArray* availableDownloads)
             {
                 NSLog(@"Purchased: %@", purchasedFeature);
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                 message:@"Your item was successfully purchased"
                                                                delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 [alert release];
                 Fishes *fishes=[[Fishes alloc]init];
                 [self.navigationController pushViewController:fishes animated:YES];
             }
             onCancelled:^
             {
                 NSLog(@"User Cancelled Transaction");
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                 message:@"Your purchase was cancelled"
                                                                delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 [alert release];
             }
             ];
        }}
            break;
            
            
            
            
        case 106:
        {
            if([MKStoreManager isFeaturePurchased:kFeatureAId6])
                
            {  //unlock it
                
                Flowers *flowers=[[Flowers alloc]init];
                [self.navigationController pushViewController:flowers animated:YES];            }
            else      {
                [[MKStoreManager sharedManager]
                 buyFeature:kFeatureAId6
                 onComplete:^(NSString* purchasedFeature, NSData*purchasedReceipt, NSArray* availableDownloads)
                 {
                     NSLog(@"Purchased: %@", purchasedFeature);
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"Your item was successfully purchased"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                     Flowers *flowers=[[Flowers alloc]init];
                     [self.navigationController pushViewController:flowers animated:YES];
                 }
                 onCancelled:^
                 {
                     NSLog(@"User Cancelled Transaction");
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                     message:@"Your purchase was cancelled"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                 }
                 ];
                
                
            }
        }
            break;
            
            
            
        case 107:
        {
            Colors *colors=[[Colors alloc]init];
            [self.navigationController pushViewController:colors animated:YES];
        }
            break;
            
        case 108:
        {
            HumanBody *humanbody=[[HumanBody alloc]init];
            [self.navigationController pushViewController:humanbody animated:YES];
        }
            break;
            
        case 109:
        {
            Video *video=[[Video alloc]init];
            [self.navigationController pushViewController:video animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
    NSUserDefaults *uDef = [NSUserDefaults standardUserDefaults];
    
    int val = ll-100;
    for (int kk=0; kk<10; kk++)
    {
        NSString *lKey = [NSString stringWithFormat:@"%i", kk];
        if ([uDef integerForKey:lKey]==val)
        {
            scSl = kk;
           // NSLog(@">>>>>>>>>>>>>>>%d",scSl);
        }
    }
        
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void) pageTurn: (UIPageControl *) aPageControl
{
   // NSLog(@"Page turn--> %i", aPageControl.currentPage);
    whichpage = aPageControl.currentPage;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	sv.contentOffset = CGPointMake(249.0f * whichpage*appdelegate.xval, 0.0f);
	[UIView commitAnimations];
}

- (void)handleSwipeleftFrom:(UIGestureRecognizer*)recognizer
{
    
  //  NSLog(@"swipe left recognized");
    [sv scrollRectToVisible:CGRectMake((sv.contentOffset.x+269*appdelegate.xval), 0*appdelegate.yval, 229*appdelegate.xval, 220*appdelegate.yval) animated:YES];
    
}

- (void)handleSwiperightFrom:(UIGestureRecognizer*)recognizer
{
    
   // NSLog(@"swipe right recognized");
    [sv scrollRectToVisible:CGRectMake(((sv.contentOffset.x-249*appdelegate.xval)), 0*appdelegate.yval, 229*appdelegate.xval, 220*appdelegate.yval) animated:YES];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft|| interfaceOrientation ==UIInterfaceOrientationLandscapeRight);
   
}

@end
