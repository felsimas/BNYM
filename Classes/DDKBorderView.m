//  Copyright 2011 Logic Diner. All rights reserved.

#import "DDKBorderView.h"


@implementation DDKBorderView


- (id)initWithFrame:(CGRect)frame leftShadowSize:(NSUInteger)leftSz rightShadowSize:(NSUInteger)rightSz topShadowSize:(NSUInteger)topSz bottomShadowSize:(NSUInteger)bottomSz {
    if ((self = [super initWithFrame:frame])) {
		
		_leftSz = leftSz;
		_rightSz = rightSz;
		_topSz = topSz;
		_bottomSz = bottomSz;
		
		shadowSize = _leftSz + _rightSz + _topSz + _bottomSz;

		self.clearsContextBeforeDrawing = YES;
        // Initialization code
		if(shadowSize)
		{
			gradientLayer = [[CAGradientLayer alloc] init];
						
			if(_leftSz || _rightSz)
				[gradientLayer setBounds:CGRectMake(0, 0, shadowSize, frame.size.height)];
			else if(_topSz || _bottomSz)
				[gradientLayer setBounds:CGRectMake(0, 0, frame.size.width,shadowSize)];
			
			[[self layer] insertSublayer:gradientLayer atIndex:0];
			[[self layer] setMasksToBounds:NO];
			
			if(_rightSz)
			{
				gradientLayer.endPoint = CGPointMake(0.0f, 0.5f);
				gradientLayer.startPoint = CGPointMake(1.0f, 0.5f);
			}
			else if(_leftSz)
			{
				gradientLayer.startPoint = CGPointMake(0.0f, 0.5f);
				gradientLayer.endPoint = CGPointMake(1.0f, 0.5f);
			}
			else if(_topSz)
			{
				gradientLayer.startPoint = CGPointMake(0.5f, 0.0f);
				gradientLayer.endPoint = CGPointMake(0.5f, 1.0f);
			}
			else if(_bottomSz)
			{
				gradientLayer.startPoint = CGPointMake(0.5f, 1.0f);
				gradientLayer.endPoint = CGPointMake(0.5f, 0.0f);
			}
			
			UIColor* _highColor = [UIColor clearColor];
			UIColor* _lowColor = [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.3f] autorelease];
			
			[gradientLayer setColors:
			 [NSArray arrayWithObjects:
			  (id)[_highColor CGColor], 
			  (id)[_lowColor CGColor], nil]];
		}
		
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

	if(_leftSz || _rightSz)
		[gradientLayer setBounds:CGRectMake(0, 0, shadowSize, self.bounds.size.height)];
	else if(_topSz || _bottomSz)
		[gradientLayer setBounds:CGRectMake(0, 0, self.bounds.size.width,shadowSize)];
   	
	if(_leftSz)
		[gradientLayer setPosition: CGPointMake(-shadowSize/2, self.bounds.size.height/2)];
	else if(_rightSz)
		[gradientLayer setPosition: CGPointMake(self.bounds.size.width + shadowSize/2, self.bounds.size.height/2)];
	else if(_bottomSz)
		[gradientLayer setPosition: CGPointMake(self.bounds.size.width / 2, self.bounds.size.height + shadowSize/2)];
	
}

- (void)dealloc {
	[gradientLayer release];
    [super dealloc];
}


@end
