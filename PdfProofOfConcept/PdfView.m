//
//  PdfView.m
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PdfView.h"
#import <QuartzCore/QuartzCore.h>


@implementation PdfView
@synthesize pageToDraw;
@synthesize pdfFileName;

- (void)dealloc
{
    [pdfFileName release];
	[super dealloc];
}

// init with the file name and page to display
- (id)initWithFrame:(CGRect)frame withPdfFile:(NSString*) fileName withPdfPage:(NSInteger) pageNumber
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		pdfFileName = fileName;
		pageToDraw = pageNumber;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	NSURL* fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:pdfFileName ofType:@"pdf"]];
	MyDisplayPDFPage (UIGraphicsGetCurrentContext(),pageToDraw,(CFURLRef)fileURL, self);
}

#pragma mark Quartz functions

// create a reference for PDF file
CGPDFDocumentRef CGPDFDocumentCreateX(CFURLRef theURL)
{
	CGPDFDocumentRef thePDFDocRef = NULL;
	
	if (theURL != NULL) // Check for non-NULL CFURLRef
	{
		thePDFDocRef = CGPDFDocumentCreateWithURL(theURL);
	}
	else // Log an error diagnostic
	{
#ifdef DEBUG
		NSLog(@"CGPDFDocumentCreateX: theURL == NULL");
#endif
	}
	
	return thePDFDocRef;
}

// draw the pdf page
void MyDisplayPDFPage (CGContextRef myContext, size_t pageNumber, CFURLRef theURL, UIView* view)
{
    CGPDFDocumentRef document = CGPDFDocumentCreateX (theURL); // get the reference for PDf in QuartzCore style
	
	// drawing a white rectangle to make a background for pdf
	// drawing with a white stroke color
	CGContextSetRGBStrokeColor(myContext, 1.0, 1.0, 1.0, 1.0);
	// drawing with a white fill color
	CGContextSetRGBFillColor(myContext, 1.0, 1.0, 1.0, 1.0);
	// Add Filled Rectangle, 
	CGContextFillRect(myContext, CGRectMake(0.0, 0.0, view.frame.size.width, view.frame.size.height));
	
	if(document) // if pdf file exist
    {
        CGPDFPageRef page = CGPDFDocumentGetPage(document, pageNumber);
		
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(ctx);
        // convert context to coordinate system (see Quartz coordinate system)
        CGContextTranslateCTM(ctx, 0.0, [view bounds].size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextConcatCTM(ctx, 
						   CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, 
														[view bounds], 0, true));
        
        CGContextDrawPDFPage(ctx, page); // draw Pdf Page   
        CGContextRestoreGState(ctx);
    }
	
	UIGraphicsEndImageContext();
}

@end
