//
//  PdfProofOfConceptViewController.h
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdfView.h"

// protocol to load pdf page
@protocol PdfProofOfConceptDelegate <NSObject>

-(void)pdfPageIsLoaded:(PdfView*)pdfView withNumber:(NSInteger) number;

@end

@interface PdfProofOfConceptViewController : UIViewController <UIScrollViewDelegate, PdfProofOfConceptDelegate>
{
    UIScrollView* viewWithPdf; // view wich contains pdf data
	NSInteger currentPage; // current page shown;
	NSOperationQueue *opqueue; // queue to lad pdf page
	CGFloat maxContentWidth; // max widrh of the scroll view
}

@property (nonatomic, retain) IBOutlet  UIScrollView* viewWithPdf; // view wich contains pdf data
@property (nonatomic, readwrite) NSInteger currentPage; // current page shown;

// draw pages of the pdf file in page Range 
-(void) addPdfPagesToView:(NSInteger)pageNumber withPageRange:(NSInteger)pageRange withPdfFile:(NSString*)fileName;
// draw one page
-(void)creatPdfPage:(NSInteger)pageNumber withPdfFile:(NSString*)fileName delegate:(id<PdfProofOfConceptDelegate>)delegate;

@end
