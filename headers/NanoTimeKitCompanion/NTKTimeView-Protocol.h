#import <Foundation/NSObject.h>

@protocol NTKTimeView <NSObject>
@property (assign,getter=isFrozen,nonatomic) BOOL frozen; 
@required
-(void)setTimeOffset:(CGFloat)offset;
-(BOOL)isFrozen;
-(void)setFrozen:(BOOL)frozen;
-(void)setOverrideDate:(NSDate *)date duration:(CGFloat)duration;

@end