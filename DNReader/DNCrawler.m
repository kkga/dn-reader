//
//  DNCrawler.m
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNCrawler.h"
#import "HTMLParser.h"

@interface DNCrawler ()
@property (nonatomic, strong) NSMutableDictionary *readStories;
@end

@implementation DNCrawler

//const int kShiftTimeEdit = 10;
//const int kShiftSeparator = 10;


NSString * const kBaseURL = @"https://news.layervault.com/";
NSString * const kURLSuffixRecent = @"new/";
NSString * const kURLSuffixPopular = @"p/";



+(instancetype) sharedInstance
{
	static DNCrawler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
		
		sharedInstance.readStories = [[NSMutableDictionary alloc]init];
		
    });
    return sharedInstance;
}

-(NSArray *)storiesOfType:(DNStoryListType)listType forPage:(int)pageNumber
{
	NSMutableArray *stories = [[NSMutableArray alloc]init];
	
	NSError *error = nil;
	NSString *urlString = kBaseURL;
	
	if (listType == kDNStoryListTypeRecent)
		urlString = [urlString stringByAppendingFormat:@"%@%i",kURLSuffixRecent, pageNumber];
	if(listType == kDNStoryListTypePopular)
		urlString = [urlString stringByAppendingFormat:@"%@%i",kURLSuffixPopular, pageNumber];
	
	

//	urlString = [urlString stringByAppendingFormat:@"%i",pageNumber];
	
	NSLog(@"%@", urlString);
	NSURL * url = [NSURL URLWithString:urlString];
	NSStringEncoding * encoding = nil;
	NSString * htmlContent = [NSString stringWithContentsOfURL:url usedEncoding:encoding error:&error];
//	NSLog(htmlContent);
	
	HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlContent error:&error];
	
	if (error) {
		NSLog(@"Error: %@", error);
//		return;
	}
	
	HTMLNode *bodyNode = [parser body];
	bodyNode = [bodyNode findChildOfClass:@"InnerPage"];
	
	
	NSArray *listItems = [bodyNode findChildTags:@"li"];
	NSLog(@"%i", [listItems count]);
	
	for (HTMLNode *li in listItems) {
		DNStory *story = [DNStory new];
		
		[story setStoryURLFromString:[[li findChildOfClass:@"StoryUrl"] getAttributeNamed:@"href"]];
		
		story.badgeName = [[[li findChildWithAttribute:@"class" matchingName:@"Badge" allowPartial:YES] className] substringFromIndex:6];
		NSLog(@"%@", story.badgeName);
		
		story.storyTitle = [[li findChildOfClass:@"StoryUrl"] contents];
		story.username = [[li findChildOfClass:@"Submitter"] contents];
		story.domain = [[li findChildOfClass:@"Domain"] contents];
		story.numberOfPoints = [[li findChildOfClass:@"PointCount"]contents];
		story.timestamp = [[li findChildOfClass:@"Timeago"] contents];
		
		HTMLNode *commentsLink = [li findChildOfClass:@"CommentCount"];
		[story setCommentsURLFromString:[commentsLink getAttributeNamed:@"href"]];
		story.numberOfComments = [commentsLink contents];
		
		
//		NSLog(@"%@, %@", story.storyTitle, story.storyURL);
		
		[stories addObject:story];
	}
	
	return stories;
}

