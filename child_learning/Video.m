//  Video.m
//  Babyschool
//  Created by LOTUS on 9/25/12.
//  Copyright (c) 2012 User. All rights reserved.

#import "AppDelegate.h"
#import "Video.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "HCYoutubeParser.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AsyncImageView.h"

@interface Video ()

@end

@implementation Video

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
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
// Do any additional setup after loading the view.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    myURL = [NSURL URLWithString:@"http://www.iphonewebservice.com/iintel/faces/videoforkidsrequest.xhtml"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:myURL];
    [request setDelegate:self];
    [request setTimeOutSeconds:3];
    [request startAsynchronous];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Processing...";
    
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    UIButton *homebutton = [[[UIButton alloc]
                             initWithFrame:CGRectMake(450*appDelegate.xval, 5*appDelegate.yval, 28*appDelegate.xval, 25*appDelegate.yval)]autorelease];
    homebutton.backgroundColor = [UIColor colorWithPatternImage:
                                  [UIImage imageNamed:@"homebutton.png"]];
    [self.view addSubview:homebutton];
    [homebutton addTarget:self action:@selector(homebuttonclicked)
         forControlEvents:UIControlEventTouchUpInside];
    
     dtable = [[[UITableView alloc] initWithFrame:CGRectMake(70*appDelegate.xval, 30*appDelegate.yval, 350*appDelegate.xval, 250*appDelegate.yval)]autorelease];
    dtable.backgroundColor = [UIColor clearColor];
    dtable.delegate = self;
    dtable.dataSource = self;
    //dtable.separatorColor = [UIColor clearColor];
    [self.view addSubview:dtable];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150*appDelegate.yval;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 20;
   return  [[myarr valueForKey:@"videotube"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    
    sourcestring = [[NSMutableString alloc] initWithString:[[[myarr valueForKey:@"videotube"] objectAtIndex:indexPath.row] valueForKey:@"sourceUrl"]];
    
    tmpString = [sourcestring substringFromIndex:29];
    
    
    NSString *moretemp=[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/1.jpg",tmpString];
    
   // NSLog(@">>>>>>>%@",moretemp);
    
        NSURL *url = [NSURL URLWithString:moretemp];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        cell.imageView.image=img;
    
    cell.textLabel.text = [[[myarr valueForKey:@"videotube"] objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.detailTextLabel.text = [[[myarr valueForKey:@"videotube"] objectAtIndex:indexPath.row] valueForKey:@"definitionDetails1"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    sourcestring = [[NSMutableString alloc] initWithString:[[[myarr valueForKey:@"videotube"] objectAtIndex:indexPath.row] valueForKey:@"sourceUrl"]];
    
    tmpString = [sourcestring substringFromIndex:29];
 
    
    NSString *moretemp=[NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@&feature=g-logo-xit",tmpString];
    
  //  NSLog(@"tempStr = %@", moretemp);
    // Gets an dictionary with each available youtube url
    NSDictionary *videos = [HCYoutubeParser h264videosWithYoutubeURL:[NSURL URLWithString:moretemp]];
  
    // Presents a MoviePlayerController with the youtube quality medium
    MPMoviePlayerViewController *mp = [[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:[videos objectForKey:@"medium"]]] autorelease];
    [self presentModalViewController:mp animated:YES];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *responseString = [request responseString];
 //   NSLog(@"URL=%@ \nRES==> %@", myURL, responseString);
#if DEBUG
    //NSLog(@"response eventlist: %@", responseString);
#endif
    
    if(responseString)
    {
        SBJsonParser *jpObj = [[SBJsonParser alloc] init];
        myarr = [[NSArray alloc] init];
        myarr = [jpObj objectWithString:responseString];
        
       // NSLog(@"ARR=>%@", myarr);
       // NSLog(@"Second URL YT == %@", [[[myarr valueForKey:@"videotube"] objectAtIndex:0] valueForKey:@"sourceUrl"] );
     //   NSLog(@"Second URL YT == %@", [[[myarr valueForKey:@"videotube"] objectAtIndex:1] valueForKey:@"sourceUrl"] );
        
      //  NSLog(@"Second URL YT == %@", [[[myarr valueForKey:@"videotube"] objectAtIndex:2] valueForKey:@"sourceUrl"] );
        
        [dtable reloadData];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    
    if (error != Nil) {
        
        [appDelegate showAlert:@"Connection Failed!!" setTitle:@"Alert!!"];
        
    }
    
}


-(void)homebuttonclicked
{
   
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft|| interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
