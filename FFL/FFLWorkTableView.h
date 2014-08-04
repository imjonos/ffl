//
//  FFLWorkTableView.h
//  FFL
//
//  Created by NOs on 05.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFLData.h"

@protocol FFLWorkTableViewDelegate
- (void) detalShow:(NSArray *) item;
@end

@interface FFLWorkTableView : UIView<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *dataTable;
}
@property (nonatomic, strong) UITableView *workTableView;

-(NSArray *) getData:(NSString *) url;
-(void) setDataTable;
-(void) reloadDataTable;
-(float) stringHeight:(NSString *) text;
@property (nonatomic, weak) id<FFLWorkTableViewDelegate> delegate;
@end
