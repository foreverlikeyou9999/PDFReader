//
//  PdfProofOfConceptViewController.h
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PdfProofOfConceptViewController : UIViewController 
{
    UIScrollView* viewWithPdf; // view wich contains pdf data
}

@property (nonatomic, retain) IBOutlet  UIScrollView* viewWithPdf; // view wich contains pdf data

@end
