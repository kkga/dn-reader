//
//  DNCommentPageModel.m
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//
#import "DNStory.h"
#import "DNCommentPageModel.h"

@implementation DNCommentPageModel 
-(id)initWithStory:(DNStory *)story
{
	self = [super init];
	if (self) {
		self.storyURL = story.storyURL;
		self.commentsURL = story.commentsURL;
		self.username = story.username;
		self.timestamp = story.timestamp;
		self.numberOfComments = story.numberOfComments;
		self.numberOfPoints = story.numberOfPoints;
		self.domain = story.domain;
	}
	return self;
}
@end
