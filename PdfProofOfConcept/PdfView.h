//
//  PdfView.h
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PdfView : UIView 
{
    NSInteger pageToDraw; // number of page to draw
	NSString* pdfFileName; // name of the pdf file, no extension
}

@property (nonatomic, readonly) NSInteger pageToDraw; // number of page to draw
@property (nonatomic, retain) NSString* pdfFileName; // name of the pdf file, no extension

- (id)initWithFrame:(CGRect)frame withPdfFile:(NSString*) fileName withPdfPage:(NSInteger) pageNumber;

void MyDisplayPDFPage (CGContextRef myContext, size_t pageNumber, CFURLRef theURL, UIView* view);
// create a reference for PDF file
CGPDFDocumentRef CGPDFDocumentCreateX(CFURLRef theURL);

@end
