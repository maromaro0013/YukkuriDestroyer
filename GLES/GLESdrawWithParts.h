//
//  GLESdraw.h
//  Created by y-ohta on 2014/10/15.

#import "GLESdraw.h"
#import "PartsBase.h"
#import "TextureData.h"

@interface GLESdrawWithParts : GLESdraw {
@private
	;
}

+(id)GLESdrawWithHelper:(GLEShelper*)helper;
-(id)initWithHelper:(GLEShelper*)helper;

-(void)drawParts:(PartsBase*)parts :(TextureData*)texture;

@end