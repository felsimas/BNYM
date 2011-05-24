//  Copyright 2011 Logic Diner. All rights reserved.


#import <UIKit/UIKit.h>

@protocol ChaptersMenuController
- (void)chapterSelected:(NSString *)chapter;
@end


@interface ChaptersMenuController : UITableViewController {
    NSMutableArray *_chapters;
    id<ChaptersMenuController> _delegate;
}

@property (nonatomic, retain) NSMutableArray *chapters;
@property (nonatomic, assign) id<ChaptersMenuController> delegate;

@end
