//
//  FFLDetailController.h
//  FFL
//
//  Created by NOs on 05.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFLWebViewController.h"

@interface FFLDetailController : UIViewController{
    NSArray *itemData;

}
- (id)initWithItem:(NSArray *) item;
-(void) openUrlButtonClick:(id) sender;

@end
