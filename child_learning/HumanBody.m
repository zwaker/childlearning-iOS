//  HumanBody.m
//  Babyschool
//  Created by User on 9/16/12.
//  Copyright (c) 2012 User. All rights reserved.

#import "HumanBody.h"
#import "AppDelegate.h"
#import "UIView-ModalAnimationHelper.h"

@interface HumanBody ()

@end

@implementation HumanBody


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
 //    NSLog(@"View viewWillAppear.");
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
 //   NSLog(@"View viewDidLoad.");
    UIImageView *backgroundView =[[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 480*appDelegate.xval, 320*appDelegate.yval)]autorelease];
    backgroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"flowerbg.png"]];
    backgroundView.userInteractionEnabled=YES;
    
    UIImageView *bodyimage =[[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 480*appDelegate.xval, 320*appDelegate.yval)]autorelease];
    bodyimage.userInteractionEnabled=YES;
    bodyimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"body.png"]];
    
    UIButton *homebutton = [[[UIButton alloc]
                             initWithFrame:CGRectMake(450*appDelegate.xval, 5*appDelegate.yval, 28*appDelegate.xval, 25*appDelegate.yval)]autorelease];
    homebutton.backgroundColor = [UIColor colorWithPatternImage:
                                  [UIImage imageNamed:@"homebutton.png"]];
    [homebutton setOpaque:YES];
    [bodyimage addSubview:homebutton];
    [homebutton addTarget:self action:@selector(homebuttonclicked)
         forControlEvents:UIControlEventTouchUpInside];
    
     pArr = [[NSMutableArray alloc] init];
    
    UIButton *head = [[[UIButton alloc]
                       initWithFrame:CGRectMake(100*appDelegate.xval,23*appDelegate.yval,95*appDelegate.xval,10*appDelegate.yval)]autorelease];
    head.backgroundColor = [UIColor colorWithPatternImage:
                            [UIImage imageNamed:@"head.png"]];
    head.tag=101;
    [head setOpaque:YES];
    [bodyimage addSubview:head];
    [pArr addObject:head];
    
    [head addTarget:self action:@selector(partsbuttonclicked:)
            forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nose = [[[UIButton alloc]
                       initWithFrame:CGRectMake(116*appDelegate.xval,78*appDelegate.yval,124*appDelegate.xval,10*appDelegate.yval)]autorelease];
    nose.backgroundColor = [UIColor colorWithPatternImage:
                            [UIImage imageNamed:@"nose.png"]];
    nose.tag=102;
    [nose setOpaque:YES];
    [bodyimage addSubview:nose];
    [pArr addObject:nose];
    
    [nose addTarget:self action:@selector(partsbuttonclicked:)
   forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ear = [[[UIButton alloc]
                       initWithFrame:CGRectMake(118*appDelegate.xval,90*appDelegate.yval,68*appDelegate.xval,22*appDelegate.yval)]autorelease];
    ear.backgroundColor = [UIColor colorWithPatternImage:
                            [UIImage imageNamed:@"ear.png"]];
    ear.tag=103;
    [ear setOpaque:YES];
    [bodyimage addSubview:ear];
    [pArr addObject:ear];
    
    [ear addTarget:self action:@selector(partsbuttonclicked:)
   forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *hand = [[[UIButton alloc]
                      initWithFrame:CGRectMake(95*appDelegate.xval,175*appDelegate.yval,79*appDelegate.xval,10*appDelegate.yval)]autorelease];
    hand.backgroundColor = [UIColor colorWithPatternImage:
                           [UIImage imageNamed:@"hand.png"]];
    hand.tag=104;
    [hand setOpaque:YES];
    [bodyimage addSubview:hand];
    [pArr addObject:hand];
    
    [hand addTarget:self action:@selector(partsbuttonclicked:)
  forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leg = [[[UIButton alloc]
                       initWithFrame:CGRectMake(121*appDelegate.xval,255*appDelegate.yval,89*appDelegate.xval,10*appDelegate.yval)]autorelease];
    leg.backgroundColor = [UIColor colorWithPatternImage:
                            [UIImage imageNamed:@"leg.png"]];
    leg.tag=105;
    [leg setOpaque:YES];
    [bodyimage addSubview:leg];
    [pArr addObject:leg];
    
    [leg addTarget:self action:@selector(partsbuttonclicked:)
   forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *eye = [[[UIButton alloc]
                      initWithFrame:CGRectMake(270*appDelegate.xval,71*appDelegate.yval,94*appDelegate.xval,10*appDelegate.yval)]autorelease];
    eye.backgroundColor = [UIColor colorWithPatternImage:
                           [UIImage imageNamed:@"eye.png"]];
    eye.tag=106;
    [eye setOpaque:YES];
    [bodyimage addSubview:eye];
    [pArr addObject:eye];
    
    [eye addTarget:self action:@selector(partsbuttonclicked:)
  forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *lip = [[[UIButton alloc]
                      initWithFrame:CGRectMake(259*appDelegate.xval,97*appDelegate.yval,99*appDelegate.xval,10*appDelegate.yval)]autorelease];
    lip.backgroundColor = [UIColor colorWithPatternImage:
                           [UIImage imageNamed:@"lip.png"]];
    lip.tag=107;
    [lip setOpaque:YES];
    [bodyimage addSubview:lip];
    [pArr addObject:lip];
    
    [lip addTarget:self action:@selector(partsbuttonclicked:)
  forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *neck = [[[UIButton alloc]
                      initWithFrame:CGRectMake(255*appDelegate.xval,120*appDelegate.yval,119*appDelegate.xval,10*appDelegate.yval)]autorelease];
    neck.backgroundColor = [UIColor colorWithPatternImage:
                           [UIImage imageNamed:@"neck.png"]];
    neck.tag=108;
    [neck setOpaque:YES];
    [bodyimage addSubview:neck];
    [pArr addObject:neck];
    
    [neck addTarget:self action:@selector(partsbuttonclicked:)
  forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *chest = [[[UIButton alloc]
                       initWithFrame:CGRectMake(269*appDelegate.xval,147*appDelegate.yval,120*appDelegate.xval,11*appDelegate.yval)]autorelease];
    chest.backgroundColor = [UIColor colorWithPatternImage:
                            [UIImage imageNamed:@"chest.png"]];
    chest.tag=109;
    [chest setOpaque:YES];
    [bodyimage addSubview:chest];
    [pArr addObject:chest];
    
    [chest addTarget:self action:@selector(partsbuttonclicked:)
   forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *belly = [[[UIButton alloc]
                       initWithFrame:CGRectMake(265*appDelegate.xval,177*appDelegate.yval,117*appDelegate.xval,10*appDelegate.yval)]autorelease];
    belly.backgroundColor = [UIColor colorWithPatternImage:
                            [UIImage imageNamed:@"belly.png"]];
    belly.tag=110;
    [belly setOpaque:YES];
    [bodyimage addSubview:belly];
    [pArr addObject:belly];
    
    [belly addTarget:self action:@selector(partsbuttonclicked:)
   forControlEvents:UIControlEventTouchUpInside];
    
    [bodyimage setOpaque:NO];
  [backgroundView addSubview:bodyimage];
    [self.view addSubview:backgroundView];
    
}


-(void)homebuttonclicked
{
    appDelegate.loopaudio=NO;
    appDelegate.audioPlayer.volume=0;
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)viewbuttonclicked
{
    for (int j=0; j<10; j++)
    {
        if (appDelegate.loopaudio==YES) {
        NSString *str = [appDelegate.bodylist objectAtIndex:j];
        [appDelegate playAudio:str :@"mp3"];
    //    NSLog(@"%i  |  %@", j,str);
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
        [NSThread sleepForTimeInterval:0.50];
        }
  
    }
    
}

-(void)partsbuttonclicked: (UIButton *) tBtn
{
    
        
    int j=(tBtn.tag)-101;
    NSString *str = [appDelegate.bodylist objectAtIndex:j];
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
