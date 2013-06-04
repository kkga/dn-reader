//
//  UIImage+Blur.m
//  DNReader
//
//  Created by Flo Gehring on 03.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import "UIImage+Blur.h"
#import <CoreImage/CoreImage.h>
@implementation UIImage (Blur)
-(UIImage *)blur
{
	CIImage *adjustedImage = [CIImage imageWithCGImage:self.CGImage];
	CGRect rect = [adjustedImage extent];
	
	
	CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
	[blurFilter setDefaults];
	[blurFilter setValue:adjustedImage forKey:@"inputImage"];
	[blurFilter setValue:[NSNumber numberWithFloat:1] forKey:@"inputRadius"];
	adjustedImage = [blurFilter outputImage];

	
	CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [context createCGImage:adjustedImage fromRect:rect];
	UIImage *result = [UIImage imageWithCGImage:cgimg];
	CGImageRelease(cgimg);
	return result;
}
- (UIImage *)imageWithGaussianBlur
{
    float weight[5] = {0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 0.0162162162};
	
	// blur horizontally
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0.0, 0.0, self.size.width, self.size.height)
		   blendMode:kCGBlendModePlusLighter
			   alpha:weight[0]];
    for (int x = 1; x < 5; ++x) {
        [self drawInRect:CGRectMake(x, 0.0, self.size.width, self.size.height)
			   blendMode:kCGBlendModePlusLighter
				   alpha:weight[x]];
        [self drawInRect:CGRectMake(-x, 0.0, self.size.width, self.size.height)
			   blendMode:kCGBlendModePlusLighter
				   alpha:weight[x]];
    }
    UIImage *horizontalBlurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	// blur vertically
    UIGraphicsBeginImageContext(self.size);
    [horizontalBlurredImage drawInRect:CGRectMake(0.0, 0.0, self.size.width, self.size.height)
							 blendMode:kCGBlendModePlusLighter
								 alpha:weight[0]];
    for (int y = 1; y < 5; ++y) {
        [horizontalBlurredImage drawInRect:CGRectMake(0.0, y, self.size.width, self.size.height)
								 blendMode:kCGBlendModePlusLighter
									 alpha:weight[y]];
        [horizontalBlurredImage drawInRect:CGRectMake(0.0, -y, self.size.width, self.size.height)
								 blendMode:kCGBlendModePlusLighter
									 alpha:weight[y]];
    }
    UIImage *blurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return blurredImage;
}

@end
