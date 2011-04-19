//
//  PdfProofOfConceptViewController.m
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PdfProofOfConceptViewController.h"

// Const
const NSInteger kPdfProofOfConceptViewControllerGridViewTileSpacing = 0; // space between pages
static const NSUInteger kPdfProofOfConceptViewControllerQueueSize = 1;	// Maximum number of concurrent API operations

@implementation PdfProofOfConceptViewController
@synthesize viewWithPdf;
@synthesize currentPage;

- (void)dealloc
{
    [viewWithPdf release];
	[opqueue cancelAllOperations];
	[opqueue release];
	[super dealloc];
}

#pragma mark - View lifecycle

-(void) viewDidLoad
{
	[super viewDidLoad];
	// init the NSOperationQueue
	opqueue = [[NSOperationQueue alloc] init];
	[opqueue setMaxConcurrentOperationCount:kPdfProofOfConceptViewControllerQueueSize]; // set number of pages to load concurrently
	maxContentWidth = 0;
	viewWithPdf.delegate = self;
	currentPage = 1;
	[self addPdfPagesToView:1 withPageRange:3 withPdfFile:@"dontjustrollthedice"]; // show
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark ScrollView delegates

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

}

#pragma mark PdfProofOfConceptDelegate 
// when the pdf view is created we resize and ad it to the scroll view
-(void)pdfPageIsLoaded:(PdfView*)pdfView withNumber:(NSInteger) number
{
	pdfView.frame = CGRectMake(maxContentWidth, viewWithPdf.frame.origin.y, pdfView.frame.size.width, pdfView.frame.size.height); // resize the pdf view and put to the right position
	[viewWithPdf addSubview:pdfView]; // add pdf view to scroll view
	// Set scroller's content height
	maxContentWidth =  CGRectGetMaxX( pdfView.frame ) + kPdfProofOfConceptViewControllerGridViewTileSpacing; // get the width of the scroll view 
	[viewWithPdf setContentSize: CGSizeMake (maxContentWidth, self.view.frame.size.height)]; // update scroll view size

}

#pragma mark - private methods

// draw pages of the pdf file in page Range 
-(void) addPdfPagesToView:(NSInteger)pageNumber withPageRange:(NSInteger)pageRange withPdfFile:(NSString*)fileName
{
	// clear scroll view
	for (UIScrollView* view in viewWithPdf.subviews) 
	{
		[view removeFromSuperview];
	}
	
	// draw from pageNumber to pageRange pdf pages and add to scroll view
	for (int i=pageNumber; i<=pageRange; i++) 
	{
		[self creatPdfPage:i withPdfFile:fileName delegate:self];
	}

}

// create a pdf view and send it ot the delegate
-(void)creatPdfPage:(NSInteger)pageNumber withPdfFile:(NSString*)fileName delegate:(id<PdfProofOfConceptDelegate>)delegate
{
	// Add a block operation to the operation queue
	[opqueue addOperationWithBlock:^{
		
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; // just in case
		
	PdfView* pdfView = [[PdfView alloc] initWithFrame:self.view.frame withPdfFile:fileName withPdfPage:pageNumber]; // create and view and draw a page on it
		
		if( [delegate respondsToSelector:@selector(pdfPageIsLoaded:withNumber:)] )
			[delegate pdfPageIsLoaded:pdfView withNumber:pageNumber];
		
	[pdfView release];
	
	[pool drain];
		
	}];
}

@end
