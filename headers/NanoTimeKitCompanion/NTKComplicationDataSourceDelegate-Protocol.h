#import <Foundation/NSObject.h>

@protocol NTKComplicationDataSourceDelegate <NSObject>
@required
-(void)invalidateSwitcherTemplate;
-(void)invalidateEntries;
-(void)setTimelineStartDate:(id)arg1;
-(void)setTimelineEndDate:(id)arg1;
-(void)appendEntries:(id)arg1;
-(double)minimumIntervalBetweenTimelineEntries;
@end