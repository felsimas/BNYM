//  Copyright 2011 Logic Diner. All rights reserved.


#import "DDKCustomTabbar.h"
#import "DDKCustomTabButton.h"
#import "DDKBorderView.h"
#import "DDKCustomTabbar.h"

//
// private methods declarations for internal use
//
@interface DDKCustomTabbar(private)

-(void) _rearrangeTabs;
-(void) _configureViewForToolbar:(UIViewController *)c;

@end

@implementation DDKCustomTabbar

@synthesize viewControllers, tabButtons, selectedIndex, autohideOrientation;

- (void)dealloc 
{
	[leftBorderView release];
	[rightBorderView release];
	[viewControllers release];
	[tabButtons release];
    [super dealloc];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.exclusiveTouch = NO;
	UIImage* lbi = [UIImage imageNamed:@"borderLeft.png"];
	leftBorderView = [[DDKBorderView alloc] initWithFrame:CGRectMake(0,0,lbi.size.width,self.view.frame.size.height) 
										   leftShadowSize:0 rightShadowSize:6 topShadowSize:0 bottomShadowSize:0];
	leftBorderView.backgroundColor = [UIColor colorWithPatternImage:lbi];
	leftBorderView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin 
										| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight 
										| UIViewAutoresizingFlexibleRightMargin;
	
	leftBorderWidth = lbi.size.width;
	
	[self.view addSubview:leftBorderView];

	UIImage* rbi = [UIImage imageNamed:@"borderRight.png"];
	rightBorderView = [[DDKBorderView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - rbi.size.width, 0, rbi.size.width,self.view.frame.size.height) 
											leftShadowSize:6 rightShadowSize:0 topShadowSize:0 bottomShadowSize:0];
	rightBorderView.backgroundColor = [UIColor colorWithPatternImage:rbi];

	rightBorderView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin 
	| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight 
	| UIViewAutoresizingFlexibleRightMargin;
	
	rightBorderWidth = rbi.size.width;

	[self.view addSubview:rightBorderView];
	
	self.view.autoresizesSubviews = YES;
	
	topBorderHeight = 0;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self _rearrangeTabs];
	if(currentToolBarViewBorder)
		[currentToolBarViewBorder setNeedsDisplay];
	
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	for(UIViewController* c in [viewControllers allValues])
	{
		[c willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	}
	
		
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self _rearrangeTabs];
	for(UIViewController* c in [viewControllers allValues])
	{
		[c didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	}

	/*
	BOOL willHide = NO;
	
	if((fromInterfaceOrientation == UIInterfaceOrientationPortrait) || (fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown))
		willHide = YES;
	
	[UIView beginAnimations:nil context:nil];
	for(DDKCustomTabButton* btn in tabButtons)
	{
		if(willHide)
			btn.transform = CGAffineTransformMakeTranslation(0, btn.frame.size.height);
		else 
			btn.transform = CGAffineTransformMakeTranslation(0, 0);

	}
	UIView* vcView  = nil;
	UIViewController* current = (UIViewController*)[viewControllers objectForKey:[NSNumber numberWithInt:selectedIndex]];
	if([current isKindOfClass:[UINavigationController class]])
	{
		UINavigationController* currentvc = (UINavigationController*)[viewControllers objectForKey:[NSNumber numberWithInt:selectedIndex]];
		vcView = currentvc.topViewController.view;
	}
	else {
		vcView = current.view;
	}

	
	CGRect f = vcView.frame;
	
	if(willHide)
		f.size.height += bottomBorderHeight;
	else
		f.size.height -= bottomBorderHeight;
	
	vcView.frame = f;
	[UIView commitAnimations];*/
}


-(void) _rearrangeTabs
{
	CGFloat wd = self.view.bounds.size.width - leftBorderWidth - rightBorderWidth;
	DDKCustomTabButton* btn = [tabButtons objectAtIndex:0];
	bottomBorderHeight = btn.frame.size.height;
	NSUInteger cnt = [tabButtons count];
	CGFloat newBtnWd = wd / cnt;
	
	NSUInteger idx = 0;
	
	for(DDKCustomTabButton* b in tabButtons)
	{
		[self.view bringSubviewToFront:b];
		b.transform = CGAffineTransformMakeTranslation(0, 0);
		CGRect f = CGRectMake(leftBorderWidth + idx * newBtnWd, self.view.bounds.size.height - bottomBorderHeight, newBtnWd, bottomBorderHeight); 
		b.frame = f;
		[b setNeedsDisplay];
		++idx;
	}
	
}

-(void) insertTabButton:(DDKCustomTabButton*)btn atIndex:(NSUInteger)positionIndex
{
	
	NSMutableArray* a = nil;
	
	if(tabButtons)
		a = [[NSMutableArray alloc] initWithArray:tabButtons];
	else 
		a = [[NSMutableArray alloc] init]; 
	
	btn.tag = positionIndex;
	[a insertObject:btn atIndex:positionIndex];
	
	[self.view addSubview:btn];
	
	[btn addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchDown];
	btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin 
							| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth 
							| UIViewAutoresizingFlexibleRightMargin;

	self.tabButtons = a;
	[a release];
	
	[self _rearrangeTabs];
	
}

