
#import "ASStudent.h"

@implementation ASStudent


-(id) init {
    
    self = [super init];
    
    if (self) {
  
  NSArray* arrayForNames  = [NSArray arrayWithObjects:@"Jhon",  @"Jack",   @"William", @"Thomas", @"Walter", nil];
  NSArray* arrayForFamaly = [NSArray arrayWithObjects:@"Smith", @"Taylor", @"Harris",  @"Martin", @"Adams", nil];

  NSDate*           date = [NSDate date];
  NSCalendar*       calendar = [NSCalendar currentCalendar];
  NSDateFormatter*  dateFormat = [[NSDateFormatter alloc] init];

  [dateFormat setDateFormat:@"dd.MM.yyyy"];

  NSDateComponents* components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth |
                                                       NSCalendarUnitDay   fromDate:date];
  NSInteger dateOfBirth = (16 + arc4random() % 34);

 [components setDay:   arc4random() % 32];
 [components setMonth: arc4random() % 13];
 [components setYear:  [components year] - dateOfBirth];

        self.dateOfBirth = [calendar dateFromComponents:components];
        self.dateAge     = dateOfBirth;
        self.name        = [arrayForNames  objectAtIndex: arc4random() % [arrayForNames  count]];
        self.famaly      = [arrayForFamaly objectAtIndex: arc4random() % [arrayForFamaly count]];
    }
    
  return self;
}


-(NSString*) description {
    
    NSDateFormatter* dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    
    
    return [NSString stringWithFormat:@"%@ %@ - %d | Был рожден в - %@",_name, _famaly,
            (NSInteger)_dateAge, [dateFormat stringFromDate:self.dateOfBirth]];
}



@end
