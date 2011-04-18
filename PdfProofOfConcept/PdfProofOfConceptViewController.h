//
//  PdfProofOfConceptViewController.h
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PdfProofOfConceptViewController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView* viewWithPdf; // view wich contains pdf data
	NSInteger currentPage; // current page shown;
}

@property (nonatomic, retain) IBOutlet  UIScrollView* viewWithPdf; // view wich contains pdf data
@property (nonatomic, readwrite) NSInteger currentPage; // current page shown;

// draw pages of the pdf file in page Range 
-(void) addPdfPagesToView:(NSInteger)pageNumber withPageRange:(NSInteger)pageRange withPdfFile:(NSString*)fileName;

@end
