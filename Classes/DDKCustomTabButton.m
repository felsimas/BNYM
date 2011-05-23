//  Copyright 2011 Logic Diner. All rights reserved.

#import "DDKCustomTabButton.h"

@implementation DDKCustomTabButton

@synthesize gradientLayer, shadowSize, iconLayer, iconSelectedLayer;

-(void) dealloc
{
	[iconSelectedLayer release];
	[iconLayer release];
	[gradientLayer release];
	[super dealloc];
}

+(id) buttonWithImage:(UIImage*)normalImage selected:(UIImage*)selImage upShadowSize:(CGFloat)shadowSize icon:(UIImage*)icon iconSelected:(UIImage*)iconSelected
{
	DDKCustomTabButton* btn = [DDKCustomTabButton buttonWithType:UIButtonTypeCustom];
	
	btn.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
	[btn setBackgroundImage:normalImage forState:UIControlStateNormal];
	[btn setBackgroundImage:selImage forState:UIControlStateSelected];
	[btn setBackgroundImage:selImage forState:UIControlStateHighlighted];
	[btn setBackgroundImage:selImage forState:(UIControlStateHighlighted | UIControlStateSelected)];
	
	btn.adjustsImageWhenHighlighted = NO;
	btn.clipsToBounds = YES;
	btn.shadowSize = shadowSize;
	
	btn.gradientLayer = [[CAGradientLayer alloc] init];
    [btn.gradientLayer setBounds:CGRectMake(0, -shadowSize, btn.frame.size.width, shadowSize)];
    [[btn layer] insertSublayer:btn.gradientLayer atIndex:0];
    [[btn layer] setMasksToBounds:NO];
	
	CALayer* iconLayer = [[CALayer alloc] init];
	[[btn layer] insertSublayer:iconLayer atIndex:1];
	iconLayer.bounds = CGRectMake(0, 0, icon.size.width, icon.size.height);
	iconLayer.contents = (id)icon.CGImage;

	iconLayer.speed = 5.0f;
	btn.iconLayer = iconLayer;
	
	[iconLayer release];
	

	CALayer* iconSelectedLayer = [[CALayer alloc] init];
	[[btn layer] insertSublayer:iconSelectedLayer atIndex:2];
	iconSelectedLayer.bounds = CGRectMake(0, 0, iconSelected.size.width, iconSelected.size.height);
	iconSelectedLayer.contents = (id)iconSelected.CGImage;
	
	iconSelectedLayer.hidden = YES;
	iconSelectedLayer.speed = 5.0f;
	
	btn.iconSelectedLayer = iconSelectedLayer;
	
	[iconSelectedLayer release];
	
	
	
	UIColor* _highColor = [UIColor clearColor];
	UIColor* _lowColor = [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.3f] autorelease];
	
	[btn.gradientLayer setColors:
	 [NSArray arrayWithObjects:
	  (id)[_highColor CGColor], 
	  (id)[_lowColor CGColor], nil]];

	return btn;
}

-(void) drawRect:(CGRect)rect
{
	[self.gradientLayer setBounds:CGRectMake(0, -shadowSize, self.frame.size.width, shadowSize)];
    [self.gradientLayer setPosition: CGPointMake(self.bounds.size.width/2, -(CGFloat)(shadowSize/2))];
		
	if(self.selected)
	{
		iconSelectedLayer.hidden = NO;
		iconLayer.hidden = YES;
	}
	else 
	{
		iconSelectedLayer.hidden = YES;
		iconLayer.hidden = NO;		
	}
	
	[self.iconLayer setPosition:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
	[self.iconSelectedLayer setPosition:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
	
    [super drawRect:rect];

	
}

@end
