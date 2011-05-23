//  Copyright 2011 Logic Diner. All rights reserved.


#import <UIKit/UIKit.h>

@interface CustomTabBarItem : UITabBarItem  
{
    UIImage *customHighlightedImage;
    UIImage *customStdImage;
}

@property (nonatomic, retain) UIImage *customHighlightedImage;
@property (nonatomic, retain) UIImage *customStdImage;

@end

