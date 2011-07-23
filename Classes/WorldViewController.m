//  Copyright 2011 Logic Diner. All rights reserved.


#import "WorldViewController.h"
#import "CustomTabBarItem.h"
#import "globeAppDelegate.h"
#import "PDFExampleViewController.h"

@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
	UIImage *image = [UIImage imageNamed: @"navigationBar.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end


@implementation WorldViewController

@synthesize chaptersPicker = _chaptersPicker;
@synthesize chaptersPickerPopover = _chaptersPickerPopover;

- (void)viewDidAppear:(BOOL)animated{
	NSLog(@"got here vda");
	//[activityIndicator stopAnimating];
}



- (void)viewDidLoad {
    UIToolbar *tools = [[UIToolbar alloc]
                        initWithFrame:CGRectMake(0.0f, 0.0f, 103.0f, 44.01f)]; // 44.01 shifts it up 1px for some reason
    tools.clearsContextBeforeDrawing = NO;
    tools.clipsToBounds = NO;
    tools.tintColor = [UIColor colorWithWhite:0.305f alpha:0.0f]; // closest I could get by eye to black, translucent style.
    // anyone know how to get it perfect?
    tools.barStyle = -1; // clear background
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    
    
    // create a standard "add" button
    UIBarButtonItem* bi = [[UIBarButtonItem alloc]
                           initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
    
    
    
    // UIView* container = [[UIView alloc] init];
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0,0, 100,0)];
    
    UIImage *image=[UIImage imageNamed:@"top_right1_btn.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );    
    button.frame = CGRectMake( 0, -20, image.size.width, image.size.height );    
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [container addSubview:button];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [buttons addObject:barButtonItem];
    
    [barButtonItem release];
    
    // create a spacer
    bi = [[UIBarButtonItem alloc]
          initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [buttons addObject:bi];
    [bi release];
    
    UIImage *image2=[UIImage imageNamed:@"top_right2_btn.png"];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );    
    button2.frame = CGRectMake( 0, -20, image.size.width, image.size.height );    
    
    [button2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];    
    
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    [buttons addObject:barButtonItem2];
    [barButtonItem2 release];
    // stick the buttons in the toolbar
    [tools setItems:buttons animated:NO];
    
    [buttons release];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tools];
    [tools release];
    
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(IBAction)popPdf{
	
    //[self.delegate popPdf];
    
//	NSLog(@"WORLD VIEW COntroller pdf");
	/*if (self.pdfView == nil){
     NSLog(@"pdfView nulo");
     PdfViewController *view2 = [[PdfViewController alloc] initWithNibName:@"PdfView" bundle:[NSBundle mainBundle]];
     self.pdfView = view2;
     }*/
	//[self pushViewController:self.pdfView animated:YES];
    
	
	//PdfViewController *view2 = [[PdfViewController alloc] initWithNibName:@"PdfView" bundle:[NSBundle mainBundle]];
	//[self setView:[view2 view]];
    
    PDFExampleViewController *viewController = [[[PDFExampleViewController alloc] init] autorelease];

    [self.navigationController pushViewController:viewController animated:YES];
    
   // UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:view2];
    //self presentModalViewController:view2 animated:YES];
	
	//[navigationController release];
    //[view2 release];
	
}


- (void)launchPopupFromGlobe{
	GlobePopupViewController *controller =
    [[GlobePopupViewController alloc] initWithNibName:@"GlobePopupViewController" 
                                            bundle:nil];
    controller.delegate = self;
	[self.view addSubview:controller.view];
    [GlobePopupViewController release];
}


- (void)chapterSelected:(NSString *)chapter {
    [self.chaptersPickerPopover dismissPopoverAnimated:YES];
    globeAppDelegate *globeDelegate = (globeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [globeDelegate setTabBarControllerAtIndex:1];
}

- (void)showMenu:(id)sender{
    NSLog(@"show menu");
    if (_chaptersPicker == nil) {
        self.chaptersPicker = [[[ChaptersMenuController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        _chaptersPicker.delegate = self;
        self.chaptersPickerPopover = [[[UIPopoverController alloc] initWithContentViewController:_chaptersPicker] autorelease];               
    }
    
    //[self.chaptersPickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [self.chaptersPickerPopover presentPopoverFromRect:CGRectMake(930.0f, -15.f, 10.0f, 10.0f) inView:self.view
						  permittedArrowDirections:1
										  animated:YES];

   // [self.chaptersPickerPopover presentPopoverFromRect:CGRectMake(800.0f, 50.f, 10.0f, 10.0f) permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  myLovelyData:(id)data
{
    if ((self = [super initWithNibName:@"World-iPad" bundle:nibBundleOrNil])) 
    {
        CustomTabBarItem *tabItem = [[CustomTabBarItem alloc]
                                     initWithTitle:@"Presentation" image:nil tag:0];
        
        tabItem.customHighlightedImage=[UIImage imageNamed:@"tabIconSelected.png"];
        tabItem.customStdImage=[UIImage imageNamed:@"tabIcon.png"];       
        
        self.tabBarItem=tabItem;
        [tabItem release]; 
        tabItem=nil; 
    }
    return self;
}


- (void)viewDidDisappear:(BOOL)animated{
	//NSLog(@"got here vdd");
}




- (void)viewWillAppear:(BOOL)animated{
  
    CustomTabBarItem *tabItem = [[CustomTabBarItem alloc]
                                 initWithTitle:@"Global Touch Points" image:nil tag:0];
    
    tabItem.customHighlightedImage=[UIImage imageNamed:@"tabIconSelected.png"];
    tabItem.customStdImage=[UIImage imageNamed:@"tabIcon.png"];       
    
    self.tabBarItem=tabItem;
    [tabItem release]; 
    tabItem=nil; 
	countriesSegment.tintColor = [UIColor darkGrayColor];
	glowSegment.tintColor = [UIColor darkGrayColor];
	rotateSegment.tintColor = [UIColor darkGrayColor];
	//self.navigationController.navigationBarHidden = YES;
	
	[theGlobe initGlobeSizeByOrientation:self.interfaceOrientation];
    [theGlobe setDelegate:self];
	[theGlobe startAnimation];
    

	
}	

- (void)viewWillDisappear:(BOOL)animated{


	[theGlobe stopAnimation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	NSLog(@"BEGIN: shouldAutorotateToInterfaceOrientation");

		
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		return YES;
	else {
		//it is an iPhone so don't auto rotate
		return NO;
	}

	
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	NSLog(@"BEGIN: didRotateFromInterfaceOrientation");
	[theGlobe stopAnimation];
	[theGlobe initGlobeSizeByOrientation:self.interfaceOrientation];
	[theGlobe startAnimation];
}


- (void)dealloc {
    self.chaptersPicker = nil;
    self.chaptersPickerPopover = nil;
    [super dealloc];    
}


@end
