//
//  PdfProofOfConceptViewController.m
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PdfProofOfConceptViewController.h"

@implementation PdfProofOfConceptViewController
@synthesize viewWithPdf;
@synthesize currentPage;
@synthesize addPageButton;

- (void)dealloc
{
    [addPageButton release];
	[viewWithPdf release];
	[super dealloc];
}

#pragma mark - View lifecycle

-(void) viewDidLoad
{
	[super viewDidLoad];
	viewWithPdf.delegate = self;
	currentPage = 1;
	// add number of pages
	[viewWithPdf creatPdfPage:currentPage withPdfFile:@"dontjustrollthedice" delegate:self]; // show
	//[viewWithPdf loadPdfPageNumberToArray:i withPdfFile:@"dontjustrollthedice" delegate:self];

	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	
}

- (IBAction)addPageButton:(id)sender
{
	[viewWithPdf creatPdfPage:++currentPage withPdfFile:@"dontjustrollthedice" delegate:self]; // show
	
}

#pragma mark PdfProofOfConceptDelegate 
// when the pdf view is created we resize and ad it to the scroll view
-(PdfView*)pdfPageIsLoaded:(PdfView*)pdfView withNumber:(NSInteger) number
{
	return pdfView;
}

@end
