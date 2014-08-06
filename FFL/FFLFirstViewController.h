//
//  FFLFirstViewController.h
//  FFL
//
//  Created by NOs on 04.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFLWorkTableView.h"
#import <iAd/iAd.h>

@interface FFLFirstViewController : UIViewController<FFLWorkTableViewDelegate, ADBannerViewDelegate>{

    FFLWorkTableView *worksTableView;
    ADBannerView *adView;
}
- (UIBarButtonItem *) refreshBarButtonItem;
- (void) refreshBarButtonPressed :(id)sender;
@end
