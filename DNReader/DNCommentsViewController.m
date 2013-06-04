//
//  DNCommentsViewController.m
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNCommentsViewController.h"
#import "DNCommentsCell.h"
#import "DNCrawler.h"
#import "DNCommentsHeaderView.h"
#import "SVProgressHUD.h"
#import "DNDetailViewController.h"

@interface DNCommentsViewController ()
@property (nonatomic, strong) DNCommentPageModel *data;
@property (nonatomic, strong) DNCommentsHeaderView *headerView;
@end

@implementation DNCommentsViewController 

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	
	[self.tableView registerNib:[UINib nibWithNibName:@"DNCommentsCell" bundle:nil] forCellReuseIdentifier:@"DNCommentsCell"];
	
//	_data = [[DNCrawler sharedInstance] commentsForStory:_story];
	
	if ( ! [_story.storyURL isEqual:_story.commentsURL]) {
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeCommentsView:)];
	}
	
	[self refreshComments];

}

-(DNCommentsHeaderView *)headerView
{
	if (!_headerView) {
		CGSize bodySize = [_data.storyBody sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:14] constrainedToSize:CGSizeMake(self.view.frame.size.width - 50, 9999) lineBreakMode:NSLineBreakByWordWrapping];
		CGSize titleSize = [_story.storyTitle sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17] constrainedToSize:CGSizeMake(self.view.frame.size.width - 50, 9999) lineBreakMode:NSLineBreakByWordWrapping];
		float headerHeight = titleSize.height + bodySize.height + 60;
		
		_headerView = [[DNCommentsHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headerHeight)];
		
//		_headerView = [[[NSBundle mainBundle] loadNibNamed:@"DNCommentsHeaderView" owner:_headerView options:nil] objectAtIndex:0];
	}
	_headerView.title.text = _story.storyTitle;
	_headerView.body.text = _data.storyBody;
	_headerView.username.text = _story.username;
	_headerView.timestamp.text = _story.timestamp;
	
	return _headerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _data.comments.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
//	NSString *content = @"Some text and then some \n And another paragraph. \n maybe one more and some longer text like lalala you know exactly what I mean.";
	
	
	CGSize size = [[[_data.comments objectAtIndex:indexPath.row] content]  sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:14] constrainedToSize:CGSizeMake(self.view.frame.size.width - 40, 9999) lineBreakMode:NSLineBreakByWordWrapping];
	
//	NSLog(@"CellHeight: %.f", size.height);
	return size.height + 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DNCommentsCell";
    DNCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DNCommentsCell alloc] init];
    }
    
    // Configure the cell...
	DNCommentModel *comment = [_data.comments objectAtIndex:indexPath.row];
	cell.author.text = comment.author;
	cell.timestamp.text = comment.time;

	cell.points.text = comment.numberOfPoints;
	
	cell.comment.dataDetectorTypes = UIDataDetectorTypeAll;
	cell.comment.delegate = self;
	cell.comment.text = comment.content;
	
//	[cell.comment sizeToFit];
//	cell.comment.backgroundColor = [UIColor lightGrayColor];
	
    return cell;
}

-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
	DNStory *shareable = [[DNStory alloc]init];
	shareable.storyURL = url;
	shareable.commentsURL = url;
	shareable.storyTitle = @"This was linked to on DesignerNews";
	
	DNDetailViewController *browser = [[DNDetailViewController alloc]initWithURL:url];
	browser.story = shareable;
	[self.navigationController pushViewController:browser animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


-(void)closeCommentsView: (id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)refreshComments
{	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
		
		_data = [[DNCrawler sharedInstance]commentsForStory:_story];
		
		
		
		dispatch_sync(dispatch_get_main_queue(), ^(void) {
			
			NSLog(@"Done – %@", _data.numberOfComments);
			
			[SVProgressHUD dismiss];
			[self.tableView reloadData];
			[self.refreshControl endRefreshing];
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
			self.navigationItem.title = _data.numberOfComments;
			self.tableView.tableHeaderView = self.headerView;
			
		});
	});

}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self.tableView reloadData];
//	[self.tableView setNeedsLayout];
}

@end
