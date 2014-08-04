//
//  FFLSecondViewController.h
//  FFL
//
//  Created by NOs on 04.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFLFilterTableView.h"

@interface FFLSecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    FFLFilterTableView *filterView;
    UITextField *textField;
    NSMutableArray *mainFilterData;
}
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray;
-(NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName;

@end
