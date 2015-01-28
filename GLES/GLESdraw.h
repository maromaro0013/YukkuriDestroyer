//
//  GLESdraw.h
//  Created by y-ohta on 2014/10/15.

#import "GLEShelper.h"
#import "matrix2.h"

@interface GLESdraw : NSObject {
@private
	GLEShelper* m_helper;

	float m_color1[4];
	float m_color2[4];
	float m_color3[4];
	float m_color4[4];
}

+(id)GLESdrawWithHelper:(GLEShelper*)helper;
-(id)initWithHelper:(GLEShelper*)helper;

-(void)drawTriangle;
-(void)drawLine:(float)sx :(float)sy :(float)ex :(float)ey;

-(void)drawRect:(vector2*)pos :(vector2*)size :(vector2*)uv :(vector2*)uvsize :(vector2*)texsize;
-(void)drawBlock:(vector2*)pos :(vector2*)size;

-(void)setColor1:(float)r :(float)g :(float)b :(float)a;
-(void)setColor2:(float)r :(float)g :(float)b :(float)a;
-(void)setColor3:(float)r :(float)g :(float)b :(float)a;
-(void)setColor4:(float)r :(float)g :(float)b :(float)a;
-(void)setColors:(float)r :(float)g :(float)b :(float)a;

@end
