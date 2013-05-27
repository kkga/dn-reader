//
//  DNMasterViewController.h
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DNDetailViewController;

@interface DNMasterViewController : UITableViewController

@property (strong, nonatomic) DNDetailViewController *detailViewController;

@end
