//
//  matrix2.h
//
//  Created by y-ohta on 2014/10/15.

#import "vector2.h"

@interface matrix2 : NSObject {
@private
	vector2 *m_v1;
	vector2 *m_v2;
}

-(id)init;
-(void)identity;
-(void)rotation:(float)f;
-(vector2*)Vector2Matrix2:(vector2*)v;

@end
