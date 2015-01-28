/*
 File: PVRTexture.h
 */

#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface PVRTexture : NSObject {
	NSMutableArray* m_imageData;
	
	uint32_t m_width;
	uint32_t m_height;
	GLenum m_internalFormat;
	BOOL m_hasAlpha;
}

- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfURL:(NSURL *)url;
+ (id)pvrTextureWithContentsOfFile:(NSString *)path;
+ (id)pvrTextureWithContentsOfURL:(NSURL *)url;

@end
