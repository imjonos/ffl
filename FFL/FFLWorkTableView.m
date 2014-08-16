//
//  FFLWorkTableView.m
//  FFL
//
//  Created by NOs on 05.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import "FFLWorkTableView.h"

@implementation FFLWorkTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.workTableView=[[UITableView alloc] initWithFrame:frame];
        self.workTableView.dataSource=self;
        self.workTableView.delegate=self;
        [self addSubview:self.workTableView];
        dataTable=[[NSMutableArray alloc] init];
        
        refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
        [self.workTableView addSubview:refreshControl];
        
        
        

        
   //     NSLog(@"%@",dataTable);
        
        
        //tableData=[[FFLData alloc] init];
        //;
        //[tableData query:@"www.fl.ru/rss/all.xml?category=5"];
        //[tableData parseXMLFile:@"http://www.fl.ru/rss/all.xml?category=5"];
        // Initialization code
    }
    return self;
}



-(NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName
{
    NSArray *myArray;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:keyName]){
        NSData *data = [defaults objectForKey:keyName];
        myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    else
        myArray = [[NSArray alloc] init];
    [defaults synchronize];
    return myArray;
}

-(BOOL)Contains:(NSString *)StrSearchTerm on:(NSString *)StrText
{
    return  [StrText rangeOfString:StrSearchTerm options:NSCaseInsensitiveSearch].location==NSNotFound?FALSE:TRUE;
}

-(BOOL) filterArray:(NSMutableArray *)valArray
{
    NSString *title;
    NSString *cat;
    NSString *text;

    title=[valArray objectAtIndex:0];
    cat=[valArray objectAtIndex:4];
    text=[valArray objectAtIndex:3];

    NSArray *filterData = [[NSMutableArray alloc] initWithArray:[self readArrayWithCustomObjFromUserDefaults:@"main"]];
    
    if([filterData count] == 0) return true;
    
    NSLog(@"CNT %lu",(unsigned long)[filterData count]);
    
    for(NSString *dataString in filterData){
        //NSString *sub1 = [title substringFromIndex:NSMaxRange([title rangeOfString:dataString])];
        //NSString *sub2 = [cat substringFromIndex:NSMaxRange([cat rangeOfString:dataString])];
        //NSString *sub3 = [text substringFromIndex:NSMaxRange([text rangeOfString:dataString])];
        if([self Contains:dataString on:title]) return true;
        if([self Contains:dataString on:cat]) return true;
        if([self Contains:dataString on:text]) return true;
        
        //if([sub1 length]!=0 || [sub2 length]!=0 || [sub3 length]!=0) return true;
    }
    
    return false;
}

-(void) addNewValues:(NSString *) fromUrl andTitle:(NSString *) titleString{
    NSArray *dataTable1 = [[NSArray alloc] initWithArray:[self getData:fromUrl] copyItems:YES];
    
    int i=0;
    
    for(NSMutableArray *dataTableItem in dataTable1){
        
        
        if(i>1) {
            NSMutableArray *newDataTableItem = [[NSMutableArray alloc] initWithArray:dataTableItem copyItems:YES];
            [newDataTableItem addObject:titleString];
            //NSLog(@"%@",[newDataTableItem objectAtIndex:0]);
            if([self filterArray:newDataTableItem]==true) [dataTable addObject:newDataTableItem];
        }
        i++;
    }

}

- (void) setRefreshHiddenYes{
  
}

-(void) setDataTable{
    
    
    
    [dataTable removeAllObjects];
    //return;
    //[self.workTableView reloadData];
      [self.workTableView beginUpdates];
      [self.workTableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:YES];
      [self.workTableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:YES];
      [self.workTableView endUpdates];
    
    
    
    [self addNewValues:@"http://www.fl.ru/rss/all.xml" andTitle:@"fl.ru"];
    [self addNewValues:@"http://www.weblancer.net/rss/projects.rss" andTitle:@"weblancer.net"];
    [self addNewValues:@"https://freelance.ru/rss/projects.xml" andTitle:@"freelance.ru"];
    //[self addNewValues:@"https://www.elance.com/r/rss/jobs/q-" andTitle:@"elance.com"];
    
    [dataTable sortUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *dateStr1 = [a objectAtIndex:2];
        NSString *dateStr2 = [b objectAtIndex:2];
        
        NSTimeInterval timeIntervalNow1;
        NSTimeInterval timeIntervalNow2;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        assert(enUSPOSIXLocale != nil);
        
        [dateFormat setLocale:enUSPOSIXLocale];
        
        
        
        [dateFormat setDateFormat:@"EE, Y-M-d HH:mm:ss"];
        
        //[dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        
        NSDate *date1 = [dateFormat dateFromString:dateStr1];
        
        timeIntervalNow1 = [date1 timeIntervalSinceNow];
        
        NSDate *date2 = [dateFormat dateFromString:dateStr2];
        
        timeIntervalNow2 = [date2 timeIntervalSinceNow];
        
        
        
        return timeIntervalNow1 < timeIntervalNow2 ;
    }];
    
    //[alert dismissWithClickedButtonIndex:0 animated:YES];

}

