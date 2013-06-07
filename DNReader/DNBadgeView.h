//
//  DNBadgeView.h
//  DNReader
//
//  Created by Flo Gehring on 06.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNBadgeView : UIView
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) NSLayoutConstraint *titleWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *badgeViewWidthConstraint;
-(void)setTitleText:(NSString *) title;
@end
