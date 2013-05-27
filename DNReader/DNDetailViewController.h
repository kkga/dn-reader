//
//  DNDetailViewController.h
//  DNReader
//
//  Created by Flo Gehring on 27.05.13.
//  Copyright (c) 2013 Flo Gehring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end