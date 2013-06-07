//
//  DNCell.m
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNCell.h"
#import "DNBadgeView.h"
@implementation DNCell

//-(void)awakeFromNib
//{
//	[super awakeFromNib];
//	self.badgeView = [[DNBadgeView alloc]initWithFrame:CGRectMake(5, 5, 30, 12)];
//	self.badgeView.backgroundColor = [UIColor blackColor];
//	[self addSubview:self.badgeView];
	
	
//	NSLayoutConstraint *badgeYAlign = [NSLayoutConstraint constraintWithItem:self.storyTitle
//																	   attribute:NSLayoutAttributeBottom
//																	   relatedBy:NSLayoutRelationEqual
//																		  toItem:self.badgeView
//																	   attribute:NSLayoutAttributeTop
//																	  multiplier:1
//																		constant:0];
//
//	[self addConstraint:badgeYAlign];
	
//	NSLayoutConstraint *badgeAlignTitle = [NSLayoutConstraint constraintWithItem:self.badgeView
//																	   attribute:NSLayoutAttributeLeading
//																	   relatedBy:NSLayoutRelationEqual
//																		  toItem:self.storyTitle
//																	   attribute:NSLayoutAttributeLeading
//																	  multiplier:1
//																		constant:10];
//	
//	[self addConstraint:badgeAlignTitle];
//	
//	NSLayoutConstraint *badgeWidth = [NSLayoutConstraint constraintWithItem:self.badgeView
//																	   attribute:NSLayoutAttributeWidth
//																	   relatedBy:NSLayoutRelationGreaterThanOrEqual
//																		  toItem:nil
//																	   attribute:NSLayoutAttributeNotAnAttribute
//																	  multiplier:1
//																		constant:30];
//	
//	[self addConstraint:badgeWidth];
//
//	NSLayoutConstraint *badgeHeight = [NSLayoutConstraint constraintWithItem:self.badgeView
//																  attribute:NSLayoutAttributeHeight
//																  relatedBy:NSLayoutRelationEqual
//																	 toItem:nil
//																  attribute:NSLayoutAttributeNotAnAttribute
//																 multiplier:1
//																   constant:12];
//	
//	[self addConstraint:badgeHeight];
	

//}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSString *)reuseIdentifier
{
	
	return @"DNCell";
}

-(void)markRead:(BOOL) read
{
	if (read) {
		self.storyTitle.textColor = [UIColor DNGrayColor];
	}else{
		self.storyTitle.textColor = [UIColor DNLightBlueColor];
	}
}


@end
