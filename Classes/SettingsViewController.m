//  Copyright 2011 Logic Diner. All rights reserved.

#import "SettingsViewController.h"
#import "CustomTabBarItem.h"
#import "GlobeViewController.h"



@implementation SettingsViewController

@synthesize presentationGrid=_presentationGrid;
@synthesize globeViewController;
@synthesize rootViewController_globe;


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
    
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];
    
    // NSLog(responseString);
    
    NSDictionary *dictionary = [responseString JSONValue];
    total = [dictionary count];
    NSInteger i;
    
    NSLog(@"contador: %d",total);
    
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 120, self.view.frame.size.width -40, self.view.frame.size.height - 80)]; 
    
    
    scrollview.alwaysBounceHorizontal = NO;
    scrollview.directionalLockEnabled = YES;
    scrollview.tag = 200;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 80, 300, 40)];
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    titleLabel.text = @"Title";
    [self.view addSubview:titleLabel];
    [titleLabel release]; 
    
    UILabel *styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(425, 80, 300, 40)];
    [styleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    styleLabel.text = @"Style";
    [self.view addSubview:styleLabel];
    [styleLabel release]; 
    
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(725, 80, 100, 40)];
    [dateLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    dateLabel.text = @"Date";
    [self.view addSubview:dateLabel];
    [dateLabel release]; 
    
   
    for( i = 1; i <= total;i++) {

        NSString *stri;
        stri = [NSString stringWithFormat:@"%d",i];
        
        NSDictionary *pres = [dictionary objectForKey: stri];
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, (i-1)*50, 300, 40)];
        titleLabel.text = [pres objectForKey:@"title"];
        [scrollview addSubview:titleLabel];
        [titleLabel release]; 
        
        UILabel *styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(405, (i-1)*50, 300, 40)];
        styleLabel.text = [pres objectForKey:@"style"];
        [scrollview addSubview:styleLabel];
        [styleLabel release]; 
        
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(705, (i-1)*50, 100, 40)];
        dateLabel.text = [pres objectForKey:@"date"];
        [scrollview addSubview:dateLabel];
        [dateLabel release]; 
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        switch (i)
        {
            case 1:
                [button addTarget:self action:@selector(selectPresentation1:) forControlEvents:UIControlEventTouchDown];
                break;
            case 2:
                [button addTarget:self action:@selector(selectPresentation2:) forControlEvents:UIControlEventTouchDown];
                break;
            case 3:
                [button addTarget:self action:@selector(selectPresentation3:) forControlEvents:UIControlEventTouchDown];
                break;
            case 4:
                [button addTarget:self action:@selector(selectPresentation4:) forControlEvents:UIControlEventTouchDown];
                break;
            case 5:
                [button addTarget:self action:@selector(selectPresentation5:) forControlEvents:UIControlEventTouchDown];
                break;
            case 6:
                [button addTarget:self action:@selector(selectPresentation6:) forControlEvents:UIControlEventTouchDown];
                break;
            case 7:
                [button addTarget:self action:@selector(selectPresentation7:) forControlEvents:UIControlEventTouchDown];
                break;
            case 8:
                [button addTarget:self action:@selector(selectPresentation8:) forControlEvents:UIControlEventTouchDown];
                break;
            case 9:
                [button addTarget:self action:@selector(selectPresentation9:) forControlEvents:UIControlEventTouchDown];
                break;
            case 10:
                [button addTarget:self action:@selector(selectPresentation10:) forControlEvents:UIControlEventTouchDown];
                break;
            case 11:
                [button addTarget:self action:@selector(selectPresentation11:) forControlEvents:UIControlEventTouchDown];
                break;
            case 12:
                [button addTarget:self action:@selector(selectPresentation12:) forControlEvents:UIControlEventTouchDown];
                break;
            case 13:
                [button addTarget:self action:@selector(selectPresentation13:) forControlEvents:UIControlEventTouchDown];
                break;
            case 14:
                [button addTarget:self action:@selector(selectPresentation14:) forControlEvents:UIControlEventTouchDown];
                break;
            case 15:
                [button addTarget:self action:@selector(selectPresentation15:) forControlEvents:UIControlEventTouchDown];
                break;
            case 16:
                [button addTarget:self action:@selector(selectPresentation16:) forControlEvents:UIControlEventTouchDown];
                break;
            case 17:
                [button addTarget:self action:@selector(selectPresentation17:) forControlEvents:UIControlEventTouchDown];
                break;
            case 18:
                [button addTarget:self action:@selector(selectPresentation18:) forControlEvents:UIControlEventTouchDown];
                break;
            case 19:
                [button addTarget:self action:@selector(selectPresentation19:) forControlEvents:UIControlEventTouchDown];
                break;
            case 20:
                [button addTarget:self action:@selector(selectPresentation20:) forControlEvents:UIControlEventTouchDown];
                break;
                
        }

        
    
        [button setTitle:@"Select" forState:UIControlStateNormal];
        button.frame = CGRectMake(880, ((i-1)*50), 75, 40);
        [scrollview addSubview:button];
        
        
        
    }
    
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *total); 
    [self.view addSubview:scrollview]; // spinner is not visible until started
    
    [spinner stopAnimating];

    
    
    
}


