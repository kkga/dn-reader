//
//  DNCommentsViewController.h
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNStory.h"
@interface DNCommentsViewController : UITableViewController
@property (strong, nonatomic) DNStory *story;
@end