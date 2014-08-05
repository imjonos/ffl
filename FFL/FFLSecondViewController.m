//
//  FFLSecondViewController.m
//  FFL
//
//  Created by NOs on 04.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import "FFLSecondViewController.h"

@interface FFLSecondViewController ()

@end

@implementation FFLSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    filterView = [[FFLFilterTableView alloc] initWithFrame:CGRectMake(0,115, self.view.frame.size.width, self.view.frame.size.height-123)];
    filterView.dataSource = self;
    filterView.delegate = self;
    mainFilterData = [[NSMutableArray alloc] initWithArray:[self readArrayWithCustomObjFromUserDefaults:@"main"]];
    
    [self.view addSubview:filterView];
    self.navigationController.navigationBar.topItem.title=@"Фильтр";
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20.0, 30)];
    textField.placeholder = @"Слово для поиска";
    textField.backgroundColor = [UIColor whiteColor];
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.returnKeyType = UIReturnKeyDone;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.tag = 2;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.delegate = self;
    
    [self.view addSubview:textField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
     NSLog(@"%@",mainFilterData);
   // [filterView reloadData];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)dismissKeyboard {
    [textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textFieldD{
    NSLog(@"textFieldShouldBeginEditing");
    textFieldD.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textFieldD{
    NSLog(@"textFieldShouldEndEditing");
    textFieldD.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textFieldD{
    NSLog(@"textFieldDidEndEditing");
    [filterView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textFieldD{
    NSLog(@"textFieldShouldReturn:");
    
    [mainFilterData addObject:[textField text]];
    [self writeArrayWithCustomObjToUserDefaults:@"main" withArray:mainFilterData];
    NSLog(@"%@",mainFilterData);
    [textField setText:@""];
    [textField resignFirstResponder];
    
    
    return YES;
}

-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}

-(NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:keyName];
    NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [defaults synchronize];
    return myArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [mainFilterData count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        //if([mainFilterData count]==1) [mainFilterData removeAllObjects];
        //else
        //[mainFilterData removeObjectAtIndex:indexPath.row];
        //[[[mainFilterData objectAtIndex:indexPath.section] objectForKey:@"ROWS"] removeObjectAtIndex:indexPath.row];
        
        [mainFilterData removeObjectAtIndex:indexPath.row];
        [self writeArrayWithCustomObjToUserDefaults:@"main" withArray:mainFilterData];
        
        
        //if ([mainFilterData count] == 0) {
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        //}
        
        //[tableView reloadData]; // tell table to refresh now
    
   
    
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier =[NSString stringWithFormat:@"ListCell_%d",indexPath.row];
    
    // if(indexPath.row==0) return nil;
    NSLog(@"%d",indexPath.row);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   // NSLog(@"array = %@",mainFilterData);
    //if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.textLabel.text = [mainFilterData objectAtIndex:indexPath.row];
        
    //}
    return cell;
}
@end
