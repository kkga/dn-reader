//
//  DNStory.m
//  DN
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNStory.h"

@implementation DNStory
-(void)setStoryURLFromString:(NSString *)relativeStoryURLString
{
	_storyURL = [self absoluteDNURLFromString:relativeStoryURLString];
}

-(void)setCommentsURLFromString:(NSString *)relativeCommentsURLString
{
	_commentsURL = [self absoluteDNURLFromString:relativeCommentsURLString];
}

-(NSURL *) absoluteDNURLFromString: (NSString *) relativeURL
{
	NSString *urlString = relativeURL;
	if (![urlString hasPrefix:@"http://"] &&
		![urlString hasPrefix:@"https://"]) {
		
		if ([urlString hasPrefix:@"/stories/"]) {
			urlString = [NSString stringWithFormat:@"https://news.layervault.com%@", urlString];
		}else{
			urlString = @"https://news.layervault.com/404";
		}
	}
	
	return [[NSURL alloc] initWithString:urlString];
}
@end
