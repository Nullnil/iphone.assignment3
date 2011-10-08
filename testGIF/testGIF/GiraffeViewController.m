//
//  GiraffeViewController.m
//  Giraffe
//
//  Created by Alex Nichol on 1/20/11.
//  Modified by Matthew Klundt on 4/13/11.
//

#import "GiraffeViewController.h"
#import "ANGifEncoder.h"
#import "ANGifBitmap.h"
#import "ANGifPalette.h"
#import "ANPoint.h"

@implementation GiraffeViewController

@synthesize timeLabel;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

- (IBAction) createGIFImage:(id)sender {
	[timeLabel setText:@""];
	
	double startTime = [[NSDate date] timeIntervalSince1970];
	
	// create image
	[self convert];
	
	double endTime = [[NSDate date] timeIntervalSince1970];
	
	float time = endTime - startTime;
	[timeLabel setText:[NSString stringWithFormat:@"Image Converstion took: %f sec", time]];
}


- (void) convert {
	// create Palette first
	UIImage *paletteImage = [UIImage imageNamed:@"Matt.png"];
	ANPoint *mattePoint = [[ANPoint alloc] initWithR:255 withG:255 withB:255]; // this makes the color behind partially transparent pixels white
	ANGifPalette *palette = [[ANGifPalette alloc] initWithImage:paletteImage.CGImage withMatte:mattePoint];
	
	NSString *fileName = [NSString stringWithFormat:@"%@/Documents/matt_walk.gif", NSHomeDirectory()];
	ANGifBitmap *bmp = [[ANGifBitmap alloc] initWithImage:[UIImage imageNamed:@"matt1.png"] withColorPalette:palette];
	ANGifBitmap *bmp2 = [[ANGifBitmap alloc] initWithImage:[UIImage imageNamed:@"matt2.png"] withColorPalette:palette];
	ANGifEncoder *enc = [[ANGifEncoder alloc] initWithFile:fileName withColorPalette:palette animated:YES];
	
	[enc beginFile:bmp.size delayTime:0.5f];
	[enc addImage:bmp];
	[enc addImage:bmp2];
	[enc endFile];
	
	[enc release];
	[bmp release];
	[bmp2 release];
	
	[mattePoint release];
	[palette release];
	
	NSLog(@"%@", fileName);
	[fileName release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//[self performSelector:@selector(convert) withObject:nil afterDelay:0.1];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[timeLabel release];
	
    [super dealloc];
}

@end
