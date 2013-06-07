//
//  DNStory.m
//  DN
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNStory.h"
#import "DNCrawler.h"
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

-(void)setBadgeName:(NSString *)badgeName
{
	_badgeName = badgeName;
	if (!badgeName) {
		_badgeType = kDNBadgeTypeNone;
		return;
	}
	if ([_badgeName isEqualToString:@"Ask"])
		_badgeType = kDNBadgeTypeAsk;

	if ([_badgeName isEqualToString:@"Flat"])
		_badgeType = kDNBadgeTypeFlat;

	if ([_badgeName isEqualToString:@"Discussion"])
		_badgeType = kDNBadgeTypeDiscussion;

	if ([_badgeName isEqualToString:@"Show"])
		_badgeType = kDNBadgeTypeShow;

	if ([_badgeName isEqualToString:@"SiteDesign"])
	{
		_badgeType = kDNBadgeTypeSiteDesign;
		_badgeName = @"Site Design";
	}
		

	if ([_badgeName isEqualToString:@"CSS"])
		_badgeType = kDNBadgeTypeCSS;

	if ([_badgeName isEqualToString:@"Apple"])
		_badgeType = kDNBadgeTypeApple;

	if ([_badgeName isEqualToString:@"Dribbble"])
		_badgeType = kDNBadgeTypeDribbble;

	if ([_badgeName isEqualToString:@"Type"])
		_badgeType = kDNBadgeTypeType;

}

-(UIColor *) badgeColor
{
	switch (_badgeType) {
		case kDNBadgeTypeAsk:
			return [UIColor DNBadgeColorAsk];
			break;
		case kDNBadgeTypeFlat:
			return [UIColor DNBadgeColorFlat];
			break;
		case kDNBadgeTypeDiscussion:
			return [UIColor DNBadgeColorDiscussion];
			break;
		case kDNBadgeTypeShow:
			return [UIColor DNBadgeColorShow];
			break;
		case kDNBadgeTypeSiteDesign:
			return [UIColor DNBadgeColorSiteDesign];
			break;
		case kDNBadgeTypeCSS:
			return [UIColor DNBadgeColorCSS];
			break;
		case kDNBadgeTypeApple:
			return [UIColor DNBadgeColorApple];
			break;
		case kDNBadgeTypeDribbble:
			return [UIColor DNBadgeColorDribbble];
			break;
		case kDNBadgeTypeType:
			return [UIColor DNBadgeColorType];
			break;
		default:
			return [UIColor clearColor];
			break;
	}
}

-(BOOL)isRead
{
	return [DNCrawler isRead:self];
}
-(void)markRead
{
	[DNCrawler markRead:self];
}

@end
