//
//  GLESdraw.m
//  GLGravity
//
//  Created by y-ohta on 2014/10/15.
//
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "GLEShelper.h"

@implementation GLEShelper

-(id)init {
	self = [super init];

	m_depthRenderbuffer = 0;

	m_disp_w = 0.0f;
	m_disp_h = 0.0f;

	m_context = nil;
	
	return self;
}
+(id)helperWithView:(GLKView *)view {
	GLEShelper* ret = [self alloc];
	[ret initWithView:view];
	
	return ret;
}

-(void)dealloc {
	if (m_context != nil) {
		if([EAGLContext currentContext] == m_context) {
			[EAGLContext setCurrentContext:nil];
		}
//		[m_context release];
	}

//	[super dealloc];
}

-(BOOL)initWithView:(GLKView *)view {
	m_context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
	
	if (!m_context || ![EAGLContext setCurrentContext:m_context]) {
		return FALSE;
	}
	view.context = m_context;

	return TRUE;
}

-(void)setDispSize:(float)disp_w :(float)disp_h {
	m_disp_w = disp_w;
	m_disp_h = disp_h;
}

-(void)initView {

//	glShadeModel(GL_SMOOTH);
//	glEnable(GL_DEPTH_TEST);
	
	//Configure OpenGL arrays
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnableClientState(GL_VERTEX_ARRAY);
//	glEnableClientState(GL_NORMAL_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);

	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	//Set the OpenGL projection matrix
	glMatrixMode(GL_PROJECTION);
	glViewport(0, 0, m_disp_w, m_disp_h);
	
	NSLog(@"%f:%f", m_disp_w, m_disp_h);
}

-(EAGLContext*)getContext {
	return m_context;
}
-(void)setCurrentContext {
	[EAGLContext setCurrentContext:[self getContext]];
}

-(void)Begin {
//	glBindFramebufferOES(GL_FRAMEBUFFER_OES, [self getViewFramebuffer]);
	glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	glLoadIdentity();
}
-(void)Present {
//	glBindRenderbufferOES(GL_RENDERBUFFER_OES, [self getViewRenderbuffer]);
//	[[self getContext] presentRenderbuffer:GL_RENDERBUFFER_OES];
}

-(unsigned int)getDepthRenderbuffer {
	return m_depthRenderbuffer;
}

-(float)getDispW {
	return m_disp_w*2.0f;
}
-(float)getDispH {
	return m_disp_h*2.0f;
}

-(float)getRenderW {
	return m_disp_w;
}
-(float)getRenderH {
	return m_disp_h;
}

@end

