//
//  DNNavSelector.h
//  DNReader
//
//  Created by Flo Gehring on 03.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNMasterViewController.h"
@interface DNNavSelector : UIView
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIViewController *delegate;
-(id)initWithTitle:(NSString *)title;
-(void)setPressed: (BOOL) pressed;
@end
