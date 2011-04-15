//
//  PdfProofOfConceptAppDelegate.h
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PdfProofOfConceptViewController;

@interface PdfProofOfConceptAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PdfProofOfConceptViewController *viewController;

@end
