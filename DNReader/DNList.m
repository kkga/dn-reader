//
//  DNList.m
//  DNReader
//
//  Created by Flo Gehring on 04.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNList.h"

@implementation DNList

+(instancetype) sharedInstance
{
	static DNList *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
		sharedInstance.currentList = kDNStoryListTypePopular;
    });
    return sharedInstance;
}

-(NSString *)currentListTitle
{
	return [self titleForListType:_currentList];
}

-(NSArray *)listTypes
{
	if (!_listTypes) {
		_listTypes = [NSArray arrayWithObjects: [self titleForListType: kDNStoryListTypePopular],
												[self titleForListType: kDNStoryListTypeRecent], nil];
	}
	return _listTypes;
}

-(NSString *)titleForListType: (DNStoryListType) type
{
	switch (type) {
		case kDNStoryListTypePopular:
			return @"Popular";
			break;
		case kDNStoryListTypeRecent:
			return @"Recent";
		default:
			return @"";
			break;
	}
}
@end
