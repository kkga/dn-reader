//
//  DNList.h
//  DNReader
//
//  Created by Flo Gehring on 04.06.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kDNStoryListTypePopular,
    kDNStoryListTypeRecent
    
} DNStoryListType;


@interface DNList : NSObject
@property (nonatomic) DNStoryListType currentList;
@property (nonatomic, strong) NSArray *listTypes;

+(instancetype) sharedInstance;

-(NSString *)currentListTitle;
-(NSArray *)listTypes;
-(NSString *)titleForListType: (DNStoryListType) type;
@end
