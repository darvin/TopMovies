//
//  MovieData.m
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieData.h"
#import "AFNetworking.h"
#import "ActorData.h"
@interface MovieData()
-(void) loadPoster:(NSURL*) url;

@end

@implementation MovieData

@dynamic name;
@dynamic criticsScore;
@dynamic criticsFreshness;
@dynamic synopsis;
@dynamic runtime;
@dynamic poster;
@dynamic characters;
@dynamic actors;

+ (MovieData*)saveMovie:(Movie*) movie {
    MovieData* newMovie = [self MR_findFirstByAttribute:@"name" withValue:movie.name];
    if (!newMovie) {
        newMovie = [self MR_createEntity];
        newMovie.name = movie.name;
        newMovie.synopsis = movie.synopsis;
        newMovie.runtime = [NSNumber numberWithInt: movie.runtime];
        newMovie.criticsScore = [NSNumber numberWithInt:movie.criticsScore];
        newMovie.criticsFreshness = movie.criticsFreshness;
        [newMovie loadPoster:[movie urlPosterWithSize:MoviePosterSizeOriginal]];
        
        
        NSDictionary * cast = movie.cast;
        for (NSString* actor in cast) {
            [newMovie addActorsObject:  [ActorData saveActorNamed:actor PlayedCharacterNamed:[cast objectForKey:actor] inMovie:newMovie]];
        }
    }
    return newMovie;
}
+ (void)unsaveMovie:(Movie*) movie {
    MovieData* movieData = [self MR_findFirstByAttribute:@"name" withValue:movie.name];
    [movieData.managedObjectContext deleteObject:movieData];
}

+ (NSSet*) savedMoviesNames {
    NSArray *movies = [self MR_findAll];
    NSMutableSet* result = [[NSMutableSet alloc] initWithCapacity:[movies count]];
    for (MovieData* movie in movies) {
        [result addObject:movie.name];
    }

    return result;
}


+(Movie*) savedMovieAtIndex:(NSUInteger) index {
    NSArray *movies = [self MR_findAll];
    return [[movies objectAtIndex:index] asMovie];
}


-(Movie*) asMovie {
    
    return [[Movie alloc] initWithMovieData:self];
}

-(void) loadPoster:(NSURL*) url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock: ^(UIImage* image) {return image;} cacheName:@"justname" success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.poster = UIImagePNGRepresentation(image);
    } failure:nil];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}
@end
