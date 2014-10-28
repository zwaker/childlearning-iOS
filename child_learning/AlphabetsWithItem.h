//  AlphabetsWithItem.h
//  Babyschool
//  Created by User on 9/16/12.
//  Copyright (c) 2012 User. All rights reserved.

#import <UIKit/UIKit.h>
#define BASEHEIGHT	480.0f
#define NPAGES		26
#define AUDIIOTYPE @"alphabet"
#define AUDIIOTYPE_BOY @"Boy_"
#define AUDIIOTYPE_FEM @"Fem_"
#define CATEGORY @"category"


@class AppDelegate;

@interface AlphabetsWithItem : UIViewController<UIScrollViewDelegate>
{
    AppDelegate *appdelegate;
    
    UIPageControl *pagecontrol;
    UIScrollView *sv;
    int i, prevPage;
}
@property (nonatomic, assign) int lastContentOffset;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic)  NSString *image;


@end
