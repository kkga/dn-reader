//
//  DNStory.h
//  DN
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNStory : NSObject
@property (nonatomic, strong) NSString *sourceURL;
@property (nonatomic, strong) NSURL *targetURL;
@property (nonatomic, strong) NSString *storyTitle;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) NSString *comments;
@property (nonatomic, strong) NSString *domain;
@end
