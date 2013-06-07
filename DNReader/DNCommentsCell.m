//
//  DNCommentsCell.m
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNCommentsCell.h"

@implementation DNCommentsCell

-(void)awakeFromNib
{
	[super awakeFromNib];
	UIColor *gray = [UIColor DNGrayColor];
	_timestamp.textColor = gray;
	_points.textColor = gray;
	
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
