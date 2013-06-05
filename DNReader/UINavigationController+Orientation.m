//
//  UINavigationController+Orientation.m
//  DNReader
//
//  Created by Flo Gehring on 05.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "UINavigationController+Orientation.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>

@implementation UINavigationController (Orientation)
-(BOOL)shouldAutorotate
{
	if ([self.visibleViewController isKindOfClass:[MPMoviePlayerController class]] ||
		[self.visibleViewController isKindOfClass:[MPMusicPlayerController class]]) {
		return YES;
	}else{
		return NO;
	}
}
@end
