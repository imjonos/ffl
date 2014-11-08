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

-(float) stringHeight:(NSString *) text{
    CGFloat width =290;
    UIFont *font =[UIFont boldSystemFontOfSize:16];
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
    // Initialization code
    self.view.backgroundColor=[UIColor whiteColor];
    
    NSString *title = [itemData objectAtIndex:0];
    float height = [self stringHeight:title];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 290, height)];
    
    titleLabel.text = title;
    titleLabel.font=[UIFont boldSystemFontOfSize:16];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //NSLog(@"%@",itemData);
    
    UITextView *text=[[UITextView alloc] initWithFrame:CGRectMake(0, 70 + height, screenWidth, self.view.frame.size.height-180-height )];
    [text setEditable:NO];
    [text setFont:[UIFont systemFontOfSize:16]];
    //text.textAlignment = NSTextAlignmentJustified;
    
    UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-100, self.view.frame.size.height-95, 200, 35)];
    [myButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forState: UIControlStateNormal];
    
    //[myButton setBackgroundColor:[UIColor blueColor]];
    [myButton setBackgroundColor:[UIColor colorWithRed:92.0/255.0 green:172.0/255.0 blue:248.0/255.0 alpha:1.0]];
    [myButton setTitle:@"На сайте" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(openUrlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    myButton.layer.cornerRadius = 5; // this value vary as per your desire
    myButton.clipsToBounds = YES;
    [[myButton layer] setBorderWidth:1.0f];
    [[myButton layer] setBorderColor:[UIColor colorWithRed:92.0/255.0 green:172.0/255.0 blue:248.0/255.0 alpha:0.5].CGColor];
        //text.text=[NSString stringWithFormat:@"%@",[itemData objectAtIndex:3]];
    
    NSString *strText= [NSString stringWithFormat:@"%@",[itemData objectAtIndex:3]];
    NSString *strTextNew=[[[strText stringByStrippingTags] stringByRemovingNewLinesAndWhitespace] stringByDecodingHTMLEntities];
    text.text=strTextNew;
    
    [self.view addSubview:myButton];
    [self.view addSubview:text];
    [self.view addSubview:titleLabel];
    
    
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
