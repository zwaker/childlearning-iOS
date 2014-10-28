//  Colors.m
//  Babyschool
//  Created by User on 9/16/12.
//  Copyright (c) 2012 User. All rights reserved.

#import "Colors.h"
#import "AppDelegate.h"
#import "UIView-ModalAnimationHelper.h"

@interface Colors ()

@end

@implementation Colors


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    appDelegate.loopaudio=YES;
    self.navigationController.navigationBarHidden=YES;
    NSLog(@"View viewWillAppear.");
}

-(void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(viewbuttonclicked) withObject:nil afterDelay:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view.

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"View viewDidLoad.");
 
    
    UIImageView *bodyimage =[[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 480*appDelegate.xval, 320*appDelegate.yval)]autorelease];
    bodyimage.userInteractionEnabled=YES;
    bodyimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"colorbg.png"]];
    
    UIButton *homebutton = [[[UIButton alloc]
                             initWithFrame:CGRectMake(450*appDelegate.xval, 5*appDelegate.yval, 28*appDelegate.xval, 25*appDelegate.yval)]autorelease];
    homebutton.backgroundColor = [UIColor colorWithPatternImage:
                                  [UIImage imageNamed:@"homebutton.png"]];
    [homebutton setOpaque:YES];
    [bodyimage addSubview:homebutton];
    [homebutton addTarget:self action:@selector(homebuttonclicked)
         forControlEvents:UIControlEventTouchUpInside];
    
      
    pArr = [[NSMutableArray alloc] init];
    
    UIButton *red = [[[UIButton alloc]
                       initWithFrame:CGRectMake(38*appDelegate.xval,19*appDelegate.yval,50*appDelegate.xval,25*appDelegate.yval)]autorelease];
    red.backgroundColor = [UIColor colorWithPatternImage:
                            [UIImage imageNamed:@"red.png"]];
    red.tag=101;
    [red setOpaque:YES];
    [bodyimage addSubview:red];
    [pArr addObject:red];
    
    [red addTarget:self action:@selector(colorbuttonclicked:)
   forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *orange = [[[UIButton alloc]
                       initWithFrame:CGRectMake(160*appDelegate.xval,17*appDelegate.yval,100*appDelegate.xval,25*appDelegate.yval)]autorelease];
    orange.backgroundColor = [UIColor colorWithPatternImage:
                            [UIImage imageNamed:@"orange.png"]];
    orange.tag=102;
    [orange setOpaque:YES];
    [bodyimage addSubview:orange];
    [pArr addObject:orange];
    
    [orange addTarget:self action:@selector(colorbuttonclicked:)
   forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *yellow = [[[UIButton alloc]
                      initWithFrame:CGRectMake(25*appDelegate.xval,267*appDelegate.yval,100*appDelegate.xval,25*appDelegate.yval)]autorelease];
    yellow.backgroundColor = [UIColor colorWithPatternImage:
                           [UIImage imageNamed:@"yellow.png"]];
    yellow.tag=103;
    [yellow setOpaque:YES];
    [bodyimage addSubview:yellow];
    [pArr addObject:yellow];
    
    [yellow addTarget:self action:@selector(colorbuttonclicked:)
  forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *green = [[[UIButton alloc]
                       initWithFrame:CGRectMake(313*appDelegate.xval,20*appDelegate.yval,80*appDelegate.xval,25*appDelegate.yval)]autorelease];
    green.backgroundColor = [UIColor colorWithPatternImage:
                            [UIImage imageNamed:@"green.png"]];
    green.tag=104;
    [green setOpaque:YES];
    [bodyimage addSubview:green];
    [pArr addObject:green];
    
    [green addTarget:self action:@selector(colorbuttonclicked:)
   forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *blue = [[[UIButton alloc]
                      initWithFrame:CGRectMake(205*appDelegate.xval,185*appDelegate.yval,60*appDelegate.xval,25*appDelegate.yval)]autorelease];
    blue.backgroundColor = [UIColor colorWithPatternImage:
                           [UIImage imageNamed:@"blue.png"]];
    blue.tag=105;
    [blue setOpaque:YES];
    [bodyimage addSubview:blue];
    [pArr addObject:blue];
    
    [blue addTarget:self action:@selector(colorbuttonclicked:)
  forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *indigo = [[[UIButton alloc]
                      initWithFrame:CGRectMake(176*appDelegate.xval,265*appDelegate.yval,90*appDelegate.xval,25*appDelegate.yval)]autorelease];
    indigo.backgroundColor = [UIColor colorWithPatternImage:
                           [UIImage imageNamed:@"indigo.png"]];
    indigo.tag=106;
    [indigo setOpaque:YES];
    [bodyimage addSubview:indigo];
    [pArr addObject:indigo];
    
    [indigo addTarget:self action:@selector(colorbuttonclicked:)
  forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *violate = [[[UIButton alloc]
                      initWithFrame:CGRectMake(340*appDelegate.xval,267*appDelegate.yval,100*appDelegate.xval,25*appDelegate.yval)]autorelease];
    violate.backgroundColor = [UIColor colorWithPatternImage:
                           [UIImage imageNamed:@"violate.png"]];
    violate.tag=107;
    [violate setOpaque:YES];
    [bodyimage addSubview:violate];
    [pArr addObject:violate];
    
    [violate addTarget:self action:@selector(colorbuttonclicked:)
  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bodyimage];
    
}


-(void)homebuttonclicked
{
    appDelegate.loopaudio=NO;
    [self.navigationController popViewControllerAnimated:YES];
    [appDelegate.audioPlayer stop];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewbuttonclicked
{
    for (int j=0; j<7; j++)
    {
        if (appDelegate.loopaudio==YES) {
        NSString *str = [appDelegate.colorlist objectAtIndex:j];
        [appDelegate playAudio:str :@"mp3"];
  //      NSLog(@"%i  |  %@", j,str);
        UIButton *view=((UIButton *)[pArr objectAtIndex:j]);
        
        // Bounce to 115% of the normal size
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:.2f];
        view.transform = CGAffineTransformMakeScale(1.75f, 1.75f);
        [UIView commitModalAnimations];
        
        // Return back to 100%
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:.1f];
        view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        [UIView commitModalAnimations];
        //[UIView commitAnimations];
        [NSThread sleepForTimeInterval:0.75];
        }
       
    }
    
}

-(void)colorbuttonclicked: (UIButton *) tBtn
{
    
    
    int j=(tBtn.tag)-101;
    NSString *str = [appDelegate.colorlist objectAtIndex:j];
    [appDelegate playAudio:str :@"mp3"];
 //   NSLog(@"%i  |  %@", j,str);
    
    // Bounce to 115% of the normal size
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    tBtn.transform = CGAffineTransformMakeScale(1.75f, 1.75f);
    [UIView commitModalAnimations];
    
    // Return back to 100%
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.1f];
    tBtn.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitModalAnimations];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation ==UIInterfaceOrientationLandscapeRight);
}

@end
