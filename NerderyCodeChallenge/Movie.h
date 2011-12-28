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
@property (strong, nonatomic) NSDictionary * properties;
@property (readonly) NSString* name;
@property (readonly) NSUInteger criticsScore;

-(UIImage*) ratingImage;
-(id) initWithProperties:(NSDictionary*) properties;
-(NSURL*) urlPosterWithSize:(MoviePosterSize) size;
@end
