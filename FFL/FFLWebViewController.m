//
//  FFLWebViewController.m
//  FFL
//
//  Created by NOs on 04.08.14.
//  Copyright (c) 2014 NOs. All rights reserved.
//

#import "FFLWebViewController.h"

@interface FFLWebViewController ()

@end

@implementation FFLWebViewController
@synthesize url = url;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
        
        
    }
    return self;
}

- (void)loadUrl:(NSString *) urlStr{
   [loadingView setHidden:NO];
   [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)viewDidLoad
{
        [super viewDidLoad];
        webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.delegate = self;
    
        [self.view  addSubview:webView];
        [self loadUrl:self.url];
    
        adView = [[ADBannerView alloc] init];
        adView.delegate = self;
        self.canDisplayBannerAds = YES;
    
    loadingView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height/2-40, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.6];
    loadingView.layer.cornerRadius = 5;
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center = CGPointMake(loadingView.frame.size.width / 2.0, 35);
    [activityView startAnimating];
    activityView.tag = 100;
    [loadingView addSubview:activityView];
    
    UILabel* lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 80, 30)];
    lblLoading.text = @"Загрузка...";
    lblLoading.textColor = [UIColor whiteColor];
    lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
    lblLoading.textAlignment = NSTextAlignmentCenter;
    [loadingView addSubview:lblLoading];

    
    
    
    [self.view addSubview:loadingView];
    // Do any additional setup after loading the view.
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"iAdBanner failed %@",error);
    
    
}
-(void) bannerViewDidLoadAd:(ADBannerView *)banner
{
    
    NSLog(@"iAdBanner loaded");
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [loadingView setHidden:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
