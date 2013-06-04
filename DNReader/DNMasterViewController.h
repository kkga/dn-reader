//
//  DNMasterViewController.h
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNCrawler.h"
#import "DNList.h"
@class DNDetailViewController;



@interface DNMasterViewController : UITableViewController <UIScrollViewDelegate>

@property (strong, nonatomic) DNDetailViewController *detailViewController;
@property (nonatomic) DNStoryListType currentList;

@end
