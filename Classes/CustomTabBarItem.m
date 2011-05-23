//  Copyright 2011 Logic Diner. All rights reserved.

#import "CustomTabBarItem.h"


@implementation CustomTabBarItem

@synthesize customHighlightedImage;
@synthesize customStdImage;

- (void) dealloc
{
    [customHighlightedImage release]; customHighlightedImage=nil;
    [customStdImage release]; customStdImage=nil;   
    [super dealloc];
}

-(UIImage *) selectedImage
{
    return self.customHighlightedImage;
}

-(UIImage *) unselectedImage
{
    return self.customStdImage;
}

@end
