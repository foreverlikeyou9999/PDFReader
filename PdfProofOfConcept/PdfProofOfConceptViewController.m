//
//  PdfProofOfConceptViewController.m
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PdfProofOfConceptViewController.h"
#import "PdfView.h"

// Const
const NSInteger kPdfProofOfConceptViewControllerGridViewTileSpacing = 0; // space between pages

@implementation PdfProofOfConceptViewController
@synthesize viewWithPdf;
@synthesize currentPage;

- (void)dealloc
{
    [viewWithPdf release];
	[super dealloc];
}

#pragma mark - View lifecycle

-(void) viewDidLoad
{
	[super viewDidLoad];
	viewWithPdf.delegate = self;
	currentPage = 1;
	[self addPdfPagesToView:1 withPageRange:10 withPdfFile:@"dontjustrollthedice"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark ScrollView delegates

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	DEBUG_LOGF(@"scrollViewDidEndDragging x = %d", scrollView.contentOffset.x);
}

#pragma mark - private methods

// draw pages of the pdf file in page Range 
-(void) addPdfPagesToView:(NSInteger)pageNumber withPageRange:(NSInteger)pageRange withPdfFile:(NSString*)fileName
{
	for (UIScrollView* view in viewWithPdf.subviews) 
	{
		[view removeFromSuperview];
	}
	
	CGFloat maxContentWidth = CGRectGetMaxX (self.view.frame);
	
	// draw from pageNumber to pageRange pdf pages and add to scroll view
	for (int i=pageNumber; i<=pageRange; i++) 
	{
		PdfView* pdfView = [[PdfView alloc] initWithFrame:self.view.frame withPdfFile:fileName withPdfPage:i]; // create and view and draw a page on it
		pdfView.frame = CGRectMake(maxContentWidth, viewWithPdf.frame.origin.y, pdfView.frame.size.width, pdfView.frame.size.height);
		[viewWithPdf addSubview:pdfView]; // add pdf view to scroll view
		maxContentWidth =  CGRectGetMaxX( pdfView.frame ) + kPdfProofOfConceptViewControllerGridViewTileSpacing; 
		[pdfView release];
	}

	//[viewWithPdf setContentSize:self.view.frame.size]; // set the size of the scroll view


	// Set scroller's content height
	[viewWithPdf setContentSize: CGSizeMake (maxContentWidth, self.view.frame.size.height)];
}

@end
