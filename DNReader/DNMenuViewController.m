//
//  DNMenuViewController.m
//  DNReader
//
//  Created by Flo Gehring on 03.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNMenuViewController.h"
#import "DNNavSelector.h"
#import "DNList.h"
#import <QuartzCore/QuartzCore.h>
@interface DNMenuViewController ()
@property (nonatomic, strong) NSIndexPath *checkedIndexPath;
@property (nonatomic, strong) DNNavSelector *titleView;

@end

@implementation DNMenuViewController


-(id)initWithBackgroundImage: (UIImage *) image;
{
	self = [super init];
	if (self) {
		self.backgroundImage = image;
	}
	return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

//	UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(close)];
//	self.navigationItem.rightBarButtonItem = closeButton;
	
	
	self.view.backgroundColor = [UIColor clearColor];
	
	_checkedIndexPath = [NSIndexPath indexPathForRow:[[DNList sharedInstance] currentList] inSection:0];
	
	_titleView = [[DNNavSelector alloc]initWithTitle:[[DNList sharedInstance] currentListTitle]];
	_titleView.delegate = self;
	[_titleView setPressed:YES];
	self.navigationItem.titleView = _titleView;
	
	
	CALayer *tableLayer = self.tableView.layer;
	tableLayer.cornerRadius = 10;
	tableLayer.masksToBounds = YES;
	
	CALayer *layer = self.tableView.layer;
	layer.shadowColor = [UIColor blackColor].CGColor;
	layer.shadowOffset = CGSizeMake(0, 2);
	layer.shadowOpacity = .7;
	layer.shadowRadius = 5.0;
	layer.masksToBounds = NO;
	
	UIButton *backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
	backgroundButton.frame = self.view.frame;
	[backgroundButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//	backgroundButton.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
	[self.view addSubview:backgroundButton];
	
	
//	UITapGestureRecognizer *backgroundTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTapped:)];
//	[self. addGestureRecognizer:backgroundTap];
//	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
	CGRect frame = self.tableView.frame;
	frame.origin.y = -30;
	self.tableView.frame = frame;
}

-(void)viewDidAppear:(BOOL)animated
{
	[self.view addSubview:_tableView];
}

-(void)setBackgroundImage:(UIImage *)backgroundImage
{
	_backgroundImage = backgroundImage;
	self.view.backgroundColor = [UIColor colorWithPatternImage:_backgroundImage];
}

-(UITableView *)tableView
{
	if (!_tableView) {
		_tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, -30, 280, 115+30) style:UITableViewStyleGrouped];
		_tableView.scrollEnabled = NO;
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.contentInset = UIEdgeInsetsMake(36, 0, 0, 0);
		
		_tableView.backgroundColor = [UIColor colorWithRed:0.077 green:0.245 blue:0.542 alpha:1.000];
		_tableView.backgroundView = nil;
		
		
		[_tableView setSeparatorColor:[UIColor colorWithRed:0.092 green:0.187 blue:0.340 alpha:1.000]];
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
	}
	return _tableView;
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
    return [[[DNList sharedInstance] listTypes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
		UIImageView *checkmark = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark"]];
		cell.accessoryView = checkmark;
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		cell.backgroundColor = [UIColor colorWithRed:0.120 green:0.356 blue:0.768 alpha:1.000];
		cell.textLabel.textColor = [UIColor colorWithRed:0.714 green:0.741 blue:0.78 alpha:1];
		cell.textLabel.shadowColor = [UIColor colorWithWhite:0.338 alpha:1.000];
		cell.textLabel.shadowOffset = CGSizeMake(0, 1);
		cell.backgroundView = nil;
	}
    
	

	
	if([self.checkedIndexPath isEqual:indexPath])
	{
		[((UIImageView *)cell.accessoryView) setImage:[UIImage imageNamed:@"checkmark"]];
		cell.textLabel.textColor = [UIColor colorWithWhite:1.000 alpha:1.000];
	}
	else
	{
		[((UIImageView *)cell.accessoryView) setImage:nil];
	}
		
	cell.textLabel.text = [[[DNList sharedInstance] listTypes]objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	_checkedIndexPath = indexPath;
	[[DNList sharedInstance] setCurrentList:indexPath.row];
	[self.titleView.titleButton setTitle: [[DNList sharedInstance]currentListTitle] forState:UIControlStateNormal];
	[self.tableView reloadData];
	[self close];
}


-(void)close
{
	
//	_tableView.transform = CGAffineTransformMakeTranslation(0, scrollOffset - list.frame.size.height );
//	[self.delegate.view  addSubview:list];
	
	[UIView animateWithDuration:.2
						  delay:.1
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^() {
						 
						 _tableView.transform = CGAffineTransformMakeTranslation(0, -_tableView.frame.size.height);
						 self.view.backgroundColor = [UIColor whiteColor];
					 } completion:^(BOOL success){
						[self dismissViewControllerAnimated:NO completion:nil];
					 }];
}

@end
