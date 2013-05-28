//
//  DNMasterViewController.m
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//


#import "DNMasterViewController.h"
#import "HTMLParser.h"
#import "DNStory.h"
#import "DNDetailViewController.h"
#import "DNCell.h"
#import <QuartzCore/QuartzCore.h>
@interface DNMasterViewController () {

}
@property (nonatomic, strong) NSMutableArray *stories;
@property (nonatomic) int pagesLoaded;
@end

@implementation DNMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"DN – Popular";
		_pagesLoaded = 1;
		_stories = [[NSMutableArray alloc]init];
		
		
		
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UINavigationBar *navBar =  self.navigationController.navigationBar;
	navBar.layer.masksToBounds = NO;
	[navBar.layer setShadowColor:[UIColor blackColor].CGColor];
	[navBar.layer setShadowOffset:(CGSize){0,2}];
	[navBar.layer setShadowOpacity:.25];
	
	
	
	_currentList = kDNStoryListTypePopular;
	
	UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
	[refreshControl addTarget:self action:@selector(refreshPulled) forControlEvents:UIControlEventValueChanged];
	self.refreshControl = refreshControl;
	
	[self refreshPulled];
	
	
	[self.tableView registerNib:[UINib nibWithNibName:@"DNCell" bundle:nil] forCellReuseIdentifier:@"DNCell"];
	
	UISwipeGestureRecognizer *swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchList)];
	[self.navigationController.navigationBar addGestureRecognizer:swiper];

}


-(void)refreshPulled
{

	[self.refreshControl beginRefreshing];
	_pagesLoaded = 1;
	[self refreshForPage:1];
}

-(void)switchList
{
	NSLog(@"Switch the list");
	if (_currentList == kDNStoryListTypePopular) {
		_currentList = kDNStoryListTypeRecent;
		self.title = @"DN – Recent";
	}else{
		_currentList = kDNStoryListTypePopular;
		self.title = @"DN – Popular";
	}
	
	[self refreshPulled];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _stories.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 115;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DNCell";
     
    DNCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DNCell alloc] init];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

	DNStory *story = [_stories objectAtIndex:indexPath.row];

	cell.storyTitle.text = story.storyTitle;
	
	if (story.domain) {
		cell.domain.text = [NSString stringWithFormat:@"∙ %@",story.domain];
	}else{
		cell.domain.text = @"";
	}

	if (story.username) {
		cell.username.text = story.username;
	}else{
		cell.username.text = @"";
	}
	
	if (story.points) {
		cell.points.text = story.points;
	}else{
		cell.points.text = @"";
	}
	
	if (story.comments) {
		cell.comments.text = [NSString stringWithFormat:@"∙ %@",story.comments];
	}else{
		cell.comments.text = @"";
	}
	
	if (story.timestamp) {
		cell.timestamp.text = [NSString stringWithFormat:@"∙ %@",story.timestamp];
	}else{
		cell.timestamp.text = @"";
	}
    
	
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_stories removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	DNStory *story = [_stories objectAtIndex:indexPath.row];
    if (!self.detailViewController) {
				
        self.detailViewController = [[DNDetailViewController alloc] initWithAddress:@"about:blank"];
    }
	
	NSString *urlString = story.sourceURL;
	if (![urlString hasPrefix:@"http://"] &&  ![urlString hasPrefix:@"https://"]) {
		if ([urlString hasPrefix:@"/stories/"]) {
			urlString = [NSString stringWithFormat:@"https://news.layervault.com%@", urlString];
		}else{
			urlString = @"https://news.layervault.com/404";
		}
		
	}
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	story.targetURL = url;
	
    self.detailViewController.detailItem = story;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}


-(void)refreshForPage: (int) pageNumber
{
	[self.refreshControl beginRefreshing];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
	
		NSError *error = nil;
		NSString *urlString = @"https://news.layervault.com/";
		
		if (_currentList == kDNStoryListTypeRecent)
			urlString = [urlString stringByAppendingString:@"new/"];
		if(_currentList == kDNStoryListTypePopular)
			urlString = [urlString stringByAppendingString:@"p/"];
		
		
		if (pageNumber == 1) {
			[_stories removeAllObjects];
		}
		urlString = [urlString stringByAppendingFormat:@"%i",pageNumber];
		
		NSLog(urlString);
		NSURL * url = [NSURL URLWithString:urlString];
		NSStringEncoding * encoding = nil;
		NSString * htmlContent = [NSString stringWithContentsOfURL:url usedEncoding:encoding error:&error];
		
		
		HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlContent error:&error];
		
		if (error) {
			NSLog(@"Error: %@", error);
			return;
		}
		
		HTMLNode *bodyNode = [parser body];
		
		
		NSArray *listItems = [bodyNode findChildrenOfClass:@"Story"];
		NSLog(@"%i", [listItems count]);
//		_stories = [NSMutableArray arrayWithCapacity:[listItems count]];
		
		for (HTMLNode *li in listItems) {
			DNStory *story = [DNStory new];
			story.sourceURL = [[li findChildOfClass:@"StoryUrl"] getAttributeNamed:@"href"];
			story.storyTitle = [[li findChildOfClass:@"StoryUrl"] contents];
			story.username = [[li findChildOfClass:@"Submitter"] contents];
			story.domain = [[li findChildOfClass:@"Domain"] contents];
			[_stories addObject:story];
			
			story.comments = [[li findChildOfClass:@"CommentCount"] contents];
			story.points = [[li findChildOfClass:@"PointCount"]contents];
			story.timestamp = [[li findChildOfClass:@"Timeago"] contents];
		}
		
		NSLog(@"%i stories", [_stories count]);
		_pagesLoaded++;
	
		dispatch_sync(dispatch_get_main_queue(), ^(void) {
		
			NSLog(@"Done");
			[self.tableView reloadData];
			[self.refreshControl endRefreshing];
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		
		});
	});
	
}

#pragma mark –
#pragma mark – UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - (750);
    if (actualPosition >= contentHeight && !self.refreshControl.isRefreshing ) {
        [self refreshForPage: _pagesLoaded];
        [self.tableView reloadData];
	}
}

@end
