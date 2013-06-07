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

typedef enum {
	kDNBadgeTypeNone,
    kDNBadgeTypeAsk,
    kDNBadgeTypeFlat,
	kDNBadgeTypeDiscussion,
	kDNBadgeTypeShow,
	kDNBadgeTypeSiteDesign,
	kDNBadgeTypeCSS,
	kDNBadgeTypeApple,
	kDNBadgeTypeDribbble,
	kDNBadgeTypeType
} DNBadgeType;


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
@property (nonatomic, strong) NSString *badgeName;
@property (nonatomic) DNBadgeType badgeType;

-(void)setStoryURLFromString:(NSString *)relativeStoryURLString;
-(void)setCommentsURLFromString:(NSString *)relativeCommentsURLString;
-(void)markRead;
-(BOOL)isRead;
-(UIColor *) badgeColor;

@end
