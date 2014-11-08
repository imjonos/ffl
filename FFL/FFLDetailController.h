//
//  FFLDetailController.h
//  FFL
//
//  Created by NOs on 05.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFLWebViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <QuartzCore/QuartzCore.h>

@interface FFLDetailController : UIViewController<MFMailComposeViewControllerDelegate>{
    NSArray *itemData;

}
- (id)initWithItem:(NSArray *) item;
-(void) openUrlButtonClick:(id) sender;

@end
