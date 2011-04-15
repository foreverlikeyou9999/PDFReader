//
//  PdfProofOfConceptViewController.m
//  PdfProofOfConcept
//
//  Created by andrew batutin on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PdfProofOfConceptViewController.h"

@implementation PdfProofOfConceptViewController
@synthesize viewWithPdf;

- (void)dealloc
{
    [viewWithPdf release];
	[super dealloc];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
