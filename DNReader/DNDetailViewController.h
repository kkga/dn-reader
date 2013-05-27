//
//  DNDetailViewController.h
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNStory.h"
@interface DNDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) DNStory *detailItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)refreshButtonTapped:(id)sender;


@end
