//
//  MoviesList.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MoviesFetcher;

@protocol MoviesFetcherDelegate <NSObject>
//Calls when fetching is successful
-(void) moviesFetcher:(MoviesFetcher*) moviesFetcher fetchedMovies:(NSArray*) movies;
//Calls when fetching is failed
-(void) moviesFetcherFetchFailure:(MoviesFetcher*) moviesFetcher;
@end

@interface MoviesFetcher : NSObject
{
    NSOperationQueue * queue;
}
@property (weak, nonatomic) NSObject<MoviesFetcherDelegate>* delegate;

//Holds last fetched movies
@property (strong, nonatomic) NSArray * fetchedMovies;

//Fetches Top Ten Box Office movies
-(void) fetchTopTenBoxOfficeMovies;
@end
