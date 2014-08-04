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
        
        alert = [[UIAlertView alloc] initWithTitle: @"Загрузка..." message: nil delegate:self cancelButtonTitle: nil otherButtonTitles: nil];
        UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(125, 50, 30, 30)];
        progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [alert addSubview: progress];
        [progress startAnimating];
    }
    return self;
}

- (void)loadUrl:(NSString *) urlStr{
  [alert show];
  [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)viewDidLoad
{
        [super viewDidLoad];
        webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.delegate = self;
    
        [self.view  addSubview:webView];
        [self loadUrl:self.url];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
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
