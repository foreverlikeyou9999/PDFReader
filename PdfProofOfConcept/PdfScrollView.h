//
//  PdfScrollView.h
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/* This class provides scrollview with the pdf pages wich are added by
 
 -(void)creatPdfPage:(NSInteger)pageNumber withPdfFile:(NSString*)fileName delegate:(UIViewController<PdfProofOfConceptDelegate>*)delegate;
method
 
*/

#import <Foundation/Foundation.h>
#import "PdfView.h"

// protocol to load pdf page
@protocol PdfProofOfConceptDelegate <NSObject>

-(PdfView*)pdfPageIsLoaded:(PdfView*)pdfView withNumber:(NSInteger) number;

@end

@interface PdfScrollView : UIScrollView 
{
    NSOperationQueue *opqueue; // queue to lad pdf page
	CGFloat maxContentWidth; // max widrh of the scroll view
	NSInteger pdfPagesSpacing; // TODO - if pdfPagesSpacing>0 then layout is not right, the pages moves to right
	NSInteger queuePagesToLoadConcurrently; // NSOperationQueue parameter - number of NSOperation processing concurrently. If queuePagesToLoadConcurrently > 1 then the pages could be added in different sequence.
	NSArray* arrayOfPdfViews; // array wich have all the loaded pdf pages;
	NSInteger numberOfPdfPageToLoad; // number of the Pdf pages loaded to scroll view
}

@property (nonatomic, retain) NSArray* arrayOfPdfViews; // array wich have all the loaded pdf pages;
@property (nonatomic, readwrite) CGFloat maxContentWidth; // max widrh of the scroll view
@property (nonatomic, readwrite) NSInteger pdfPagesSpacing;
@property (nonatomic, readwrite) NSInteger queuePagesToLoadConcurrently;
@property (nonatomic, readwrite) NSInteger numberOfPdfPageToLoad; // number of the Pdf pages loaded to scroll view

-(void)creatPdfPage:(NSInteger)pageNumber withPdfFile:(NSString*)fileName delegate:(UIViewController<PdfProofOfConceptDelegate>*)delegate;
// init operation queue
-(void) initOperationQueue;
-(void)loadPdfPageNumberToArray:(PdfView*)pdfView;

@end
