//
//  GLEShelper.h
//
//  Created by y-ohta on 2014/10/15.

#import <GLKit/GLKit.h>

@interface GLEShelper : NSObject {
@private
	unsigned int m_depthRenderbuffer;

	EAGLContext *m_context;

	// The pixel dimensions of the backbuffer
	GLint m_backingWidth;
	GLint m_backingHeight;

	float m_disp_w;
	float m_disp_h;
}

-(id)init;
+(id)helperWithView:(GLKView *)view;

-(void)dealloc;
-(BOOL)initWithView:(GLKView *)view;
-(void)setDispSize:(float)disp_w :(float)disp_h;

-(void)initView;

-(EAGLContext*)getContext;
-(void)setCurrentContext;

-(void)Begin;
-(void)Present;

-(unsigned int)getDepthRenderbuffer;

-(float)getDispW;
-(float)getDispH;

-(float)getRenderW;
-(float)getRenderH;

@end

