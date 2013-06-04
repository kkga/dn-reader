//
//  DNCommentPageModel.h
//  DNReader
//
//  Created by Flo Gehring on 31.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNCommentPageModel : DNStory
@property (nonatomic, strong) NSString *storyBody;
@property (nonatomic, strong) NSArray *comments;
-(id)initWithStory: (DNStory *) story;
@end
