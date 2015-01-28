//
//  vector2.h
//
//  Created by y-ohta on 2014/10/15.

@interface vector2 : NSObject {
	float m_x;
	float m_y;
}

-(id)init;
+(id)vector2WithXY:(float)x :(float)y;

-(void)set:(float)x :(float)y;

-(void)add:(vector2*)v;
-(void)addX:(float)x;
-(void)addY:(float)y;

-(void)sub:(vector2*)v;

-(void)mul:(vector2*)v;
-(void)smul:(float)f;

-(void)div:(vector2*)v;
-(void)sdiv:(float)f;

-(float)x;
-(float)y;

@end
