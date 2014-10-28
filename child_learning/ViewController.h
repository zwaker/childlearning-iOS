//  ViewController.h
//  Babyschool
//  Created by User on 9/15/12.
//  Copyright (c) 2012 User. All rights reserved.

#import <UIKit/UIKit.h>
#define CATEGORY @"category"  

@class AppDelegate;
@interface ViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *sv;
    AppDelegate *appdelegate;
    UIPageControl *pagecontrol;
    int scSl;
    int whichpage;
    
}

@property(strong, nonatomic)UIButton *btn;

@end


