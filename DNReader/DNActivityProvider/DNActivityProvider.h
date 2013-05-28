//
//  DNActivityProvider.h
//  DNReader
//
//  Created by Flo Gehring on 28.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNStory.h"
@interface DNActivityProvider : UIActivityItemProvider
@property (nonatomic, strong) DNStory *story;
@end

@interface DNActivityIcon : UIActivity
@end