//
//  Movie.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MoviePosterSizeThumbnail = 0,
    MoviePosterSizeDetailed,
    MoviePosterSizeProfile,
    MoviePosterSizeOriginal,
    MoviePosterSize_MAX,
}MoviePosterSize;

@interface Movie : NSObject

//Real data. Holds just raw data from API respond
@property (strong, nonatomic) NSDictionary * properties;

//Below is readonly properties. It returns appropriate fields from properties dictionary
@property (readonly) NSString* name;
@property (readonly) NSUInteger criticsScore;
@property (readonly) NSString* criticsFreshness;
@property (readonly) NSString* synopsis;
@property (readonly) NSUInteger runtime;
@property (readonly) NSDictionary* cast;
@property (readonly) NSString* rottenId;
@property (readonly) NSURL* fullURL;

@property (strong, nonatomic) UIImage* poster;

//Returns appropriate image of MPAA rating
-(UIImage*) ratingImage;

//Properties is just raw dictionary from API respond
-(id) initWithProperties:(NSDictionary*) properties;

//Returns url for poster of this size
-(NSURL*) urlPosterWithSize:(MoviePosterSize) size;
@end
