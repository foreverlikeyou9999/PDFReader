//
//  PdfScrollView.m
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PdfScrollView.h"

@implementation PdfScrollView
@synthesize maxContentWidth;
@synthesize pdfPagesSpacing;
@synthesize queuePagesToLoadConcurrently;

- (void)dealloc
{
	[opqueue cancelAllOperations];
	[opqueue release];
	[super dealloc];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
		[self initOperationQueue];
	}
	
	return self;
}

// init operation queue
-(void) initOperationQueue
{
	opqueue = [[NSOperationQueue alloc] init];
	queuePagesToLoadConcurrently = 1; // number of threads to load pages
	[opqueue setMaxConcurrentOperationCount:queuePagesToLoadConcurrently]; // set number of pages to load concurrently
	maxContentWidth = 0;
	pdfPagesSpacing = 0;
}


// create a pdf view and send it ot the delegate
-(void)creatPdfPage:(NSInteger)pageNumber withPdfFile:(NSString*)fileName delegate:(UIViewController<PdfProofOfConceptDelegate>*)delegate
{	
	// Add a block operation to the operation queue
	[opqueue addOperationWithBlock:^{
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; // just in case
		
		PdfView* pdfView = [[PdfView alloc] initWithFrame:delegate.view.frame withPdfFile:fileName withPdfPage:pageNumber]; // create and view and draw a page on it
		pdfView.frame = CGRectMake(maxContentWidth, self.frame.origin.y, pdfView.frame.size.width, pdfView.frame.size.height); // resize the pdf view and put to the right position
		maxContentWidth =  CGRectGetMaxX( pdfView.frame ) + pdfPagesSpacing; // get the width of the scroll view 
		[self setContentSize: CGSizeMake (maxContentWidth, delegate.view.frame.size.height)]; // update scroll view size
		// send view to delegate
		if( [delegate respondsToSelector:@selector(pdfPageIsLoaded:withNumber:)] )
			[self addSubview:[delegate pdfPageIsLoaded:pdfView withNumber:pageNumber]];
		// mmmeeemmmooorrryyy
		[pdfView release];
		[pool drain];
		
	}];		
}

@end
