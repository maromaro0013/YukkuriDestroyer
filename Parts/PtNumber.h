//
//  PtNumber.h
//
//  Created by y-ohta on 2014/10/24.

#import <Foundation/Foundation.h>
#import "PartsBase.h"

@interface PtNumber: PartsBase {
@private
	int m_number;
}

-(id)init;

-(void)setNumber:(int)number;

@end
