//
//  DNCommentsCell.h
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNCommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *points;

@end
