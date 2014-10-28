//  Alphobets.m
//  Babyschool
//  Created by User on 9/16/12.
//  Copyright (c) 2012 User. All rights reserved.

#import "Alphabets.h"
#import "AppDelegate.h"
#import "UIView-ModalAnimationHelper.h"
#import "ViewController.h"

@interface Alphabets ()

@end

@implementation Alphabets
@synthesize button;
@synthesize btn;
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
	sv.contentSize = CGSizeMake(NPAGES * 480.0f*appdelegate.xval, sv.frame.size.height);
	sv.pagingEnabled = YES;
	sv.delegate = self;
    sv.showsHorizontalScrollIndicator=NO;
    sv.userInteractionEnabled=YES;
    sv.bounces = NO;
      
    // Load in all the pages
   	for (i = 0; i <3 ; i++)
	{
        UIImageView *backgroundView =[[[UIImageView alloc]initWithFrame:CGRectMake((i*480*appdelegate.xval), 0, 480*appdelegate.xval, 320*appdelegate.yval)]autorelease];
        backgroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        backgroundView.tag=100+i;
        [sv addSubview:backgroundView];

        		
        UIButton *tBtn = [[[UIButton alloc] initWithFrame:CGRectMake((i*480*appdelegate.xval), 0, 480*appdelegate.xval, 320*appdelegate.yval)] autorelease];
       
        NSString *str = [appdelegate categorystring:AUDIIOTYPE withValue:i];
        tBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
        
        
        tBtn.tag = 100+i;
        [tBtn addTarget:self action:@selector(tBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [tBtn setOpaque:YES];
        //tBtn.tag=i;
        [sv addSubview:tBtn];
        
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
    pagecontrol.numberOfPages = 26;
	pagecontrol.currentPage = 0;
	[pagecontrol addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];

  }

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    int gender;
     gender=((pagecontrol.currentPage)%2);
    if (gender==0) {
        NSString *str = [appdelegate audiostringalphabet:AUDIIOTYPE_BOY withValue:[appdelegate.alphabet objectAtIndex:pagecontrol.currentPage]];
        [appdelegate playAudio:str :@"mp3"];
    }
    
    else{
        
        NSString *str = [appdelegate audiostringalphabet:AUDIIOTYPE_FEM withValue:[appdelegate.alphabet objectAtIndex:pagecontrol.currentPage]];
        [appdelegate playAudio:str :@"mp3"];
    }
}

-(void)homebuttonclicked
{
    
    [appdelegate.audioPlayer stop];
    ViewController *viewcontroller=[[[ViewController alloc]init]autorelease];
    [self.navigationController pushViewController:viewcontroller animated:YES];
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

- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
	CGPoint offset = aScrollView.contentOffset;
    pagecontrol.currentPage=(int)(offset.x/(480.0*appdelegate.xval));
    if (pagecontrol.currentPage!=prevPage)
    {
        prevPage = pagecontrol.currentPage;
          int gender;
        gender=((pagecontrol.currentPage)%2);
        if (gender==0)
        {
             NSString *str = [appdelegate audiostringalphabet:AUDIIOTYPE_BOY withValue:[appdelegate.alphabet objectAtIndex:pagecontrol.currentPage]];
            [appdelegate playAudio:str :@"mp3"];
        }
        
        else
        {
            NSString *str = [appdelegate audiostringalphabet:AUDIIOTYPE_FEM withValue:[appdelegate.alphabet objectAtIndex:pagecontrol.currentPage]];
            [appdelegate playAudio:str :@"mp3"];
        }
            
    }
    /**
	 *	calculate the current page that is shown
	 *	you can also use myScrollview.frame.size.height if your image is the exact size of your scrollview
	 */
    ScrollDirection scrollDirection=[self getScrollDirection:aScrollView];;
    //CGPoint offset = aScrollView.contentOffset;//(int)(offset.x/(480.0*appdelegate.xval));
    pagecontrol.currentPage=(int)(offset.x/(480.0*appdelegate.xval));
	int currentPage = pagecontrol.currentPage;
    
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
        UIImageView *backgroundView =[[[UIImageView alloc]initWithFrame:CGRectMake(((currentPage-1)*480*appdelegate.xval), 0, 480*appdelegate.xval, 320*appdelegate.yval)]autorelease];
        backgroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
            backgroundView.tag=500+(currentPage-1);
            
        [sv addSubview:backgroundView];
        
        UIButton *tBtn = [[[UIButton alloc] initWithFrame:CGRectMake(((currentPage-1)*480*appdelegate.xval), 0, 480*appdelegate.xval, 320*appdelegate.yval)] autorelease];
        
        NSString *str = [appdelegate categorystring:AUDIIOTYPE withValue:(currentPage-1)];
        tBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
        
        
        tBtn.tag = 100+(currentPage-1);
        [tBtn addTarget:self action:@selector(tBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [tBtn setOpaque:YES];
        //tBtn.tag=100+(currentPage+1);
        [sv addSubview:tBtn];
        }
        if(scrollDirection==ScrollDirectionRight){
            UIImageView *backgroundView =[[[UIImageView alloc]initWithFrame:CGRectMake(((currentPage+1)*480*appdelegate.xval), 0, 480*appdelegate.xval, 320*appdelegate.yval)]autorelease];
            backgroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
            backgroundView.tag=500+(currentPage+1);
            [sv addSubview:backgroundView];
            
            
            UIButton *tBtn = [[[UIButton alloc] initWithFrame:CGRectMake(((currentPage+1)*480*appdelegate.xval), 0, 480*appdelegate.xval, 320*appdelegate.yval)] autorelease];
            
            NSString *str = [appdelegate categorystring:AUDIIOTYPE withValue:(currentPage+1)];
            tBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
            
            
            tBtn.tag = 100+(currentPage+1);
            [tBtn addTarget:self action:@selector(tBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [tBtn setOpaque:YES];
            //tBtn.tag=100+(currentPage+1);
            [sv addSubview:tBtn];
        }


	}
    
	/**
	 *	using your paging numbers as tag, you can also clean the UIScrollView
	 *	from no longer needed views to get your memory back
	 *	remove all image views except -1 and +1 of the currently drawn page
	 */
	for ( int tt = 0; tt < 26; tt++ ) {
		if ((scrollDirection==ScrollDirectionRight) && (tt < (currentPage-1) || tt > (currentPage+1)) && [sv viewWithTag:(100+(tt))] ) {
			[[sv viewWithTag:(100+(tt))] removeFromSuperview];
            [[sv viewWithTag:(500+(tt))] removeFromSuperview];
		}
        if (scrollDirection==ScrollDirectionLeft) {
		}
        
	}
}

-(void) tBtnAction: (UIButton *) tBtn
{
        int j=tBtn.tag-100;
        NSLog(@"Btnclicked--> %i | %i", tBtn.tag, pagecontrol.currentPage);
        tBtn.alpha = 1.0f;
    
        // Bounce to 115% of the normal size
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2f];
        tBtn.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
        [UIView commitModalAnimations];
    
    int gender;
    NSString *str;
    gender=((j)%2);
    if (gender==0) {
        str = [appdelegate audiostringalphabet:AUDIIOTYPE_BOY withValue:[appdelegate.alphabet objectAtIndex:j]];
    }
    
    else{
        
        str = [appdelegate audiostringalphabet:AUDIIOTYPE_FEM withValue:[appdelegate.alphabet objectAtIndex:j]];
    }
    
       [appdelegate playAudio:str :@"mp3"];
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
