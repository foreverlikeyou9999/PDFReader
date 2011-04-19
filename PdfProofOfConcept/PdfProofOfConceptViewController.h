//
//  PdfProofOfConceptViewController.h
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdfScrollView.h"

@interface PdfProofOfConceptViewController : UIViewController <UIScrollViewDelegate, PdfProofOfConceptDelegate>
{
    PdfScrollView* viewWithPdf; // view wich contains pdf data
	NSInteger currentPage; // current page shown;
	
	UIButton* addPageButton;
}
@property (nonatomic, retain) IBOutlet UIButton* addPageButton;
@property (nonatomic, retain) IBOutlet  UIScrollView* viewWithPdf; // view wich contains pdf data
@property (nonatomic, readwrite) NSInteger currentPage; // current page shown;

- (IBAction)addPageButton:(id)sender;

@end
