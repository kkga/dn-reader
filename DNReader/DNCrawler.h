//
//  DNCrawler.h
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNStory.h"
#import "DNCommentPageModel.h"
#import "DNCommentModel.h"
#import "DNList.h"


@interface DNCrawler : NSObject

+(instancetype) sharedInstance;
+(void) markRead:(DNStory *) story;
+(BOOL)isRead:(DNStory *)story;
+(BOOL)load;
+(BOOL)save;

-(NSArray *) storiesOfType:(DNStoryListType)listType forPage:(int) pageNumber;
-(DNCommentPageModel *) commentsForStory:(DNStory *)story;

@end
