//
//  DNNavSelector.m
//  DNReader
//
//  Created by Flo Gehring on 03.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "DNNavSelector.h"
#import <QuartzCore/QuartzCore.h>
#import "DNMenuViewController.h"
#import "UIImage+Blur.h"
@interface DNNavSelector()
@property (nonatomic) BOOL isSelected;
@property (nonatomic, strong) UIImage *activeButtonBackground;
@end

@implementation DNNavSelector


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		_activeButtonBackground = [[UIImage imageNamed:@"titlePressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 15, 14, 15)];
	}
    return self;
}

-(id)initWithTitle:(NSString *)title
{
	self = [self initWithFrame:CGRectMake(0, 0, 320, 44)];
    if (self) {
        // Initialization code
//		self.backgroundColor = [UIColor colorWithWhite:0.721 alpha:1.000];
		
//		self.titleButton.titleLabel.text = title;
		[self.titleButton setTitle:title forState:UIControlStateNormal];
//		[self.titleButton setTitle:@"Pressed" forState:UIControlStateHighlighted];
		[self addSubview:self.titleButton];
		
    }
    return self;
}

-(UIButton *)titleButton
{
	if(!_titleButton){
		_titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		
		
		[_titleButton setBackgroundImage:_activeButtonBackground forState:UIControlStateHighlighted];
		
		UILabel *titleLabel = _titleButton.titleLabel;
		titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
		titleLabel.textAlignment = NSTextAlignmentCenter;
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.shadowColor = [UIColor blackColor];
		titleLabel.shadowOffset = CGSizeMake(0, -1);
		_titleButton.frame = CGRectMake(83, 7, 150, 30);
		[_titleButton addTarget:self action:@selector(titleButtonTouchUp) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
		[_titleButton addTarget:self action:@selector(titleButtonTouchDown) forControlEvents:UIControlEventTouchDown];
		
		UIImageView *triangle = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"triangle"]];
		triangle.frame = CGRectMake(_titleButton.frame.size.width-triangle.frame.size.width-22, 12, triangle.frame.size.width, triangle.frame.size.height);
		
		[_titleButton addSubview:triangle];

	}
	return _titleButton;
}

-(void)setPressed: (BOOL) pressed
{
	if (pressed) {
		[_titleButton setBackgroundImage:_activeButtonBackground forState:UIControlStateNormal];
//		self.titleButton.backgroundColor = [UIColor colorWithRed:0.079 green:0.166 blue:0.304 alpha:1.000];
//		self.titleButton.layer.borderWidth = 1;
//		self.titleButton.layer.borderColor = [UIColor colorWithRed:0.970 green:0.923 blue:0.958 alpha:1.000].CGColor;
//		self.titleButton.layer.cornerRadius = 15;
	}else{
		[_titleButton setBackgroundImage:nil forState:UIControlStateNormal];
//		self.titleButton.backgroundColor = [UIColor clearColor];
//		self.titleButton.layer.borderWidth = 0;
//		self.titleButton.layer.borderColor = [UIColor clearColor].CGColor;
	}
}

-(void)titleButtonTouchDown
{
	[self setPressed:YES];
	
}

-(void)titleButtonTouchUp
{
//	NSLog(@"Up");

	
	if ([[[self.delegate.navigationController viewControllers] objectAtIndex:0] class] != [DNMenuViewController class]) {
		
		//Take a screenshot for the "transparent" background of the menu

		DNMenuViewController *menuVC = [[DNMenuViewController alloc]init];
		UITableView *list = menuVC.tableView;

		dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
			
			
			//Non retina size is ok (blur + performance)
//			if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
//				UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, [UIScreen mainScreen].scale);
//			else
			UIGraphicsBeginImageContext(self.window.bounds.size);
			[self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
			UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
			CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);
			CGContextFillRect(UIGraphicsGetCurrentContext(), self.window.bounds);
			
			float verticalShift = -64;
			[image drawInRect:CGRectMake(0, verticalShift, image.size.width, image.size.height) blendMode:kCGBlendModeNormal alpha:.5];
			image = UIGraphicsGetImageFromCurrentImageContext();
			
//			image = [image blur];
			UIGraphicsEndImageContext();

			
			dispatch_async( dispatch_get_main_queue(), ^{
				menuVC.backgroundImage = image;

				[list setTag:1];
				float scrollOffset = ((DNMasterViewController *)self.delegate).tableView.contentOffset.y;

				list.transform = CGAffineTransformMakeTranslation(0, scrollOffset - list.frame.size.height - 30 );
				[self.delegate.view  addSubview:list];
				
				[UIView animateWithDuration:.2
									  delay:0
									options:UIViewAnimationOptionCurveEaseOut
								 animations:^() {

									list.transform = CGAffineTransformMakeTranslation(0, scrollOffset);

								 } completion:^(BOOL success){
									 UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:menuVC];
										[self.delegate presentViewController:navC animated:NO completion:^(){
											[[self.delegate.view viewWithTag:1] removeFromSuperview];
											[self setPressed:NO];
										}];
								 }];
				});
		});

		

	}else{
		[(DNMenuViewController *)self.delegate close];
	}
	


	
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
