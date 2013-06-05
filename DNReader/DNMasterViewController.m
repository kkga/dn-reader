//
//  DNMasterViewController.m
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//


#import "DNMasterViewController.h"
#import "DNCrawler.h"
#import "DNStory.h"
#import "DNDetailViewController.h"
#import "DNCell.h"
#import "DNNavSelector.h"
#import "SVProgressHUD.h"
#import "DNCommentsViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface DNMasterViewController () {

}
@property (nonatomic, strong) NSMutableArray *stories;
@property (nonatomic, strong) DNNavSelector *titleView;
@property (nonatomic) int pagesLoaded;
@end

@implementation DNMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = [[DNList sharedInstance]currentListTitle];
		_pagesLoaded = 1;
		_stories = [[NSMutableArray alloc]init];
		_titleView = [[DNNavSelector alloc]initWithTitle:[[DNList sharedInstance] currentListTitle]];
		_titleView.delegate = self;
		self.navigationItem.titleView = _titleView;
		_allowSelection = YES;
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
	
}

-(void)viewDidAppear:(BOOL)animated
{
	[_titleView setPressed:NO];
	[self updateListSelection];
	
}


-(void)refreshPulled
{
	NSLog(@"Refreshing");
	[self.refreshControl beginRefreshing];
	_pagesLoaded = 1;
	[self refreshForPage:1];
}

-(void)updateListSelection
{
	if(_currentList != [[DNList sharedInstance]currentList]){
		_currentList = [[DNList sharedInstance]currentList];
		self.title = [[DNList sharedInstance] currentListTitle];
		[self.titleView.titleButton setTitle: [[DNList sharedInstance]currentListTitle] forState:UIControlStateNormal];
		[_stories removeAllObjects];
		[self.tableView reloadData];
		[self refreshPulled];
	}
	[self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

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
	CGSize size = [[[_stories objectAtIndex:indexPath.row] storyTitle] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17] constrainedToSize:CGSizeMake(self.view.frame.size.width - 50, 9999) lineBreakMode:NSLineBreakByWordWrapping];
	
	return size.height + 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DNCell";
     
    DNCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DNCell alloc] init];
    }

	DNStory *story = [_stories objectAtIndex:indexPath.row];

	cell.storyTitle.text = story.storyTitle;
	[cell.storyTitle sizeToFit];
	
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
	[cell.username sizeToFit];
	
	if (story.numberOfPoints) {
		cell.points.text = story.numberOfPoints;
	}else{
		cell.points.text = @"";
	}
	
	if (story.numberOfComments) {
		cell.comments.text = [NSString stringWithFormat:@"∙ %@",story.numberOfComments];
	}else{
		cell.comments.text = @"";
	}
	
	if (story.timestamp) {
		cell.timestamp.text = [NSString stringWithFormat:@"∙ %@",story.timestamp];
	}else{
		cell.timestamp.text = @"";
	}
	
	if ([DNCrawler isRead:story]) {
		[cell.storyTitle setTextColor:[UIColor DNGrayColor]];
	}else{
		[cell.storyTitle setTextColor:[UIColor DNLightBlueColor]];
	}
    
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	cell.badgeView.backgroundColor = [story badgeColor];
	
	
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_stories removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (_allowSelection) {
		
		DNStory *currentStory = [_stories objectAtIndex:indexPath.row];
		
		[DNCrawler markRead:currentStory];
		
		if ([currentStory.commentsURL isEqual:currentStory.storyURL]) {
			DNCommentsViewController *commentsView = [[DNCommentsViewController alloc]initWithNibName:nil bundle:nil];
			commentsView.story = currentStory;
			[self.navigationController pushViewController:commentsView animated:YES];
		}else{
			DNDetailViewController *detailViewController = [[DNDetailViewController alloc] initWithURL:currentStory.storyURL];
			detailViewController.story = currentStory;
			[self.navigationController pushViewController:detailViewController animated:YES];
			
		}
	}
}



-(void)refreshForPage: (int) pageNumber
{
	[self.refreshControl beginRefreshing];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
	
		NSArray *newStories = [[DNCrawler sharedInstance] storiesOfType:_currentList forPage:pageNumber];
		
		if (pageNumber == 1) {
			_stories = [newStories mutableCopy];
		}else{
			[_stories addObjectsFromArray:newStories];
		}
		

		
		NSLog(@"%i stories", [_stories count]);
		_pagesLoaded++;
	
		dispatch_sync(dispatch_get_main_queue(), ^(void) {
		
			NSLog(@"Done");
			[self.tableView reloadData];
			[self.refreshControl endRefreshing];
			[SVProgressHUD dismiss];
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
