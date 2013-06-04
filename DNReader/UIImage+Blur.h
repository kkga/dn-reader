//
//  UIImage+Blur.h
//  DNReader
//
//  Created by Flo Gehring on 03.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)
-(UIImage *)blur;
- (UIImage *)imageWithGaussianBlur;
@end
