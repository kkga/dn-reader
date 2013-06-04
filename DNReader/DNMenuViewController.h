//
//  DNMenuViewController.h
//  DNReader
//
//  Created by Flo Gehring on 03.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNList.h"
@interface DNMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UITableView *tableView;
-(id)initWithBackgroundImage: (UIImage *) image;
-(void)close;
@end
