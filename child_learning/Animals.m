//  Animals.m
//  Babyschool
//  Created by User on 9/16/12.
//  Copyright (c) 2012 User. All rights reserved.

#import "Animals.h"
#import "AppDelegate.h"
#import "UIView-ModalAnimationHelper.h"
#import "ViewController.h"
#import "QuartzCore/QuartzCore.h"
@interface Animals ()

@end

@implementation Animals
@synthesize button;
@synthesize btn;
@synthesize image;
@synthesize lastContentOffset;

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
    [button release];
     [btn release];
    [image release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appdelegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.navigationController.navigationBarHidden=YES;
    prevPage = 0;
    
	// Do any additional setup after loading the view.
	sv = [[[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480*appdelegate.xval, 320*appdelegate.yval)] autorelease];
	sv.contentSize = CGSizeMake(12 * 480.0f *appdelegate.xval, sv.frame.size.height);
	sv.pagingEnabled = YES;
	sv.delegate = self;
    sv.showsHorizontalScrollIndicator=NO;
    sv.userInteractionEnabled=YES;
    
    // Load in all the pages
	for (i = 0; i < 3; i++)
	{
        [self loadRestOfItem:i];
    }
    
    [self.view addSubview:sv];
    UIButton *homebutton = [[[UIButton alloc]
                             initWithFrame:CGRectMake(450*appdelegate.xval, 5*appdelegate.yval, 28*appdelegate.xval, 25*appdelegate.yval)]autorelease];
    homebutton.backgroundColor = [UIColor colorWithPatternImage:
                                  [UIImage imageNamed:@"homebutton.png"]];
    [homebutton setOpaque:YES];
    [self.view addSubview:homebutton];
    [homebutton addTarget:self action:@selector(homebuttonclicked)
         forControlEvents:UIControlEventTouchUpInside];
    
    pagecontrol = [[UIPageControl alloc] init];
	pagecontrol.numberOfPages = 12;
	pagecontrol.currentPage = 0;
	[pagecontrol addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    NSString *str = [appdelegate.animallist objectAtIndex:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];
}

-(void)homebuttonclicked
{
    [appdelegate.audioPlayer stop];
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void) soundbuttonclicked:(UIButton *)sbtn
{
  
    NSString *str = [appdelegate.animallist objectAtIndex:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];
    
}

-(void) cbuttonclicked:(UIButton *)cbtn
{
//    NSLog(@"Btn index==> %i", cbtn.tag);
    int indx = cbtn.tag - 1000;
    
    // Bounce to 115% of the normal size
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    cbtn.transform = CGAffineTransformMakeScale(1.50f, 1.50f);
    [UIView commitModalAnimations];
    
    NSString *newStr = [appdelegate.animallist objectAtIndex:pagecontrol.currentPage];
    newStr = [[newStr substringFromIndex:indx] substringToIndex:1];
    
//    NSLog(@">>>>>>>>>>>This is cbuttonclicked >>>>>>>>>(%@)", newStr);
    NSString *cbtnstr;
    
    if(pagecontrol.currentPage%2==0)
    {
        cbtnstr=[NSString stringWithFormat:@"Fem_%@",newStr];
    }
    else
    {
        cbtnstr=[NSString stringWithFormat:@"Boy_%@",newStr];
    }
    
    [appdelegate playAudio:cbtnstr :@"mp3"];
    
    // Return back to 100%
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.1f];
    cbtn.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitModalAnimations];
}

- (void)shakeView:(UIView*)view
{
    
    NSString *str = [appdelegate.sound_animal objectAtIndex:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];

    
    CGRect r = view.frame;
    int x_ = r.origin.x;
	r.origin.x = r.origin.x - 20;
    CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.1f];
	[UIView setAnimationRepeatCount:5];
	[UIView setAnimationRepeatAutoreverses:NO];
	[view setFrame:r];
    r.origin.x = x_;
    [view setFrame:r];
    [UIView commitAnimations];
}



- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
    ScrollDirection scrollDirection=[self getScrollDirection:aScrollView];;
    CGPoint offset = aScrollView.contentOffset;
    pagecontrol.currentPage=(int)(offset.x/(480.0*appdelegate.xval));
    NSString *str = [appdelegate.animallist objectAtIndex:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];

	int currentPage = pagecontrol.currentPage;
    if(currentPage>=1 && currentPage<12-1){
        // display the image and maybe +/-1 for a smoother scrolling
        // but be sure to check if the image already exists, you can do this very easily using tags
        if ( scrollDirection==ScrollDirectionLeft && [sv viewWithTag:(100+(currentPage -1))]) {
            return;
        }
        else if (scrollDirection==ScrollDirectionRight && [sv viewWithTag:(100+(currentPage +1))]) {
            return;
        }
        else {
            // view is missing, create it and set its tag to currentPage+1
            if(scrollDirection==ScrollDirectionLeft){
                [self loadRestOfItem:currentPage-1];
                
                
            }
            if(scrollDirection==ScrollDirectionRight){
                [self loadRestOfItem:currentPage+1];
            }
            
            
        }
        
        /**
         *	using your paging numbers as tag, you can also clean the UIScrollView
         *	from no longer needed views to get your memory back
         *	remove all image views except -1 and +1 of the currently drawn page
         */
        for ( int tt = 0; tt < 12; tt++ ) {
            if ((scrollDirection==ScrollDirectionRight) && (tt < (currentPage-1) || tt > (currentPage+1)) && [sv viewWithTag:(100+(tt))] ) {
                [[sv viewWithTag:(100+(tt))] removeFromSuperview];
                //[[sv viewWithTag:(200+(tt))] removeFromSuperview];
                [[sv viewWithTag:(300+(tt))] removeFromSuperview];
                //[[sv viewWithTag:(400+(tt))] removeFromSuperview];
                [[sv viewWithTag:(500+(tt))] removeFromSuperview];
                
                NSString *animalname = (NSString *) [appdelegate.animallist objectAtIndex:tt];
                //  NSLog(@"=====> %@",itemname);
                int len = [animalname length];
                for (int j=0; j<len; j++){
                    [[sv viewWithTag:(1000+(j))] removeFromSuperview];
                }
                
            }
            if (scrollDirection==ScrollDirectionLeft) {
            }
            
        }
        
    }
}


