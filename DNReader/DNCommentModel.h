//
//  DNCommentsModel.h
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNCommentModel : NSObject
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *iconPath;
@property (nonatomic, strong) NSString *profilePath;
@property (nonatomic, strong) NSString *numberOfPoints;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) int nestingLevel;
@end
