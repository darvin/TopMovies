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

//Detail item - current movie
@property (strong, nonatomic) id detailItem;

//WebView with movie descrition
@property (strong, nonatomic) IBOutlet UIWebView * movieDescription;

//Movie poster - better to place in WebView, really. Just for code challenge requirement to have UIScrollView
@property (strong, nonatomic) IBOutlet UIImageView * moviePoster;

//Main UIScrollView
@property (strong, nonatomic) IBOutlet UIScrollView * scrollView;

//Tweet button
-(IBAction)tweet:(id)sender;

@end
