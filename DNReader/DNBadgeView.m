//
//  DNBadgeView.m
//  DNReader
//
//  Created by Flo Gehring on 06.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNBadgeView.h"
#import <QuartzCore/QuartzCore.h>
@interface DNBadgeView()

@end

@implementation DNBadgeView


-(void)awakeFromNib
{
	// Initialization code
	CGRect labelRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	_title = [[UILabel alloc]initWithFrame:labelRect];
	_title.textColor = [UIColor whiteColor];
	_title.font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:9];
	_title.backgroundColor = [UIColor clearColor];
	_title.textAlignment = NSTextAlignmentCenter;
	_title.lineBreakMode = NSLineBreakByClipping;
	_title.translatesAutoresizingMaskIntoConstraints = NO;

	[self addSubview:_title];
	//		self.layer.masksToBounds = YES;
	self.layer.cornerRadius = 2;
	
	
	_badgeViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self
														 attribute:NSLayoutAttributeWidth
														 relatedBy:NSLayoutRelationEqual
															toItem:nil
														 attribute:NSLayoutAttributeNotAnAttribute
														multiplier:1
														  constant:30];
	[_badgeViewWidthConstraint setPriority:UILayoutPriorityRequired];
	
	_titleWidthConstraint = [NSLayoutConstraint constraintWithItem:self.title
																  attribute:NSLayoutAttributeWidth
																  relatedBy:NSLayoutRelationEqual
																	 toItem:self
																  attribute:NSLayoutAttributeWidth
																 multiplier:1
																   constant:0];
	[_titleWidthConstraint setPriority:UILayoutPriorityRequired];
	
	NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:self
																	   attribute:NSLayoutAttributeCenterX
																	   relatedBy:NSLayoutRelationEqual
																		  toItem:self.title
																	   attribute:NSLayoutAttributeCenterX
																	  multiplier:1
																		constant:0];
	[centerConstraint setPriority:UILayoutPriorityRequired];
	
	[self addConstraints:@[_badgeViewWidthConstraint, _titleWidthConstraint, centerConstraint]];
	
	
	
	

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)setTitleText:(NSString *) title
{
//	if (!title) {
//		title = @" ";
//	}
	_title.text = title;
	
	[_badgeViewWidthConstraint setConstant:[title sizeWithFont:_title.font].width + 8];
	[_titleWidthConstraint setConstant: _badgeViewWidthConstraint.constant];
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
