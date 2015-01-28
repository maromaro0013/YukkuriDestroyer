//
//  GameManager.m
//
//  Created by y-ohta on 2014/10/24.

#import "GameManager.h"

@implementation GameManager

-(id)init {
	self = [super init];

	m_score = 0;
	m_time = 0;
	m_time_limit = 0;

	return self;
}

-(void)setScore:(int)score {
	m_score = score;
}
-(int)getScore {
	return m_score;
}

-(void)setTimeLimit:(int)time {
	m_time_limit = time;
	
}
-(void)setTime:(int)time {
	m_time = time;
}
-(int)getTime {
	return m_time;
}
-(BOOL)countTime {
	if (++m_time >= m_time_limit) {
		m_time = m_time_limit;
		return TRUE;
	}
	return FALSE;
}

@end

