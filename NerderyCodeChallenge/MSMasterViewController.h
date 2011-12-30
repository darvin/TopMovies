//
//  MSMasterViewController.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviesFetcher.h"



@class MSDetailViewController;

@interface MSMasterViewController : UITableViewController <MoviesFetcherDelegate>

@property (strong, nonatomic) MSDetailViewController *detailViewController;
@property (strong, nonatomic) MoviesFetcher * movieFetcher;
@property (strong, nonatomic) NSArray* movies;



//Flag is we show saved favorites
@property BOOL showFavorites;

//Toggle favorites/top movie list button
@property (strong, nonatomic) IBOutlet UIBarButtonItem* favoriteButton;
-(IBAction)toggleFavorites:(id)sender;


@end
