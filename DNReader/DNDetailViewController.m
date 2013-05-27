//
//  DNDetailViewController.m
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNDetailViewController.h"

@interface DNDetailViewController ()
- (void)configureView;
@end

@implementation DNDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
	if (self.detailItem) {
	    self.title = self.detailItem.storyTitle;
		self.webview.scalesPageToFit = YES;

	}
	
	
}

-(void)viewWillAppear:(BOOL)animated
{
	[self loadPage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//	[self configureView];
}

-(void)loadPage
{
	if (self.detailItem) {
		
		NSString *urlString = self.detailItem.sourceURL;
		if (![urlString hasPrefix:@"http://"] &&  ![urlString hasPrefix:@"https://"]) {
			if ([urlString hasPrefix:@"/stories/"]) {
				urlString = [NSString stringWithFormat:@"https://news.layervault.com%@", urlString];
			}else{
				urlString = @"https://news.layervault.com/404";
			}

		}
		
		NSURL *url = [[NSURL alloc] initWithString:self.detailItem.sourceURL];
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		
		[self.webview loadRequest:requestObj];
		
	}}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
- (IBAction)refreshButtonTapped:(id)sender {
	[self.webview reload];
}

- (IBAction)webBackTapped:(id)sender {
	[self.webview goBack];
}

- (IBAction)shareButtonTapped:(id)sender {
	
	NSURL *shareURL = [NSURL URLWithString:self.detailItem.sourceURL];
	
	NSString *textToShare = @"Look what I've found on DesignerNews… ";
	NSArray *activityItems = @[textToShare, shareURL];

	
	UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
	activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAssignToContact,UIActivityTypeCopyToPasteboard];
	[activityVC setCompletionHandler:^(NSString *activityType, BOOL completed){
		if (completed) {
			NSLog(@"Shared to %@", activityType);
#ifdef TESTFLIGHT
			[TestFlight passCheckpoint:@"Share – Completed sharing"];
#endif
		}
	}];
	
	[self presentViewController:activityVC animated:TRUE completion:nil];

}
@end