-(DNCommentPageModel *)commentsForStory:(DNStory *)story
{
	DNCommentPageModel *commentsPage = [[DNCommentPageModel alloc]initWithStory:story];

	
	NSError *error = nil;
	NSLog(@"Parsing comments at %@", story.commentsURL);
	NSStringEncoding * encoding = nil;
	NSString * htmlContent = [NSString stringWithContentsOfURL:story.commentsURL usedEncoding:encoding error:&error];
	htmlContent = [htmlContent stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
	
	HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlContent error:&error];
	
	if (error) {
		NSLog(@"Error: %@", error);
		//		return;
	}
	
	HTMLNode *bodyNode = [parser body];
	
	NSMutableArray *bodyParagraphs = [[NSMutableArray alloc]init];
	[bodyParagraphs addObjectsFromArray:[[bodyNode findChildOfClass:@"StoryBody"]findChildTags:@"p"]];
	
	commentsPage.storyBody = [self concatParagraphs:bodyParagraphs];
	
	NSArray *commentDivs = [[bodyNode findChildWithAttribute:@"id" matchingName:@"Comments" allowPartial:NO] findChildrenWithAttribute:@"class" matchingName:@"Comment NestingLevel" allowPartial:YES];
	NSLog(@"%i comments found.", [commentDivs count]);
	
	
	//Parse the actual comments
	NSMutableArray *comments = [NSMutableArray new];
	for (HTMLNode *div in commentDivs) {
		DNCommentModel *comment = [DNCommentModel new];
		
		HTMLNode *commentWho = [div findChildOfClass:@"CommentWho"];
		comment.author = [[commentWho findChildTag:@"a"]contents];
		comment.time = [[div findChildOfClass:@"Timeago"]contents];
		comment.numberOfPoints = [[div findChildOfClass:@"UpvoteComment"]contents];
		
		NSMutableArray *paragraphs = [[div findChildTags:@"p"] mutableCopy];

		comment.content = [self concatParagraphs:paragraphs];
		
		NSString *nestingLevel = [div className];
		nestingLevel = [nestingLevel substringFromIndex:8];
		comment.nestingLevel = [[nestingLevel substringFromIndex:12] integerValue];

		

		[comments addObject:comment];
	}
	commentsPage.comments = comments;
	
	return commentsPage;
}

-(NSString *)concatParagraphs: (NSArray *) pNodes
{
	//Concat the paragraphs
	NSString *sum = @"";
	for (HTMLNode *p in pNodes) {
		if ([[p contents] length] > 1) {
			sum = [sum stringByAppendingFormat:@"%@ \n", [p contents]];
		}
		NSArray *links = [p findChildTags:@"a"];
		for (HTMLNode *a in links) {
			if ( ! [[a className] isEqual:@"ReplyLink"]) {
				sum = [sum stringByAppendingFormat:@"%@ \n", [a contents]];
			}
		}

	}
//	NSLog(@"%@",sum);
	return sum;
}

-(NSMutableDictionary *)readStories
{
	if (!_readStories) {
		_readStories = [[NSMutableDictionary alloc]init];
	}
	return _readStories;
}

+(void)markRead:(DNStory *)story
{
	if ( ! [[story.storyURL absoluteString] isEqualToString:@"https://news.layervault.com/404"]) {
		NSLog(@"Marking as read \"%@\"", story.storyTitle);
		[[DNCrawler sharedInstance].readStories setObject:[NSNumber numberWithBool: YES] forKey:[story.storyURL absoluteString]];
	}
}

+(BOOL)isRead:(DNStory *)story
{
	if ([[DNCrawler sharedInstance].readStories objectForKey:[story.storyURL absoluteString]])
		return YES;
	else
		return NO;
}

+(BOOL)load
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent: @"readStories.dn"];
	@try {
		[DNCrawler sharedInstance].readStories = [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
		NSLog(@"Loading the read stories dictionary (%i)", [[DNCrawler sharedInstance].readStories count]);
		return YES;
	}
	@catch (NSException *exception) {
		NSLog(@"Archive didn't exist");
		[DNCrawler sharedInstance].readStories = [[NSMutableDictionary alloc] init];
		return NO;
	}
	@finally {
		
	}

}

+(BOOL)save
{
	NSLog(@"Saving the read stories (%i)", [[DNCrawler sharedInstance].readStories count]);
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent: @"readStories.dn"];
	return [NSKeyedArchiver archiveRootObject:[DNCrawler sharedInstance].readStories toFile:filePath];
}

@end
