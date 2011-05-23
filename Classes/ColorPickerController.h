//  Copyright 2011 Logic Diner. All rights reserved.


#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate
- (void)colorSelected:(NSString *)color;
@end


@interface ColorPickerController : UITableViewController {
    NSMutableArray *_colors;
    id<ColorPickerDelegate> _delegate;
}

@property (nonatomic, retain) NSMutableArray *colors;
@property (nonatomic, assign) id<ColorPickerDelegate> delegate;

@end
