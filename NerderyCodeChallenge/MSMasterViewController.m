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
#import "MoviesList.h"
#import "MovieCell.h"
#import "MovieData.h"

#import "SVProgressHUD.h"

@interface MSMasterViewController()
-(Movie*) movieByIndexPath:(NSIndexPath*) indexPath;
-(void) fetchMovies;
@end

@implementation MSMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize movieList;
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
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (MSDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    

    
    self.movieList = [[MoviesList alloc] init];
    self.movieList.delegate = self;
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
    if (!self.showFavorites)
        return [self.movieList.fetchedMovies objectAtIndex:indexPath.row];
    else
        return [MovieData savedMovieAtIndex:indexPath.row];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];

    cell.movie = [self movieByIndexPath:indexPath];
    if (self.showFavorites) {
        cell.favorite.selected = YES;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.showFavorites)
        return [self.movieList.fetchedMovies count];
    else
        return [MovieData savedMoviesCount];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
}

-(void) moviesList:(MoviesList*) moviesList fetchedMovies:(NSArray*) movies {
    [self.tableView reloadData];
    [SVProgressHUD dismissWithSuccess:NSLocalizedString(@"Done", nil)];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSIndexPath * firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath: firstRow animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [self tableView:self.tableView didSelectRowAtIndexPath:firstRow];
    }

}
-(void) moviesListFetchFailure:(MoviesList*) moviesList {

    [self toggleFavorites:self];
    [SVProgressHUD dismissWithError:NSLocalizedString(@"Offline", nil)];

}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", self.detailViewController);
    Movie* movie = [self movieByIndexPath:indexPath];
    self.detailViewController.detailItem = movie;
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.detailViewController = (MSDetailViewController *)(segue.destinationViewController);
    
}

-(IBAction)favoriteButtonClicked:(UIButton*)sender {
    sender.selected = !sender.selected;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    Movie* movie = [self movieByIndexPath:indexPath];
    if (sender.selected) {
        [MovieData saveMovie:movie];
    } else {
        [MovieData unsaveMovie:movie];
        if (self.showFavorites) {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                             withRowAnimation:UITableViewRowAnimationFade]; 
        };
    }
}

-(IBAction)toggleFavorites:(id)sender {
    self.showFavorites = ! self.showFavorites;
    if (!showFavorites) {
        self.title = NSLocalizedString(@"Movies", nil);
        self.favoriteButton.image = [UIImage imageNamed:@"star"];
        [self fetchMovies];
    } else {
        self.title = NSLocalizedString(@"Favorites", nil);
        self.favoriteButton.image = [UIImage imageNamed:@"list"];
        [self.tableView reloadData];
    }

}

-(void) fetchMovies {
    [self.movieList fetchTopTenBoxOfficeMovies];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading", nil)];
}

@end
