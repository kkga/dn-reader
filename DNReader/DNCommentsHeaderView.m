//
//  DNCommentsHeaderView.m
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNCommentsHeaderView.h"

@implementation DNCommentsHeaderView

-(void)awakeFromNib
{
	[super awakeFromNib];
	UIColor *gray = [UIColor DNGrayColor];
	_timestamp.textColor = gray;
	_username.textColor = gray;
	
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"DNCommentsHeaderView" owner:self options:nil] objectAtIndex:0];
		self.frame = frame;
//        [self addSubview:self.view];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