-(void) loadRestOfItem:(int)itemNo{
    UIImageView *backgroundView =[[[UIImageView alloc]initWithFrame:CGRectMake((itemNo*480*appdelegate.xval), 0, 480*appdelegate.xval, 320*appdelegate.yval)]autorelease];
    NSString *str1 = [appdelegate.animalbg objectAtIndex:itemNo];
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str1]];
    backgroundView.tag=500+itemNo;
    [sv addSubview:backgroundView];
    UIButton *tBtn = [[[UIButton alloc] initWithFrame:CGRectMake((itemNo*480*appdelegate.xval), 0, 480*appdelegate.xval, 265*appdelegate.yval)]autorelease];
    NSString *str = [appdelegate.animallist objectAtIndex:itemNo];
    tBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
    tBtn.tag = 100+itemNo;
    [tBtn addTarget:self action:@selector(shakeView:) forControlEvents:(UIControlEventTouchUpInside)];
    [tBtn setOpaque:YES];
    [sv addSubview:tBtn];
    
    NSString *animallist = @"";
    animallist = (NSString *) [appdelegate.animallist objectAtIndex:itemNo];
    //   NSLog(@"=====> %@",animallist);
    int len = [animallist length];
    float temp,first;
    temp=((len*35)/2);
    first=(240-temp);
    int totCharLen = 0;
    for (int j=0; j<len; j++)
    {
        image=[[NSString alloc]init];
        self.image=[[animallist substringFromIndex:j] substringToIndex:1];
        //       NSLog(@"CHAR========================> %@", self.image);
        int k;
        if ([self.image isEqualToString:(@"m")] || [self.image isEqualToString:(@"w")] || [self.image isEqualToString:(@"M")] || [self.image isEqualToString:(@"W")])
        {
            k=50;
        }
        else if ([self.image isEqualToString:(@"l")] || [self.image isEqualToString:(@"i")] || [self.image isEqualToString:(@"L")] || [self.image isEqualToString:(@"I")]
                 || [self.image isEqualToString:(@"r")])
        {
            k=25;
            
        }
        else
        {
            k=35;
        }
        UIButton *cbutton=[[[UIButton alloc]initWithFrame:CGRectMake(((itemNo*480)+totCharLen+first)*appdelegate.xval, 265*appdelegate.yval, k*appdelegate.xval, 50*appdelegate.yval)]autorelease];
        cbutton.tag = 1000+j;
        cbutton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:self.image]];
        [cbutton addTarget:self action:@selector(cbuttonclicked:)  forControlEvents:(UIControlEventTouchUpInside)];
        [cbutton setOpaque:YES];
        [sv addSubview:cbutton];
        totCharLen += k;
    }
    
    UIButton *sound=[[[UIButton alloc]initWithFrame:CGRectMake(((itemNo*480)+totCharLen+first)*appdelegate.xval, 273*appdelegate.yval,31*appdelegate.xval, 29*appdelegate.yval)]autorelease];
    sound.tag=300+itemNo;
    sound.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"sound.png"]];
    [sound addTarget:self action:@selector(soundbuttonclicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [sound setOpaque:YES];
    [sv addSubview:sound];

}

-(ScrollDirection) getScrollDirection:(UIScrollView *) scrollView{
    ScrollDirection scrollDirection;
    if (self.lastContentOffset < scrollView.contentOffset.x)
        scrollDirection = ScrollDirectionRight;
    else if (self.lastContentOffset > scrollView.contentOffset.x)
        scrollDirection = ScrollDirectionLeft;
    self.lastContentOffset = scrollView.contentOffset.x;
    return scrollDirection;
    
}



-(int) gettBtnIndex:(int) tagIndex{
    int j=0;
    if(tagIndex>=1000){
        j=tagIndex-1000;
    }
    if(tagIndex>=500 && tagIndex<600){
        j=tagIndex-500;
    }
    if(tagIndex>=400 && tagIndex<500){
        j=tagIndex-400;
    }
    if(tagIndex>=300 && tagIndex<400){
        j=tagIndex-300;
    }
    if(tagIndex>=200 && tagIndex<300){
        j=tagIndex-200;
    }
    if(tagIndex>=100 && tagIndex<200){
        j=tagIndex-100;
    }
    return j;
}



-(void) tBtnAction: (UIButton *) tBtn
{
//    NSLog(@"Btnclicked--> %i | %i", tBtn.tag, pagecontrol.currentPage);
    tBtn.alpha = 1.0f;
    NSString *str = [appdelegate.sound_animal objectAtIndex:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];
    
    // Bounce to 115% of the normal size
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    tBtn.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
    [UIView commitModalAnimations];

    // Return back to 100%
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.1f];
    tBtn.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitModalAnimations];
    
}

-(void)reloadbuttonclicked{
    
    
    NSString *str = [appdelegate audiostringFrom:AUDIIOTYPE withValue:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight|| interfaceOrientation==UIInterfaceOrientationLandscapeLeft);
}

@end
