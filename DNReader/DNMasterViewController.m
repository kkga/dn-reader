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

@interface DNMasterViewController () {
    NSMutableArray *_stories;
	int pagesLoaded;
}
@end

@implementation DNMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"DN";
		pagesLoaded = 0;
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
//	self.navigationItem.rightBarButtonItem = refreshButton;
	
	
	UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
	[refreshControl addTarget:self action:@selector(refreshForPage:) forControlEvents:UIControlEventValueChanged];
	self.refreshControl = refreshControl;
	
	[self.tableView registerNib:[UINib nibWithNibName:@"DNCell" bundle:nil] forCellReuseIdentifier:@"DNCell"];

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
    if (!self.detailViewController) {
        self.detailViewController = [[DNDetailViewController alloc] initWithNibName:@"DNDetailViewController" bundle:nil];
    }
    id object = _stories[indexPath.row];
    self.detailViewController.detailItem = object;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}


-(void)refreshForPage: (int) pageNumber
{
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
	
		NSError *error = nil;
		NSURL * url = [NSURL URLWithString:@"https://news.layervault.com/"];
		//	NSError * error;
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
		_stories = [NSMutableArray arrayWithCapacity:[listItems count]];
		
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
	
	
		dispatch_sync(dispatch_get_main_queue(), ^(void) {
		
			NSLog(@"Done");
			[self.tableView reloadData];
			[self.refreshControl endRefreshing];
		
		});
	});
	
}

@end
