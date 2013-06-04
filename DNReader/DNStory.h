//
//  DNStory.h
//  DN
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kDNURLTypeComments,
    kDNURLTypeStory
    
} DNURLType;

@interface DNStory : NSObject
//@property (nonatomic, strong) NSString *sourceURL; // relative URL
@property (nonatomic, strong) NSURL *storyURL;    // absoluteURL
@property (nonatomic, strong) NSURL *commentsURL;  // commentsURL
@property (nonatomic, strong) NSString *storyTitle;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *numberOfPoints;
@property (nonatomic, strong) NSString *numberOfComments;
@property (nonatomic, strong) NSString *domain;

-(void)setStoryURLFromString:(NSString *)relativeStoryURLString;
-(void)setCommentsURLFromString:(NSString *)relativeCommentsURLString;
@end
