//
//  GLESdraw.m
//  Created by y-ohta on 2014/10/15.

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "matrix2.h"
#import "GLESdraw.h"

@implementation GLESdraw

+(id)GLESdrawWithHelper:(GLEShelper*)helper {
	return [[self alloc] initWithHelper:helper];
}

-(id)initWithHelper:(GLEShelper*)helper {
	if (self = [super init]) {
		m_helper = helper;
		
		for (int i = 0; i < 4; i++) {
			m_color1[i] = 0.0f;
			m_color2[i] = 0.0f;
			m_color3[i] = 0.0f;
			m_color4[i] = 0.0f;
		}
	}
	return self;
}

-(void)drawTriangle {
	float vertices [] = {
		-1.0f, -1.0f,
		1.0f, -1.0f,
		0.0f, 1.0f
	};

	float colors[] = {
		1.0f, 1.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f, 1.0f,
		1.0f, 0.0f, 1.0f, 1.0f,
	};

	float texcood [] = {
		0.0f, 0.0f,
		1.0f, 0.0f,
		0.0f, 1.0f
	};

	glColorPointer(4, GL_FLOAT, 0, colors);
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glTexCoordPointer(2, GL_FLOAT, 0, texcood);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 3);
}

-(void)drawLine:(float)sx :(float)sy :(float)ex :(float)ey {
	glDisable(GL_TEXTURE_2D);

	float start_x = -1.0f + (sx / [m_helper getRenderW]);
	float end_x = -1.0f + (ex / [m_helper getRenderW]);
	float start_y = 1.0f - (sy / [m_helper getRenderH]);
	float end_y = 1.0f - (ey / [m_helper getRenderH]);

	float vertices[] = {
		start_x, start_y,
		end_x, end_y
	};

/*
	float vertices[] = {
		-1.0f, 1.0f,
		1.0f, -1.0f
	};
*/
	float colors[] = {
		1.0f, 1.0f, 0.0f, 1.0f,
		0.0f, 1.0f, 0.0f, 1.0f
	};

	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glColorPointer(4, GL_FLOAT, 0, colors);
	glDrawArrays(GL_LINES, 0, 2);
}

// With Texture
-(void)drawRect:(vector2*)pos :(vector2*)size :(vector2*)uv :(vector2*)uvsize :(vector2*)texsize {
	glEnable(GL_TEXTURE_2D);

	float w = [size x] / [m_helper getRenderW];
	float h = [size y] / [m_helper getRenderH];

	float x = [pos x] / [m_helper getRenderW];
	float y = [pos y] / [m_helper getRenderH];
	
	vector2* posl = [vector2 vector2WithXY:x :-y];

	float start_x = -1.0f;
	float end_y = 1.0f;
	float start_y = end_y - h;
	float end_x = start_x + w;

	vector2* v[4];
	v[0] = [vector2 vector2WithXY:start_x :start_y];
	v[1] = [vector2 vector2WithXY:end_x :start_y];
	v[2] = [vector2 vector2WithXY:start_x :end_y];
	v[3] = [vector2 vector2WithXY:end_x :end_y];

	float uv_u = [uv x] / [texsize x];
	float uv_v = [uv y] / [texsize y];
	float uv_w = [uvsize x] / [texsize x];
	float uv_h = [uvsize y] / [texsize y];
	
	for (int i = 0; i < 4; i++) {
		[v[i] add:posl];
	}

	float vertices[] = {
		[v[0] x], [v[0] y],
		[v[1] x], [v[1] y],
		[v[2] x], [v[2] y],
		[v[3] x], [v[3] y]
	};

	float colors[] = {
		m_color1[0], m_color1[1], m_color1[2], m_color1[3],
		m_color2[0], m_color2[1], m_color2[2], m_color2[3],
		m_color3[0], m_color3[1], m_color3[2], m_color3[3],
		m_color4[0], m_color4[1], m_color4[2], m_color4[3],
	};

	float coords[] = {
		uv_u, uv_v + uv_h,
		uv_u + uv_w, uv_v + uv_h,
		uv_u, uv_v,
		uv_u + uv_w, uv_v,
	};

	unsigned short indicies[] = {
		0, 1, 2, 3
	};

	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glTexCoordPointer(2, GL_FLOAT, 0, coords);
	glColorPointer(4, GL_FLOAT, 0, colors);
	glDrawElements(GL_TRIANGLE_STRIP, 4, GL_UNSIGNED_SHORT, indicies);
}

// Without Texture
-(void)drawBlock:(vector2*)pos :(vector2*)size; {
	glDisable(GL_TEXTURE_2D);
	
	float w = [size x] / [m_helper getRenderW];
	float h = [size y] / [m_helper getRenderH];
	
	float x = [pos x] / [m_helper getRenderW];
	float y = [pos y] / [m_helper getRenderH];
	
	vector2* posl = [vector2 vector2WithXY:x :-y];
	
	float start_x = -1.0f;
	float end_y = 1.0f;
	float start_y = end_y - h;
	float end_x = start_x + w;
	
	vector2* v[4];
	v[0] = [vector2 vector2WithXY:start_x :start_y];
	v[1] = [vector2 vector2WithXY:end_x :start_y];
	v[2] = [vector2 vector2WithXY:start_x :end_y];
	v[3] = [vector2 vector2WithXY:end_x :end_y];
	
	for (int i = 0; i < 4; i++) {
		[v[i] add:posl];
	}
	
	float vertices[] = {
		[v[0] x], [v[0] y],
		[v[1] x], [v[1] y],
		[v[2] x], [v[2] y],
		[v[3] x], [v[3] y]
	};
	
	float colors[] = {
		m_color1[0], m_color1[1], m_color1[2], m_color1[3],
		m_color2[0], m_color2[1], m_color2[2], m_color2[3],
		m_color3[0], m_color3[1], m_color3[2], m_color3[3],
		m_color4[0], m_color4[1], m_color4[2], m_color4[3],
	};
	
	unsigned short indicies[] = {
		0, 1, 2, 3
	};
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glColorPointer(4, GL_FLOAT, 0, colors);
	glDrawElements(GL_TRIANGLE_STRIP, 4, GL_UNSIGNED_SHORT, indicies);
	
//	[posl release];
//	for (int i = 0; i < 4; i++) {
//		[v[i] release];
//	}
}

-(void)setColor1:(float)r :(float)g :(float)b :(float)a {
	m_color1[0] = r;
	m_color1[1] = g;
	m_color1[2] = b;
	m_color1[3] = a;
}
-(void)setColor2:(float)r :(float)g :(float)b :(float)a {
	m_color2[0] = r;
	m_color2[1] = g;
	m_color2[2] = b;
	m_color2[3] = a;
}
-(void)setColor3:(float)r :(float)g :(float)b :(float)a {
	m_color3[0] = r;
	m_color3[1] = g;
	m_color3[2] = b;
	m_color3[3] = a;
}
-(void)setColor4:(float)r :(float)g :(float)b :(float)a {
	m_color4[0] = r;
	m_color4[1] = g;
	m_color4[2] = b;
	m_color4[3] = a;
}
-(void)setColors:(float)r :(float)g :(float)b :(float)a {
	[self setColor1:r :g :b :a];
	[self setColor2:r :g :b :a];
	[self setColor3:r :g :b :a];
	[self setColor4:r :g :b :a];
}

@end

