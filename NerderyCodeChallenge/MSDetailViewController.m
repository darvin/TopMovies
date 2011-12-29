//
//  MSDetailViewController.m
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MSDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MSDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation MSDetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize moviePoster = _moviePoster, movieDescription = _movieDescription, scrollView=_scrollView;
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}



// UIWebViewImplementation
//
//
- (NSString*) getHTMLMovieDescription {
    Movie * movie = (Movie*) self.detailItem;
    NSMutableString * castString = [[NSMutableString alloc] init];
    
    NSUInteger runtimeHours = movie.runtime/60;
    NSUInteger runtimeMinutes = movie.runtime%60;

    
    NSDictionary * movieCast = movie.cast;
    for (NSString* actorName in movieCast) {
        [castString appendFormat:@"%@ as %@<br>", actorName, [movieCast objectForKey:actorName]];
    }
    
    return  [NSString stringWithFormat:@"<b>Synopsis</b><br>%@ <br> <b>Cast</b><br> %@ <hr /> Rated %d • Freshness: %@ • Runtime: %d hr %d min", movie.synopsis, castString, movie.criticsScore, movie.criticsFreshness, runtimeHours, runtimeMinutes];
}

- (void) webViewDidFinishLoad: (UIWebView *)sender {
    [self.movieDescription sizeToFit];
    
    self.scrollView.contentSize = CGSizeMake(self.movieDescription.frame.size.width, self.movieDescription.frame.origin.y+self.movieDescription.frame.size.height);
}

- (void)configureView
{
    if (self.detailItem) {
        Movie * movie = (Movie*) self.detailItem;
        self.title = movie.name;
        [self.moviePoster setImageWithURL: [movie urlPosterWithSize:MoviePosterSizeOriginal]];
        
        [self.movieDescription loadHTMLString:[self getHTMLMovieDescription] baseURL:nil];
    }
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

    [(UIScrollView *) [self.movieDescription.subviews objectAtIndex:0] setAlwaysBounceVertical:NO];

    [self configureView];
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

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