-(void) refreshData{
    [refreshControl beginRefreshing];
    [self setDataTable];
    [self reloadDataTable];
    
    [refreshControl endRefreshing];
}

-(void) reloadDataTable{
    [self.workTableView reloadData];
    
    
    
        
        /*CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromBottom];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [animation setFillMode:kCAFillModeBoth];
        [animation setDuration:.3];
        [[self layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
        */
    
}


-(NSArray *) getData:(NSString *)url{

    // создаем делегат
    FFLData* delegate = [[FFLData alloc] init];;
    
    // адрес RSS-ленты
    NSURL* rssURL =[NSURL URLWithString:url];
    
    // создаем парсер при помощи URL, назначаем делегат и запускаем
    NSXMLParser* parser
    = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
    [parser setDelegate:delegate];
    [parser parse];
    
    // ждем, пока идет загрука и парсинг
    while ( ! delegate.done )
        sleep(1);
    
    //return nil;
    // когда парсинг окончен
    // проверяем была ли ошибка парсинга
    if ( delegate.error == nil ) {
        // если нет то выводим результат
        //NSLog(@"%@",delegate.titles);
        return delegate.titles;
    } else {
        // если была - выводим ошибку
        NSLog(@"Error: %@", delegate.error);
    }
    
    return nil;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *item=[dataTable objectAtIndex:indexPath.row];
    //if(indexPath.row==0)
    NSString *title=[item objectAtIndex:0];
    
    return [self stringHeight:title]+40; // your dynamic height...
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"1");
    return dataTable.count;
}


-(float) stringHeight:(NSString *) text{
    
   
    CGFloat width =270;
    UIFont *font =[UIFont systemFontOfSize:15];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size.height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier =[NSString stringWithFormat:@"ListCell_%ld",(long)indexPath.row];
    
   // if(indexPath.row==0) return nil;
    //NSLog(@"%d",indexPath.row);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
        NSString *title;
        NSString *date;
        NSString *cat;
        NSString *site;
        NSArray *item=[dataTable objectAtIndex:indexPath.row];
        //if(indexPath.row==0)
        title=[item objectAtIndex:0];
        date=[item objectAtIndex:2];
        cat=[item objectAtIndex:4];
        site=[item objectAtIndex:5];
       
        //NSDictionary *listRow=[listArray objectAtIndex:indexPath.row];
        float height=[self stringHeight:title];
        CGRect label1Frame=CGRectMake(7,2, 270,height);
        CGRect label2Frame=CGRectMake(7,height, 290, 26);
        CGRect label3Frame=CGRectMake(7,height+26, 290, 10);
        UILabel *lblTemp;
        
        lblTemp =[[UILabel alloc] initWithFrame:label1Frame];
        lblTemp.tag=1;
        [cell.contentView addSubview:lblTemp];
        //[lblTemp release];
        
        lblTemp =[[UILabel alloc] initWithFrame:label2Frame];
        lblTemp.tag=2;
        [cell.contentView addSubview:lblTemp];
        
        lblTemp =[[UILabel alloc] initWithFrame:label3Frame];
        lblTemp.tag=3;
        [cell.contentView addSubview:lblTemp];
        //[lblTemp release];
        
        UILabel *lblTemp1 = [(UILabel *)[cell viewWithTag:1] init];
        UILabel *lblTemp2 = [(UILabel *)[cell viewWithTag:2] init];
        UILabel *lblTemp3 = [(UILabel *)[cell viewWithTag:3] init];
        
        
        lblTemp1.font=[UIFont systemFontOfSize:15];
        lblTemp1.lineBreakMode = NSLineBreakByWordWrapping;
        lblTemp1.numberOfLines = 0;

        
        lblTemp2.font=[UIFont boldSystemFontOfSize:13];
        lblTemp2.textColor=[UIColor lightGrayColor];
        
        
        lblTemp3.font=[UIFont boldSystemFontOfSize:13];
        lblTemp3.textColor=[UIColor lightGrayColor];
        
       
        // NSLog(@"%@",cat);
      
       
         lblTemp1.text=title;
         lblTemp3.text= [NSString stringWithFormat:@"%@   %@",site,date];
         lblTemp2.text= cat;
        
        
        //cell.textLabel.text =[listRow objectForKey:@"message"];
        cell.backgroundColor=[UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   // }
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    NSArray *item=[dataTable objectAtIndex:indexPath.row];
    [self.delegate detalShow:item];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
