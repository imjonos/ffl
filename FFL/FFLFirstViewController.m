//
//  FFLFirstViewController.m
//  FFL
//
//  Created by NOs on 04.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import "FFLFirstViewController.h"
#import "FFLDetailController.h"
@interface FFLFirstViewController ()

@end

@implementation FFLFirstViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    worksTableView=[[FFLWorkTableView alloc] initWithFrame:CGRectMake(0,35, self.view.frame.size.width, self.view.frame.size.height-123)];
    worksTableView.delegate=self;
    
    
    ///UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:worksTableView] ;
    //[self presentModalViewController:navController animated:YES];
    
    [self.view addSubview:worksTableView];
    self.navigationController.navigationBar.topItem.title=@"Проекты";
    self.navigationItem.rightBarButtonItem = [self refreshBarButtonItem];
    
    [self refreshBarButtonPressed:self];
    
    adView = [[ADBannerView alloc] init];
    adView.delegate = self;
    self.canDisplayBannerAds = YES;
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"29.png"]]];
    self.navigationItem.leftBarButtonItem = item;
  //[self presentViewController:[[UINavigationController alloc] initWithRootViewController:self] animated:YES completion:nil];
   // [self presentedViewController:[[UINavigationController alloc] initWithRootViewController:self] animated:YES completion:nil] ;
	// Do any additional setup after loading the view, typically from a nib.
}


-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"iAdBanner failed %@",error);
    
    
}
-(void) bannerViewDidLoadAd:(ADBannerView *)banner
{
    
    NSLog(@"iAdBanner loaded");
    
    
    
}


-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
   // [worksTableView setDataTable];
   // [worksTableView reloadDataTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) detalShow:(NSArray *)item{
    NSLog(@"ok");
    //self.navigationController.navigationBar.topItem.title=[item objectAtIndex:0];
    FFLDetailController  *FFlDetailController = [[FFLDetailController alloc] initWithItem:item];
    
    FFlDetailController.view.frame=CGRectMake(0,35, self.view.frame.size.width, self.view.frame.size.height-123);
    
    [self.navigationController pushViewController:FFlDetailController animated:YES];
    
}
- (UIBarButtonItem *) refreshBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"refresh.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(refreshBarButtonPressed :)];
}

- (void) refreshBarButtonPressed :(id)sender {
   
    //sleep(3);
    
    [worksTableView setDataTable];
    [worksTableView reloadDataTable];
   
    
    
 }


@end
