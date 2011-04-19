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
	for (int i = 5; i < 8; i++)
	{
		[viewWithPdf creatPdfPage:i withPdfFile:@"dontjustrollthedice" delegate:self]; // show
	}
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark PdfProofOfConceptDelegate 
// when the pdf view is created we resize and ad it to the scroll view
-(PdfView*)pdfPageIsLoaded:(PdfView*)pdfView withNumber:(NSInteger) number
{
	return pdfView;
}

@end
