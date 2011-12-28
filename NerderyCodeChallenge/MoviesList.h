//
//  MoviesList.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MoviesList;

@protocol MoviesListDelegate <NSObject>
-(void) moviesList:(MoviesList*) moviesList fetchedMovies:(NSArray*) movies;
-(void) moviesListFetchFailure:(MoviesList*) moviesList;

@end

@interface MoviesList : NSObject
{
    NSOperationQueue * queue;
}
@property (weak, nonatomic) NSObject<MoviesListDelegate>* delegate;
@property (strong, nonatomic) NSArray * fetchedMovies;
-(void) fetchTopTenBoxOfficeMovies;
@end
