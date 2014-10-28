//  AlphobetsWithItem.m
//  Babyschool
//  Created by User on 9/16/12.
//  Copyright (c) 2012 User. All rights reserved.


#import "AlphabetsWithItem.h"
#import "AppDelegate.h"
#import "UIView-ModalAnimationHelper.h"
#import "ViewController.h"

@interface AlphabetsWithItem ()

@end

@implementation AlphabetsWithItem
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
	sv.contentSize = CGSizeMake(NPAGES * 480.0f *appdelegate.xval, sv.frame.size.height);
	sv.pagingEnabled = YES;
	sv.delegate = self;
    sv.showsHorizontalScrollIndicator=NO;
    sv.userInteractionEnabled=YES;
    
    // Load in all the pages
	for ( i = 0; i < 3; i++)
	{
        
        UIImageView *backgroundView =[[[UIImageView alloc]initWithFrame:CGRectMake((i*480*appdelegate.xval), 0, 480*appdelegate.xval, 320*appdelegate.yval)]autorelease];
        backgroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"alphabetwithitembg.png"]];
        backgroundView.tag=500+i;
        [sv addSubview:backgroundView];
        UIButton *tBtn = [[[UIButton alloc] initWithFrame:CGRectMake((i*480*appdelegate.xval), 0, 230*appdelegate.xval, 220*appdelegate.yval)]autorelease];
        tBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"alphabetwithitemletter%@",[appdelegate.alphabet objectAtIndex:i]]]];
        tBtn.tag = 100+i;
        [tBtn addTarget:self action:@selector(tBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [tBtn setOpaque:YES];
        [sv addSubview:tBtn];
        
        
        UIButton *itemBtn = [[[UIButton alloc] initWithFrame:CGRectMake((i*480*appdelegate.xval)+170*appdelegate.xval, 0, 310*appdelegate.xval, 300*appdelegate.yval)]autorelease];
        itemBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[appdelegate.itemlist objectAtIndex:i]]];
        itemBtn.tag = 200+i;
        [itemBtn addTarget:self action:@selector(itemBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [itemBtn setOpaque:YES];
        [sv addSubview:itemBtn];
        
             
        NSString *itemname =[[NSString alloc]init];
        itemname = (NSString *) [appdelegate.itemlist objectAtIndex:i];
        
      //  NSLog(@"=====> %@",itemname);
        
        int len = [itemname length];
        
        int totCharLen = 0;
        
        for (int j=0; j<len; j++)
        {
           image=[[NSString alloc]init];
            self.image=[[itemname substringFromIndex:j] substringToIndex:1];
         //   NSLog(@"CHAR========================> %@", self.image);
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
            else if([self.image isEqualToString:(@"2")])
            {
                k=0;
            }
            else
            {
                k=35;
            }
            
            UIButton *cbutton=[[[UIButton alloc]initWithFrame:CGRectMake(((i*480)+totCharLen+30)*appdelegate.xval, 265*appdelegate.yval, k*appdelegate.xval, 50*appdelegate.yval)]autorelease];
            cbutton.tag = 1000+j;
            cbutton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:self.image]];
            [cbutton addTarget:self action:@selector(cbuttonclicked:)  forControlEvents:(UIControlEventTouchUpInside)];
            [cbutton setOpaque:YES];
            [sv addSubview:cbutton];
            totCharLen += k;
        }
        
         NSString *str=[appdelegate.sound_itemlist objectAtIndex:i];
        NSArray *namesArray = [str componentsSeparatedByString:@"_"];

        if ([[namesArray objectAtIndex:0] isEqual:@"itemsound"]) {
            UIButton *sound=[[[UIButton alloc]initWithFrame:CGRectMake(((i*480)+totCharLen+30)*appdelegate.xval, 273*appdelegate.yval,31*appdelegate.xval, 29*appdelegate.yval)]autorelease];
            sound.tag=300+i;
            sound.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"sound.png"]];
            [sound addTarget:self action:@selector(soundbuttonclicked:) forControlEvents:(UIControlEventTouchUpInside)];
            [sound setOpaque:YES];
            [sv addSubview:sound];
        }
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
	pagecontrol.numberOfPages = NPAGES;
	pagecontrol.currentPage = 0;
	[pagecontrol addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    
}


