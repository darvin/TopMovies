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
-(void) loadPoster:(NSURL*) url;

@end

@implementation MovieData

@dynamic id;
@dynamic properties;
@dynamic poster;

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
        
        
        
    }
    return newMovie;
}
+ (void)unsaveMovie:(Movie*) movie {
    MovieData* movieData = [self MR_findFirstByAttribute:@"id" withValue:movie.rottenId];
    [movieData.managedObjectContext deleteObject:movieData];
}

+ (NSSet*) savedMoviesIds {
    NSArray *movies = [self MR_findAll];
    NSMutableSet* result = [[NSMutableSet alloc] initWithCapacity:[movies count]];
    for (MovieData* movie in movies) {
        [result addObject:movie.id];
    }

    return result;
}


+(Movie*) savedMovieAtIndex:(NSUInteger) index {
    NSArray *movies = [self MR_findAll];
    return [[movies objectAtIndex:index] asMovie];
}

+(NSUInteger) savedMoviesCount {
    return [[self MR_numberOfEntities] intValue];
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
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock: ^(UIImage* image) {return image;} cacheName:@"justname" success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.poster = UIImagePNGRepresentation(image);
    } failure:nil];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}
@end