- (void) selectPresentation:(NSInteger*) presentationID {
    NSInteger ix;
    for( ix = 1; ix <= total;ix++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"Select" forState:UIControlStateNormal];
        switch (ix)
        {
            case 1:
                [button addTarget:self action:@selector(selectPresentation1:) forControlEvents:UIControlEventTouchDown];
                break;
            case 2:
                [button addTarget:self action:@selector(selectPresentation2:) forControlEvents:UIControlEventTouchDown];
                break;
            case 3:
                [button addTarget:self action:@selector(selectPresentation3:) forControlEvents:UIControlEventTouchDown];
                break;
            case 4:
                [button addTarget:self action:@selector(selectPresentation4:) forControlEvents:UIControlEventTouchDown];
                break;
            case 5:
                [button addTarget:self action:@selector(selectPresentation5:) forControlEvents:UIControlEventTouchDown];
                break;
            case 6:
                [button addTarget:self action:@selector(selectPresentation6:) forControlEvents:UIControlEventTouchDown];
                break;
            case 7:
                [button addTarget:self action:@selector(selectPresentation7:) forControlEvents:UIControlEventTouchDown];
                break;
            case 8:
                [button addTarget:self action:@selector(selectPresentation8:) forControlEvents:UIControlEventTouchDown];
                break;
            case 9:
                [button addTarget:self action:@selector(selectPresentation9:) forControlEvents:UIControlEventTouchDown];
                break;
            case 10:
                [button addTarget:self action:@selector(selectPresentation10:) forControlEvents:UIControlEventTouchDown];
                break;
            case 11:
                [button addTarget:self action:@selector(selectPresentation11:) forControlEvents:UIControlEventTouchDown];
                break;
            case 12:
                [button addTarget:self action:@selector(selectPresentation12:) forControlEvents:UIControlEventTouchDown];
                break;
            case 13:
                [button addTarget:self action:@selector(selectPresentation13:) forControlEvents:UIControlEventTouchDown];
                break;
            case 14:
                [button addTarget:self action:@selector(selectPresentation14:) forControlEvents:UIControlEventTouchDown];
                break;
            case 15:
                [button addTarget:self action:@selector(selectPresentation15:) forControlEvents:UIControlEventTouchDown];
                break;
            case 16:
                [button addTarget:self action:@selector(selectPresentation16:) forControlEvents:UIControlEventTouchDown];
                break;
            case 17:
                [button addTarget:self action:@selector(selectPresentation17:) forControlEvents:UIControlEventTouchDown];
                break;
            case 18:
                [button addTarget:self action:@selector(selectPresentation18:) forControlEvents:UIControlEventTouchDown];
                break;
            case 19:
                [button addTarget:self action:@selector(selectPresentation19:) forControlEvents:UIControlEventTouchDown];
                break;
            case 20:
                [button addTarget:self action:@selector(selectPresentation20:) forControlEvents:UIControlEventTouchDown];
                break;
                
        }
        
        

        button.frame = CGRectMake(880, ((ix-1)*50), 75, 40);
        [scrollview addSubview:button];
        [(UIScrollView*)[self.view viewWithTag:200] addSubview:button];
        
        
  
        
       //  rootViewController_globe = [[GlobeViewController alloc] initWithNibName:@"World-iPad" bundle:nil]; 
       // globeViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_globe];

        globeAppDelegate *globeDelegate = (globeAppDelegate *)[[UIApplication sharedApplication] delegate];
        
       

        [globeDelegate reloadGlobe];
        
        
    }
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSInteger i;
    i = presentationID;
    switch (i)
    {
        case 1:
            [button addTarget:self action:@selector(selectPresentation1:) forControlEvents:UIControlEventTouchDown];
            break;
        case 2:
            [button addTarget:self action:@selector(selectPresentation2:) forControlEvents:UIControlEventTouchDown];
            break;
        case 3:
            [button addTarget:self action:@selector(selectPresentation3:) forControlEvents:UIControlEventTouchDown];
            break;
        case 4:
            [button addTarget:self action:@selector(selectPresentation4:) forControlEvents:UIControlEventTouchDown];
            break;
        case 5:
            [button addTarget:self action:@selector(selectPresentation5:) forControlEvents:UIControlEventTouchDown];
            break;
        case 6:
            [button addTarget:self action:@selector(selectPresentation6:) forControlEvents:UIControlEventTouchDown];
            break;
        case 7:
            [button addTarget:self action:@selector(selectPresentation7:) forControlEvents:UIControlEventTouchDown];
            break;
        case 8:
            [button addTarget:self action:@selector(selectPresentation8:) forControlEvents:UIControlEventTouchDown];
            break;
        case 9:
            [button addTarget:self action:@selector(selectPresentation9:) forControlEvents:UIControlEventTouchDown];
            break;
        case 10:
            [button addTarget:self action:@selector(selectPresentation10:) forControlEvents:UIControlEventTouchDown];
            break;
        case 11:
            [button addTarget:self action:@selector(selectPresentation11:) forControlEvents:UIControlEventTouchDown];
            break;
        case 12:
            [button addTarget:self action:@selector(selectPresentation12:) forControlEvents:UIControlEventTouchDown];
            break;
        case 13:
            [button addTarget:self action:@selector(selectPresentation13:) forControlEvents:UIControlEventTouchDown];
            break;
        case 14:
            [button addTarget:self action:@selector(selectPresentation14:) forControlEvents:UIControlEventTouchDown];
            break;
        case 15:
            [button addTarget:self action:@selector(selectPresentation15:) forControlEvents:UIControlEventTouchDown];
            break;
        case 16:
            [button addTarget:self action:@selector(selectPresentation16:) forControlEvents:UIControlEventTouchDown];
            break;
        case 17:
            [button addTarget:self action:@selector(selectPresentation17:) forControlEvents:UIControlEventTouchDown];
            break;
        case 18:
            [button addTarget:self action:@selector(selectPresentation18:) forControlEvents:UIControlEventTouchDown];
            break;
        case 19:
            [button addTarget:self action:@selector(selectPresentation19:) forControlEvents:UIControlEventTouchDown];
            break;
        case 20:
            [button addTarget:self action:@selector(selectPresentation20:) forControlEvents:UIControlEventTouchDown];
            break;
            
    }
    
   
    [button setTitle:@"Selected" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(880, ((i-1)*50), 75, 40);
    [scrollview addSubview:button];
    [(UIScrollView*)[self.view viewWithTag:200] addSubview:button];
    
    
  
    
    

}


