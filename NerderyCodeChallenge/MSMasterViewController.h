//
//  MSMasterViewController.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSDetailViewController;

@interface MSMasterViewController : UITableViewController

@property (strong, nonatomic) MSDetailViewController *detailViewController;

@end
