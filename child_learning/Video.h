//  Video.h
//  Babyschool
//  Created by LOTUS on 9/25/12.
//  Copyright (c) 2012 User. All rights reserved.

#import <UIKit/UIKit.h>
#import "Foundation/Foundation.h"

@class AppDelegate;

@interface Video : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSURL *myURL;
    AppDelegate *appDelegate;
    UITableView *dtable;
    NSArray *myarr;
    NSMutableString *sourcestring;
    NSString *tmpString;
}

@end
