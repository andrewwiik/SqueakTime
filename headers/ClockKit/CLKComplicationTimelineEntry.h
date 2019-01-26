#import "CLKComplicationTemplate.h"

@interface CLKComplicationTimelineEntry : NSObject
+ (instancetype)entryWithDate:(NSDate *)date complicationTemplate:(id)arg2 ;
+ (instancetype)entryWithDate:(NSDate *)date complicationTemplate:(id)arg2 timelineAnimationGroup:(id)arg3 ;
@property (nonatomic,retain) NSDate *date;
@property (nonatomic,copy) CLKComplicationTemplate *complicationTemplate;
@end