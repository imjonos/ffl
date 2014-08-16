//
//  FFLWebViewController.h
//  FFL
//
//  Created by NOs on 04.08.14.
//  Copyright (c) 2014 NOs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface FFLWebViewController : UIViewController <UIWebViewDelegate, ADBannerViewDelegate>{
    UIWebView *webView;
    UIView *loadingView;
    ADBannerView *adView;
}
- (void)loadUrl:(NSString *) urlStr;
@property (nonatomic, retain) NSString* url;
@end
