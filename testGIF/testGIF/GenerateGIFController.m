//
//  GenerateGIFController.m
//  testGIF
//
//  Created by Le Yan on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GenerateGIFController.h"

@implementation GenerateGIFController
@synthesize images;
@synthesize imageforpalette;
@synthesize imageView;
@synthesize filename;


/* generate a new gif name */
-(NSString*)generateNewGifName{
    char name[] = "XXXX";
    mktemp(name);
    NSString *gifname = [[ NSString alloc ] initWithFormat:@"%s.gif", name];
    [ gifname autorelease ];
    return gifname;
}


/* generate a gif from a series of thumbnails */
- (IBAction)generateGIF:(id)sender {
    
    if( self.images.count != 0 ){
        NSString * fileName = [NSString stringWithFormat:@"%@/Documents/%@", 
                               NSHomeDirectory(),[self generateNewGifName ]];
        self.filename = fileName;
        NSLog(@"%@", fileName);
        
        ANPoint *mattePoint = [[ANPoint alloc] initWithR:255 withG:255 withB:255];
        
        ANGifPalette *palette = [[ANGifPalette alloc] initWithImage: self.imageforpalette.CGImage 
                                                          withMatte:mattePoint];
        
        ANGifEncoder * enc = [[ANGifEncoder alloc] initWithFile:fileName 
                                               withColorPalette:palette 
                                                       animated:YES];
        UIImage* im = [ self.images lastObject ];
        ANGifBitmap *bmp = [[ANGifBitmap alloc] initWithImage: im withColorPalette:palette];
        /* get CGSize of file */
        
        [ enc beginFile:bmp.size delayTime:1];
        
        
        for( UIImage* im in self.images ){
            ANGifBitmap * bmp = [[ANGifBitmap alloc] initWithImage: im withColorPalette:palette];
            [ enc addImage:bmp ]; 
            [ bmp release ];
        }
        [ im release ];
        [ bmp release ];
        
        [enc endFile];
        NSLog(@"GIF done");
        NSFileManager *fileManager = [[ NSFileManager alloc] init];
        NSDictionary * attributes = [ fileManager attributesOfItemAtPath:fileName error: nil ];
        NSLog(@"%d", [[attributes objectForKey:NSFileSize] intValue]);
        
        [ fileName release ];
        [ enc release ];
        
    }
    
}


-(id)initWithThumbnails:(NSMutableArray *)uiImages
        imageforpalette:(UIImage *) palette{
    
    self = [ super init ];
    if( self ){
       self.images = uiImages;
       self.imageforpalette = palette;
        
       NSLog(@"%d", self.images.count);
       imageView.animationImages = [NSArray arrayWithArray:self.images ];
        
       imageView.animationDuration = 1;
        
       imageView.animationRepeatCount = 0;
        
       [imageView startAnimating];

    }
    
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imageView release];
    [super dealloc];
}
@end