- (IBAction)selectPresentation1:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:1];
}
- (IBAction)selectPresentation2:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:2];
}
- (IBAction)selectPresentation3:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:3];
}
- (IBAction)selectPresentation4:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:4];
}
- (IBAction)selectPresentation5:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:5];
}
- (IBAction)selectPresentation6:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:6];
}
- (IBAction)selectPresentation7:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:7];
}
- (IBAction)selectPresentation8:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:8];
}
- (IBAction)selectPresentation9:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:9];
}
- (IBAction)selectPresentation10:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:10];
}
- (IBAction)selectPresentation11:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:11];
}
- (IBAction)selectPresentation12:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:12];
}
- (IBAction)selectPresentation13:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:13];
}
- (IBAction)selectPresentation14:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:14];
}
- (IBAction)selectPresentation15:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:15];
}
- (IBAction)selectPresentation16:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:16];
}
- (IBAction)selectPresentation17:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:17];
}
- (IBAction)selectPresentation18:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:18];
}
- (IBAction)selectPresentation19:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:19];
}
- (IBAction)selectPresentation20:(id)sender {
    [self performSelector:@selector(selectPresentation:) withObject:20];
}

- (IBAction)pushButton:(id)sender {
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(515, 320)]; // I do this because I'm in landscape mode
    [self.view addSubview:spinner]; // spinner is not visible until started
    [spinner startAnimating];

    responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://tudoporaqui.com.br/globe/GetPresentation.php"]];
    
    /*http://ec2-174-129-66-92.compute-1.amazonaws.com/api/presentation/*/
    /*http://tudoporaqui.com.br/globe/globe.php*/
    
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
    

        
    
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSLog(@"Settings Init");
        CustomTabBarItem *tabItem = [[CustomTabBarItem alloc]
                                     initWithTitle:@"Settings" image:nil tag:0];
        
        tabItem.customHighlightedImage=[UIImage imageNamed:@"tabIconSelected.png"];
        tabItem.customStdImage=[UIImage imageNamed:@"tabIcon.png"];       
        
        self.tabBarItem=tabItem;
        [tabItem release]; 
        tabItem=nil;   
        
    }
    return self;
}


- (id) init
{   
    if(self = [super init])
    {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    CustomTabBarItem *tabItem = [[CustomTabBarItem alloc]
                                 initWithTitle:@"Settings" image:nil tag:0];
    
    tabItem.customHighlightedImage=[UIImage imageNamed:@"tabIconSelected.png"];
    tabItem.customStdImage=[UIImage imageNamed:@"tabIcon.png"];       
    
    self.tabBarItem=tabItem;
    [tabItem release]; 
    tabItem=nil;    
    
    
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
