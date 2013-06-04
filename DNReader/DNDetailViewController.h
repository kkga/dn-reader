//
//  DNDetailViewController.h
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//
#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>
#import "DNStory.h"

enum {
    SVWebViewControllerAvailableActionsNone             = 0,
    SVWebViewControllerAvailableActionsOpenInSafari     = 1 << 0,
    SVWebViewControllerAvailableActionsMailLink         = 1 << 1,
    SVWebViewControllerAvailableActionsCopyLink         = 1 << 2,
    SVWebViewControllerAvailableActionsOpenInChrome     = 1 << 3
};
typedef NSUInteger SVWebViewControllerAvailableActions;

typedef enum {
    kDNDetailViewTypeStory,
    kDNDetailViewTypeComments
    
} DNDetailViewType;


@interface DNDetailViewController : UIViewController

@property (nonatomic, readwrite) SVWebViewControllerAvailableActions availableActions;
@property (strong, nonatomic) DNStory *story;


- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;
- (void)loadURL:(NSURL*)URL;

@end
