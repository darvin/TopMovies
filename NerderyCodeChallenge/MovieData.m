//
//  MovieData.m
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieData.h"
#import "AFNetworking.h"

@interface MovieData()
- (void) loadPoster:(NSURL*) url;
- (NSOperationQueue*) sharedQueue;
@end

@implementation MovieData

@dynamic id;
@dynamic properties;
@dynamic poster;



+ (NSMutableArray*) movies {
    static NSMutableArray *movies;
    
    @synchronized(self)
    {
        if (!movies) {
            NSArray* moviesDatas = [self MR_findAll];
            movies = [[NSMutableArray alloc] initWithCapacity:[moviesDatas count]];
            for (MovieData* movieData in moviesDatas) {
                [movies addObject:[movieData asMovie]];
            }
        }
        return movies;
    }
}

- (NSOperationQueue*) sharedQueue  {
    static NSOperationQueue *queue;
    
    @synchronized(self)
    {
        if (!queue) {
            queue = [[NSOperationQueue alloc] init];
        }
        return queue;
    }
}


+ (MovieData*)saveMovie:(Movie*) movie {
    MovieData* newMovie = [self MR_findFirstByAttribute:@"id" withValue:movie.rottenId];
    if (!newMovie) {
        newMovie = [self MR_createEntity];
        newMovie.id = movie.rottenId;
        
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:movie.properties];
        [archiver finishEncoding];
        newMovie.properties = data;
        
        [newMovie loadPoster:[movie urlPosterWithSize:MoviePosterSizeOriginal]];
        [[self movies] addObject:[newMovie asMovie]];
    }
    return newMovie;
}


+ (void)unsaveMovie:(Movie*) movie {
    MovieData* movieData = [self MR_findFirstByAttribute:@"id" withValue:movie.rottenId];
    [movieData.managedObjectContext deleteObject:movieData];
    NSMutableArray *movies = [self movies];
    for (int i=0; i<[movies count]; i++) {
        if ([[movies objectAtIndex:i] isEqual:movie]) 
            [movies removeObjectAtIndex:i];
    }
}

+ (NSSet*) savedMoviesIds {
    NSArray *movies = [self movies];
    NSMutableSet* result = [[NSMutableSet alloc] initWithCapacity:[movies count]];
    for (Movie* movie in movies) {
        [result addObject:movie.rottenId];
    }

    return result;
}


-(Movie*) asMovie {
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:self.properties];
    NSDictionary *properties = [unarchiver decodeObject];
    [unarchiver finishDecoding];    
    Movie* movie = [[Movie alloc] initWithProperties:properties];
    movie.poster = [[UIImage alloc] initWithData:self.poster];
    return movie;
}

-(void) loadPoster:(NSURL*) url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
        self.poster = (NSData*) responseObject;
    } failure:nil];  
    [[self sharedQueue] addOperation:operation];
}
@end
