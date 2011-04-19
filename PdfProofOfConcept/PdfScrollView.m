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
@synthesize arrayOfPdfViews;
@synthesize numberOfPdfPageToLoad;

- (void)dealloc
{
	[arrayOfPdfViews release];
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
	numberOfPdfPageToLoad = 3;
	arrayOfPdfViews = [[NSArray alloc] init];
}


// create a pdf view and send it ot the delegate
-(void)creatPdfPage:(NSInteger)pageNumber withPdfFile:(NSString*)fileName delegate:(UIViewController<PdfProofOfConceptDelegate>*)delegate
{	
	
	// Add a block operation to the operation queue
	[opqueue addOperationWithBlock:^{
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; // just in case
		
		PdfView* pdfView = [[PdfView alloc] initWithFrame:self.frame withPdfFile:fileName withPdfPage:pageNumber]; // create and view and draw a page on it
		pdfView.frame = CGRectMake(maxContentWidth, self.frame.origin.y, pdfView.frame.size.width, pdfView.frame.size.height); // resize the pdf view and put to the right position
		maxContentWidth =  CGRectGetMaxX( pdfView.frame ) + pdfPagesSpacing; // get the width of the scroll view 
		[self setContentSize: CGSizeMake (maxContentWidth, self.frame.size.height)]; // update scroll view size
		// send view to delegate
		if( [delegate respondsToSelector:@selector(pdfPageIsLoaded:withNumber:)] )
		{
			[self addSubview:[delegate pdfPageIsLoaded:pdfView withNumber:pageNumber]];
			[self loadPdfPageNumberToArray:pdfView]; // check if the view to add have to remove old pdf view 
		}
		
		// mmmeeemmmooorrryyy
		[pdfView release];
		[pool drain];
		
	}];		
}

// arrayOfPdfViews contains all the pdf view we have
// this method checks the number of views to add to scroll view
// if the number of views is bigger then numberOfPdfPageToLoad, then old view is removed
-(void)loadPdfPageNumberToArray:(PdfView*)pdfView 
{
	if ( [arrayOfPdfViews count] < numberOfPdfPageToLoad )
	{
		NSMutableArray* bufferArray = [[NSMutableArray alloc] initWithArray:arrayOfPdfViews];
		[bufferArray addObject:pdfView];
		[arrayOfPdfViews release];
		arrayOfPdfViews = [[NSArray alloc] initWithArray:bufferArray];
		[bufferArray release];
		
	}
	else
		// if we have more then numberOfPdfPageToLoad loaded then we delete first from left and add one to right
	if ( [arrayOfPdfViews count]>0 )
	{
		NSMutableArray* bufferArray = [[NSMutableArray alloc] initWithArray:arrayOfPdfViews]; // copy of the arrayOfPdfViews to work with
		// set the maxContentWidth to start it count again
		maxContentWidth = 0;
		//iterate the array exept first object and put the views from left to right from the self.x = 0 
		for (int i = 1; i<[bufferArray count]; i++) 
		{
			PdfView* pdfViewBuf = [bufferArray objectAtIndex:i]; // get the pdf view
			pdfViewBuf.frame = CGRectMake(maxContentWidth, self.frame.origin.y, pdfViewBuf.frame.size.width, pdfViewBuf.frame.size.height); // resize the pdf view and put to the right position
			maxContentWidth =  CGRectGetMaxX( pdfViewBuf.frame ) + (float) pdfPagesSpacing; // get the width of the scroll view 
		}
		[self setContentSize: CGSizeMake (maxContentWidth + self.frame.size.width, self.frame.size.height)]; // update scroll view size
		
		[[bufferArray objectAtIndex:0] removeFromSuperview]; // remove extra view from superview
		[bufferArray removeObjectAtIndex:0]; // remove pdfview as object from array
		[bufferArray addObject:pdfView]; // add new view to the array
		[arrayOfPdfViews release]; // clear the array
		arrayOfPdfViews = [[NSArray alloc] initWithArray:bufferArray]; // init it with the new views
		[bufferArray release]; // release
	}
}

@end
