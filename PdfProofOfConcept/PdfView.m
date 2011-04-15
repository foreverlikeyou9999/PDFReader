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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	NSURL* fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"dontjustrollthedice" ofType:@"pdf"]];
	MyDisplayPDFPage (UIGraphicsGetCurrentContext(),10,(CFURLRef)fileURL, self);
}

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

void MyDisplayPDFPage (CGContextRef myContext, size_t pageNumber, CFURLRef theURL, UIView* view)
{
    CGPDFDocumentRef document;
    CGPDFPageRef page;
	
    document = CGPDFDocumentCreateX (theURL);// 1
    page = CGPDFDocumentGetPage (document, pageNumber);// 2
	CGContextSaveGState(myContext);
	CGContextTranslateCTM( myContext, 0, view.frame.size.height );
	CGContextScaleCTM(myContext, 0.8, -0.8);  
	CGContextDrawPDFPage (myContext, page);// 3
	CGContextRestoreGState(myContext);
    CGPDFDocumentRelease (document);// 4
}

- (void)dealloc
{
    [super dealloc];
}

@end
