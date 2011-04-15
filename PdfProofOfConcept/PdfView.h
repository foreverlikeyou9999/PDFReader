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
    
}
void MyDisplayPDFPage (CGContextRef myContext,
					   size_t pageNumber,
					   CFURLRef theURL, UIView* view);
@end
