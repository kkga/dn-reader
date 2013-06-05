//
//  DNCommentsHeaderView.h
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
@interface DNCommentsHeaderView : UIView
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *title;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *body;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIView *separator;

@end
