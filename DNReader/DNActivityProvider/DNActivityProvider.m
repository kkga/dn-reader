//
//  DNActivityProvider.m
//  DNReader
//
//  Created by Flo Gehring on 28.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNActivityProvider.h"

@implementation DNActivityProvider
- (id) activityViewController:(UIActivityViewController *)activityViewController
          itemForActivityType:(NSString *)activityType
{
//	NSURL *url = self.story.targetURL;
	NSString *title = self.story.storyTitle;
	
	if ( [activityType isEqualToString:UIActivityTypePostToTwitter] )
		return title;
	if ( [activityType isEqualToString:UIActivityTypePostToFacebook] )
		return title;
	if ( [activityType isEqualToString:UIActivityTypeMessage] )
		return title;
	if ( [activityType isEqualToString:UIActivityTypeMail] )
		return title;
	if ( [activityType isEqualToString:UIActivityTypeCopyToPasteboard] )
		return nil;
	return nil;
}
- (id) activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController { return @""; }
@end
