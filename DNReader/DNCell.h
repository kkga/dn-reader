//
//  DNCell.h
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "DNBadgeView.h"
@interface DNCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storyTitle;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *domain;
@property (weak, nonatomic) IBOutlet UILabel *metaInfo;
@property (weak, nonatomic) IBOutlet DNBadgeView *badgeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *badgeViewWidthConstraint;

-(void)markRead:(BOOL) read;

@end
