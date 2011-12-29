//
//  MSMasterViewController.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviesList.h"
@class MSDetailViewController;

@interface MSMasterViewController : UITableViewController <MoviesListDelegate>

@property (strong, nonatomic) MSDetailViewController *detailViewController;
@property (strong, nonatomic) MoviesList * movieList;
-(void) moviesList:(MoviesList*) moviesList fetchedMovies:(NSArray*) movies;
-(void) moviesListFetchFailure:(MoviesList*) moviesList;

-(IBAction)favoriteButtonClicked:(UIButton*)sender;

@end
