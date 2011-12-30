//
//  MSMasterViewController.m
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MSMasterViewController.h"

#import "MSDetailViewController.h"
#import "Movie.h"
#import "MoviesFetcher.h"
#import "MovieCell.h"
#import "MovieData.h"

#import "SVProgressHUD.h"

@interface MSMasterViewController()
-(Movie*) movieByIndexPath:(NSIndexPath*) indexPath;
-(void) fetchMovies;
@end

@implementation MSMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize movieFetcher, movies=_movies;
@synthesize showFavorites, favoriteButton;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailViewController = (MSDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    //Fetching movies
    self.movieFetcher = [[MoviesFetcher alloc] init];
    self.movieFetcher.delegate = self;
    [self fetchMovies];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(Movie*) movieByIndexPath:(NSIndexPath*) indexPath {
    return [self.movies objectAtIndex:indexPath.row];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];

    cell.movie = [self movieByIndexPath:indexPath];
    
    cell.favorite.selected =  ([[MovieData movies] containsObject:cell.movie]);
        
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

//Row height = cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
}

//Calls on movies fetch success
-(void) moviesFetcher:(MoviesFetcher *)moviesFetcher fetchedMovies:(NSArray *)movies {
    self.movies = movies;
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
}

//Calls on movies fetch failure
-(void) moviesFetcherFetchFailure:(MoviesFetcher *)moviesFetcher {
    //so we go offline, favorites only
    [self toggleFavorites:self];
    [SVProgressHUD dismissWithError:NSLocalizedString(@"Offline", nil)];
}

//Setting current movie as detailItem of detailViewController 
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie* movie = [self movieByIndexPath:indexPath];
    self.detailViewController.detailItem = movie;
    
}

//Before segue we should prepare a little hack for our tableView:didSelectRowAtIndexPath:
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.detailViewController = (MSDetailViewController *)(segue.destinationViewController);
}


//Toggle favorites/movies list button
-(IBAction)toggleFavorites:(id)sender {
    self.showFavorites = ! self.showFavorites;
    if (!showFavorites) {
        self.title = NSLocalizedString(@"Movies", nil);
        self.favoriteButton.image = [UIImage imageNamed:@"favorites"];
        [self fetchMovies];
    } else {
        self.title = NSLocalizedString(@"Favorites", nil);
        self.favoriteButton.image = [UIImage imageNamed:@"all-movies"];
        self.movies = [MovieData movies];
        [self.tableView reloadData];
    }

}

//Start load indicator and fetching of movies
-(void) fetchMovies {
    [self.movieFetcher fetchTopTenBoxOfficeMovies];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading", nil)];
}



-(IBAction)favoriteButtonClicked:(UIButton*)sender {
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Movie* movie = [self movieByIndexPath:indexPath];
    if ([MovieData toggleSavedMovie:movie]) {
        if (self.showFavorites) {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                                  withRowAnimation:UITableViewRowAnimationFade]; 
        };
        [cell setNeedsDisplay];
    }
}
@end
