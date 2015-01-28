//
//  ViewController.h
//  YukkuriDestroyer
//
//  Created by y-ohta on 2014/10/27.
//

#import <GLKit/GLKit.h>

#import "GLEShelper.h"
#import "TextureData.h"
#import "GLESdrawWithParts.h"
#import "PtYukkuri.h"
#import "YukkuriGroup.h"
#import "NumberGroup.h"
#import "GameManager.h"

@interface ViewController : GLKViewController {
@private
	GLEShelper* m_gleshelper;
	GLESdrawWithParts* m_drawobj;
	TextureData* m_textures;
	YukkuriGroup* m_yukkuribuilder;
	NumberGroup* m_numbers;
	GameManager* m_gamemanager;
}



@end