-(void) loadRestOfItem:(int)itemNo{
    UIImageView *backgroundView =[[[UIImageView alloc]initWithFrame:CGRectMake((itemNo*480*appdelegate.xval), 0, 480*appdelegate.xval, 320*appdelegate.yval)]autorelease];
    backgroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"alphabetwithitembg.png"]];
    backgroundView.tag=500+itemNo;
    [sv addSubview:backgroundView];
    UIButton *tBtn = [[[UIButton alloc] initWithFrame:CGRectMake((itemNo*480*appdelegate.xval), 0, 230*appdelegate.xval, 220*appdelegate.yval)]autorelease];
    tBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"alphabetwithitemletter%@",[appdelegate.alphabet objectAtIndex:itemNo]]]];
    tBtn.tag = 100+itemNo;
    [tBtn addTarget:self action:@selector(tBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [tBtn setOpaque:YES];
    [sv addSubview:tBtn];
    
    
    UIButton *itemBtn = [[[UIButton alloc] initWithFrame:CGRectMake((itemNo*480*appdelegate.xval)+170*appdelegate.xval, 0, 310*appdelegate.xval, 300*appdelegate.yval)]autorelease];
    itemBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[appdelegate.itemlist objectAtIndex:itemNo]]];
    itemBtn.tag = 200+itemNo;
    [itemBtn addTarget:self action:@selector(itemBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [itemBtn setOpaque:YES];
    [sv addSubview:itemBtn];

    
    NSString *itemname =[[NSString alloc]init];
    itemname = (NSString *) [appdelegate.itemlist objectAtIndex:itemNo];
    
    //  NSLog(@"=====> %@",itemname);
    
    int len = [itemname length];
    
    int totCharLen = 0;
    
    for (int j=0; j<len; j++)
    {
        image=[[NSString alloc]init];
        self.image=[[itemname substringFromIndex:j] substringToIndex:1];
        //   NSLog(@"CHAR========================> %@", self.image);
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
        else if([self.image isEqualToString:(@"2")])
        {
            k=0;
        }
        else
        {
            k=35;
        }
        
        UIButton *cbutton=[[[UIButton alloc]initWithFrame:CGRectMake(((itemNo*480)+totCharLen+30)*appdelegate.xval, 265*appdelegate.yval, k*appdelegate.xval, 50*appdelegate.yval)]autorelease];
        cbutton.tag = 1000+j;
        cbutton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:self.image]];
        [cbutton addTarget:self action:@selector(cbuttonclicked:)  forControlEvents:(UIControlEventTouchUpInside)];
        [cbutton setOpaque:YES];
        [sv addSubview:cbutton];
        totCharLen += k;
    }
    
    NSString *str=[appdelegate.sound_itemlist objectAtIndex:itemNo];
    NSArray *namesArray = [str componentsSeparatedByString:@"_"];
    
    if ([[namesArray objectAtIndex:0] isEqual:@"itemsound"]) {
        UIButton *sound=[[[UIButton alloc]initWithFrame:CGRectMake(((itemNo*480)+totCharLen+30)*appdelegate.xval, 273*appdelegate.yval,31*appdelegate.xval, 29*appdelegate.yval)]autorelease];
        sound.tag=300+itemNo;
        sound.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"sound.png"]];
        [sound addTarget:self action:@selector(soundbuttonclicked:) forControlEvents:(UIControlEventTouchUpInside)];
        [sound setOpaque:YES];
        [sv addSubview:sound];
    }
    
  

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    NSString *str=[NSString stringWithFormat:@"sound_%@",[appdelegate.itemlist objectAtIndex:pagecontrol.currentPage]];
    [appdelegate playAudio:str :@"mp3"];
}

-(void)homebuttonclicked
{
    [appdelegate.audioPlayer stop];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) cbuttonclicked:(UIButton *)cbtn
{
  //  NSLog(@"Btn index==> %i", cbtn.tag);
    int indx = cbtn.tag - 1000;
    
    // Bounce to 115% of the normal size
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    cbtn.transform = CGAffineTransformMakeScale(1.50f, 1.50f);
    [UIView commitModalAnimations];
    
    NSString *newStr = [appdelegate.itemlist objectAtIndex:pagecontrol.currentPage];
    newStr = [[newStr substringFromIndex:indx] substringToIndex:1];
    
  //  NSLog(@">>>>>>>>>>>This is cbuttonclicked >>>>>>>>>(%@)", newStr);
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

- (void) pageTurn: (UIPageControl *) aPageControl
{
  //  NSLog(@"Page turn--> %i", aPageControl.currentPage);
	int whichPage = aPageControl.currentPage;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	sv.contentOffset = CGPointMake(480.0f * whichPage*appdelegate.xval, 0.0f);
	[UIView commitAnimations];
}

- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
	    ScrollDirection scrollDirection=[self getScrollDirection:aScrollView];;
    CGPoint offset = aScrollView.contentOffset;//(int)(offset.x/(480.0*appdelegate.xval));
    pagecontrol.currentPage=(int)(offset.x/(480.0*appdelegate.xval));
    NSString *str=[NSString stringWithFormat:@"sound_%@",[appdelegate.itemlist objectAtIndex:pagecontrol.currentPage]];
    [appdelegate playAudio:str :@"mp3"];
	int currentPage = pagecontrol.currentPage;
    if(currentPage>=1 && currentPage<NPAGES-1){
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
	for ( int tt = 0; tt < NPAGES; tt++ ) {
		if ((scrollDirection==ScrollDirectionRight) && (tt < (currentPage-1) || tt > (currentPage+1)) && [sv viewWithTag:(100+(tt))] ) {
            [[sv viewWithTag:(100+(tt))] removeFromSuperview];
            [[sv viewWithTag:(200+(tt))] removeFromSuperview];
			[[sv viewWithTag:(300+(tt))] removeFromSuperview];
            //[[sv viewWithTag:(400+(tt))] removeFromSuperview];
            [[sv viewWithTag:(500+(tt))] removeFromSuperview];
            
            NSString *itemname = (NSString *) [appdelegate.itemlist objectAtIndex:tt];
            //  NSLog(@"=====> %@",itemname);
            int len = [itemname length];
            for (int j=0; j<len; j++){
              //  [[sv viewWithTag:(1000+(j))] removeFromSuperview];
            }

		}
        if (scrollDirection==ScrollDirectionLeft) {
		}
        
	}
        
    }
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
    int j=[self gettBtnIndex:tBtn.tag];
     //   NSLog(@"Btnclicked--> %i | %i", tBtn.tag, pagecontrol.currentPage);
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

-(void) itemBtnAction: (UIButton *) tBtn{
    
    NSString *str=[appdelegate.sound_itemlist objectAtIndex:pagecontrol.currentPage];
    [appdelegate playAudio:str :@"mp3"];
     
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    tBtn.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
    [UIView commitModalAnimations];

    
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

-(void) soundbuttonclicked:(UIButton *)sbtn
{
     NSString *str = [NSString stringWithFormat:@"sound_%@", [appdelegate.itemlist objectAtIndex:pagecontrol.currentPage]];
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
