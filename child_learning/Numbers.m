//  Numbers.m
//  Babyschool
//  Created by User on 9/16/12.
//  Copyright (c) 2012 User. All rights reserved.

#import "Numbers.h"
#import "AppDelegate.h"
#import "UIView-ModalAnimationHelper.h"
#import "ViewController.h"
#import "QuartzCore/QuartzCore.h"
@interface Numbers ()

@end

@implementation Numbers
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
	sv.contentSize = CGSizeMake(9 * 480.0f*appdelegate.xval, sv.frame.size.height);
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
	pagecontrol.numberOfPages = 9;
	pagecontrol.currentPage = 0;
	[pagecontrol addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    NSString *str = [appdelegate.numberlist objectAtIndex:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];
}

-(void)homebuttonclicked
{
    appdelegate.audioPlayer.volume=0;
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) soundbuttonclicked:(UIButton *)sbtn
{
    NSString *str = [appdelegate.numberlist objectAtIndex:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];
}

-(void) cbuttonclicked:(UIButton *)cbtn
{
   // NSLog(@"Btn index==> %i", cbtn.tag);
    int indx = cbtn.tag - 100;
    
    // Bounce to 115% of the normal size
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    cbtn.transform = CGAffineTransformMakeScale(1.50f, 1.50f);
    [UIView commitModalAnimations];
    
    NSString *newStr = [appdelegate.numberlist objectAtIndex:pagecontrol.currentPage];
    newStr = [[newStr substringFromIndex:indx] substringToIndex:1];
    
 //   NSLog(@">>>>>>>>>>>This is cbuttonclicked >>>>>>>>>(%@)", newStr);
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

- (void)shakeView:(UIButton *) tBtn
{
    
    NSString *str = [appdelegate.numberlist objectAtIndex:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];
    
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


- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
    ScrollDirection scrollDirection=[self getScrollDirection:aScrollView];;
    CGPoint offset = aScrollView.contentOffset;
    pagecontrol.currentPage=(int)(offset.x/(480.0*appdelegate.xval));
    NSString *str = [appdelegate.numberlist objectAtIndex:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];
    
	int currentPage = pagecontrol.currentPage;
    if(currentPage>=1 && currentPage<9-1){
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
        for ( int tt = 0; tt < 9; tt++ ) {
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
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mountain.png"]];
    backgroundView.tag=500+itemNo;
    [sv addSubview:backgroundView];
    
    UIButton *tBtn = [[[UIButton alloc] initWithFrame:CGRectMake((itemNo*480*appdelegate.xval)+20*appdelegate.xval, 70*appdelegate.yval, 141*appdelegate.xval, 167*appdelegate.yval)]autorelease];
    NSString *str = [NSString stringWithFormat:@"%@.png",[appdelegate.numberlist objectAtIndex:itemNo]];
    tBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
    tBtn.tag = 100+itemNo;
    [tBtn addTarget:self action:@selector(shakeView:) forControlEvents:(UIControlEventTouchUpInside)];
    [tBtn setOpaque:YES];
    [sv addSubview:tBtn];
    
    UIButton *numberitem = [[UIButton alloc] initWithFrame:CGRectMake((itemNo*480*appdelegate.xval)+150*appdelegate.xval, 0, 330*appdelegate.xval, 320*appdelegate.yval)];
    NSString *str2 = [NSString stringWithFormat:@"numberitem%@.png",[appdelegate.numberlist objectAtIndex:itemNo]];
    numberitem.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str2]];
    numberitem.tag = 300+itemNo;
    [numberitem addTarget:self action:@selector(shakeView:) forControlEvents:(UIControlEventTouchUpInside)];
    [numberitem setOpaque:YES];
    [sv addSubview:numberitem];

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

-(void) tBtnAction: (UIButton *) tBtn
{
   // NSLog(@"Btnclicked--> %i | %i", tBtn.tag, pagecontrol.currentPage);
    tBtn.alpha = 1.0f;
    NSString *str = [appdelegate.numberlist objectAtIndex:pagecontrol.currentPage];
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

-(void)reloadbuttonclicked
{
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

