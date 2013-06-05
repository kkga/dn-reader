//
//  DNPocketAPIActivity.m
//  DNReader
//
//  Created by Flo Gehring on 05.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNPocketAPIActivity.h"
#import "PocketAPI.h"
#import "SVProgressHUD.h"
@implementation DNPocketAPIActivity

{
	NSArray *_URLs;
}

- (NSString *)activityType
{
	return @"Pocket";
}

- (NSString *)activityTitle
{
	return NSLocalizedString(@"Send to Pocket", nil);
}

- (UIImage *)activityImage
{
	return [UIImage imageNamed:@"PocketActivity.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
	for (id activityItem in activityItems) {
		if ([activityItem isKindOfClass:[NSURL class]]) {
			NSURL *pocketURL = [NSURL URLWithString:[[PocketAPI pocketAppURLScheme] stringByAppendingString:@":test"]];
			
			if ([[UIApplication sharedApplication] canOpenURL:pocketURL] || [PocketAPI sharedAPI].loggedIn) {
				return YES;
			}
		}
	}
	
	return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
	NSMutableArray *URLs = [NSMutableArray array];
	
	for (id activityItem in activityItems) {
		if ([activityItem isKindOfClass:[NSURL class]]) {
			[URLs addObject:activityItem];
		}
	}
	
	_URLs = [URLs copy];
}

- (void)performActivity
{
	__block NSUInteger URLsLeft = _URLs.count;
	__block BOOL URLFailed = NO;
	
	[self activityDidFinish:YES];
	
	for (NSURL *URL in _URLs) {
		[[PocketAPI sharedAPI] saveURL:URL handler: ^(PocketAPI *API, NSURL *URL, NSError *error) {
			if (error != nil) {
				URLFailed = YES;
				[SVProgressHUD showErrorWithStatus:@"Could not send to Pocket"];
			}
			
			URLsLeft--;
			
			if (URLsLeft == 0) {
				[SVProgressHUD showSuccessWithStatus:@"Sent to Pocket"];
			}
		}];
	}
}

- (void)dealloc
{
	
}

@end