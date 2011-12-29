//
//  MSDetailViewController.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MSDetailViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate>

@property (strong, nonatomic) id detailItem;


@property (strong, nonatomic) IBOutlet UIWebView * movieDescription;

@property (strong, nonatomic) IBOutlet UIImageView * moviePoster;

@property (strong, nonatomic) IBOutlet UIScrollView * scrollView;

@end
