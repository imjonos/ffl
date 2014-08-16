//
//  FFLDetailController.m
//  FFL
//
//  Created by NOs on 05.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import "FFLDetailController.h"
#import "NSString+HTML.h"
@interface FFLDetailController ()

@end

@implementation FFLDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithItem:(NSArray *) item
{
    itemData=[[NSArray alloc] initWithArray:item copyItems:YES];
    self = [super init];
    if (self) {
       
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addAcc = [[UIBarButtonItem alloc]
                               initWithTitle:@"Отправить"
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(sendByEmail)];
    
    /*UIBarButtonItem *delAcc = [[UIBarButtonItem alloc]
                               initWithTitle:@"Отправить"
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(sendByEmail)];*/
    
    NSArray *arrBtns = [[NSArray alloc]initWithObjects:addAcc, nil];
    self.navigationItem.rightBarButtonItems = arrBtns;
    
    self.navigationController.navigationBar.topItem.title=[itemData objectAtIndex:0];
   // GsminformServer *server=[[GsminformServer alloc] init];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    // Initialization code
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(screenWidth/2-100, screenHeight/2+screenHeight/5+50, 200, screenHeight/10); // position in the parent view and set the size of the button
    UITextView *text=[[UITextView alloc] initWithFrame:CGRectMake(0, screenHeight/8.8, screenWidth, screenHeight-screenHeight/3.3)];
    [text setEditable:NO];
    [text setFont:[UIFont systemFontOfSize:16]];
    text.textAlignment = NSTextAlignmentJustified;
    
        [myButton setTitle:@"На сайте" forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(openUrlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //text.text=[NSString stringWithFormat:@"%@",[itemData objectAtIndex:3]];
        NSString *strText= [NSString stringWithFormat:@"%@",[itemData objectAtIndex:3]];
    NSString *strTextNew=[[[strText stringByStrippingTags] stringByRemovingNewLinesAndWhitespace] stringByDecodingHTMLEntities];
    text.text=strTextNew;
    
    [self.view addSubview:myButton];
    [self.view addSubview:text];
    
    
   // NSLog(@"%@",itemData);
	// Do any additional setup after loading the view.
}

- (void) sendByEmail{
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:[itemData objectAtIndex:0]];
        [mailViewController setMessageBody:[itemData objectAtIndex:1] isHTML:NO];
        [self presentViewController:mailViewController animated:YES completion:NULL];
       
        
    }
    
    else {
        
        NSLog(@"Device is unable to send email in its current state");
        
    }

}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled"); break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved"); break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent"); break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]); break;
        default:
            break;
    }
    
    // close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void) openUrlButtonClick:(id) sender{
    FFLWebViewController *webViewController = [[FFLWebViewController alloc] initWithNibName:Nil bundle:Nil];
    NSString *url=[itemData objectAtIndex:1];
    [webViewController setUrl:url];
    [self.navigationController pushViewController:webViewController animated:YES];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