-(void) setViewController:(UIViewController*)controller atIndex:(NSUInteger)idx
{
	if(!viewControllers)
		viewControllers = [[NSDictionary alloc] init];
	
	NSAssert(idx <= [tabButtons count] - 1, @"Index of ViewController must be valid.");
	
	NSMutableDictionary* d = [[NSMutableDictionary alloc] initWithDictionary:viewControllers];

	if([controller isKindOfClass:[UINavigationController class]])
		[(UINavigationController*)controller setDelegate:self];
		
	[d setObject:controller forKey:[NSNumber numberWithInt:idx]];
		
	if([controller isKindOfClass:[UINavigationController class]])
	{
		topBorderHeight = 44; //TODO: fix hardcode here
		UINavigationController* nc = (UINavigationController*)controller;
		nc.navigationBarHidden = YES;
	}

	controller.view.frame = CGRectMake(leftBorderWidth, topBorderHeight
									   , self.view.bounds.size.width - leftBorderWidth - rightBorderWidth
									   , self.view.bounds.size.height - topBorderHeight - bottomBorderHeight);
	
	[self.view insertSubview:controller.view atIndex:0];
	
	self.viewControllers = d;
	[d release];
}


-(void) tabSelected:(id)sender
{
	DDKCustomTabButton* btn = (DDKCustomTabButton*)sender;

	static NSUInteger lastTag = 1010;

	if(lastTag == btn.tag)
		return;
		
	lastTag = btn.tag;
	
	for(DDKCustomTabButton* b in tabButtons)
	{
		b.selected = NO;
		NSNumber* key = [NSNumber numberWithInt:b.tag];
		UIViewController* c = [viewControllers objectForKey:key];

		if(!c.view.hidden && (lastTag != b.tag))
		{
			if([c isKindOfClass:[UINavigationController class]])
			{
				UINavigationController* cc = (UINavigationController*)c;
				cc.view.hidden = YES;
				cc.topViewController.view.hidden = YES;
				[cc.topViewController viewDidDisappear:YES];
			}
			else 
			{
				c.view.hidden = YES;
				[c viewDidDisappear:YES];
			}

		}
	}
	
	NSNumber* currentKey = [NSNumber numberWithInt:btn.tag];
	UIViewController* c = [viewControllers objectForKey:currentKey];

	if([c isKindOfClass:[UINavigationController class]])
	{
		UINavigationController* cc = (UINavigationController*)c;
		cc.view.hidden = NO;
		cc.topViewController.view.hidden = NO;
		[cc.topViewController viewWillAppear:NO];
	}
	else 
	{
		c.view.hidden = NO;
		[c viewWillAppear:NO];
	}


	btn.selected = YES;

	if([c isKindOfClass:[UINavigationController class]])  
	{
		// do nothing,  navigation controller is configured previously
		UINavigationController* nc = (UINavigationController*)c;
		nc.navigationBarHidden = YES;
		[self _configureViewForToolbar:nc.topViewController];
		
	} else if([c isKindOfClass:[UIViewController class]])
	{
		c.navigationController.navigationBarHidden = YES;
		[self _configureViewForToolbar:c];
	}


}

- (void) _configureViewForToolbar:(UIViewController*)c
{
	if(c.view.hidden)
		return;
	
	if([c conformsToProtocol:@protocol(DDKTabBarDelegate)])
	{
		id cc = c;
		if(currentToolBarView)
		{
			[currentToolBarView removeFromSuperview];
		}
		
		currentToolBarView = [cc viewForToolBar];
		
		// we need only height;
		CGRect r = CGRectMake(leftBorderWidth, 0
							  , self.view.bounds.size.width - leftBorderWidth - rightBorderWidth
							  , currentToolBarView.frame.size.height);
		
		BOOL bResizeView = YES;
		if([cc respondsToSelector:@selector(resizeViewToFit)])
		{
			bResizeView = [cc resizeViewToFit];
		}
		
		topBorderHeight = r.size.height;
		
		if (currentToolBarViewBorder) 
		{
			[currentToolBarViewBorder removeFromSuperview];
			[currentToolBarViewBorder release];
			currentToolBarViewBorder = nil;
		}
		
		BOOL useShadows = [cc toolBarWithShadow];
		
		currentToolBarViewBorder = [[DDKBorderView alloc] initWithFrame:r leftShadowSize:0 rightShadowSize:0 topShadowSize:0 bottomShadowSize:(useShadows)?6:0];
		currentToolBarViewBorder.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		currentToolBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		currentToolBarViewBorder.autoresizesSubviews = YES;
		currentToolBarViewBorder.opaque = NO;
		currentToolBarViewBorder.backgroundColor = [UIColor clearColor];
		[self.view addSubview:currentToolBarViewBorder];
		
		currentToolBarViewBorder.frame = r;
		currentToolBarView.frame = CGRectMake(0, 0, r.size.width, r.size.height);
		
		[currentToolBarViewBorder addSubview:currentToolBarView];
		
		if(bResizeView)
		{
			CGRect ccFrame = c.view.frame;
			if(c.navigationController)
				ccFrame.origin.y = 0;
			else	
				ccFrame.origin.y = topBorderHeight;
			ccFrame.size.height = self.view.bounds.size.height - topBorderHeight - bottomBorderHeight;
			c.view.frame = ccFrame;
			
#if(TARGET_IPHONE_SIMULATOR)		
			NSLog(@"%f %f %f %f",ccFrame.origin.x, ccFrame.origin.y, ccFrame.size.width, ccFrame.size.height);
#endif			
		}
	}
	else {
		if (currentToolBarViewBorder) 
		{
			[currentToolBarViewBorder removeFromSuperview];
			[currentToolBarViewBorder release];
			currentToolBarViewBorder = nil;
		}
	}	
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
#if(TARGET_IPHONE_SIMULATOR)	
	NSLog(@"%@",[viewController class]);
#endif	
	//navigationController.navigationBarHidden = YES;
	[self _configureViewForToolbar:viewController];

}

-(void) setSelectedIndex:(NSUInteger)val
{
	if(val > [tabButtons count]-1)
		val = [tabButtons count] - 1;
	
	selectedIndex = val;

	DDKCustomTabButton* btn = [tabButtons objectAtIndex:selectedIndex];
	[self tabSelected:btn];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[currentToolBarViewBorder release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
