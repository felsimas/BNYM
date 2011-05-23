//  Copyright 2011 Logic Diner. All rights reserved.


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DDKBorderView : UIView {
@private
	CGFloat _leftSz;
	CGFloat _rightSz;
	CGFloat _topSz;
	CGFloat _bottomSz;
	
	CGFloat shadowSize;
	
	CAGradientLayer* gradientLayer; 
}

- (id)initWithFrame:(CGRect)frame leftShadowSize:(NSUInteger)leftSz rightShadowSize:(NSUInteger)rightSz topShadowSize:(NSUInteger)topSz bottomShadowSize:(NSUInteger)bottomSz;

@end
