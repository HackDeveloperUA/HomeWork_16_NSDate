
#import "AppDelegate.h"
#import "ASStudent.h"

@interface AppDelegate ()

@property (strong , nonatomic) NSDate* currentDate;
@property (strong , nonatomic) NSTimer* currentTimer;
@property (strong , nonatomic) NSMutableDictionary* currentDictionary;
@property (strong , nonatomic) NSDateFormatter* dateFormat;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.dateFormat = [[NSDateFormatter alloc]init];
    [self.dateFormat setDateFormat:@"dd.MM"];
    NSMutableArray* arrayForStudents = [NSMutableArray new];
    
    
    for (int i = 0; i<30; i++) {
        ASStudent* student = [[ASStudent alloc] init];
        [arrayForStudents addObject:student];
    }
    
   
    [arrayForStudents sortUsingComparator:^NSComparisonResult(ASStudent* obj1, ASStudent* obj2) {
        return  ([[obj2 dateOfBirth]   compare:[obj1 dateOfBirth]]);}];

    _currentDictionary = [NSMutableDictionary new];
    NSLog (@"\n\n\n\n");
    
    for (ASStudent* obj in arrayForStudents) {
        NSLog(@"%@",obj);
        NSString* keyString = [NSString stringWithFormat:@"%@",[self.dateFormat stringFromDate:obj.dateOfBirth]];
        [self.currentDictionary setValue:obj forKey:keyString];
    }

    ASStudent* newObj = [arrayForStudents firstObject];
    ASStudent* oldObj = [arrayForStudents lastObject];

    [self objectComparison:newObj andSecondObject:oldObj];
    
    self.currentDate = [[NSDate alloc]init];
    self.currentTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerTest:) userInfo:nil repeats:YES];
    
    return YES;
}


-(void) timerTest:(NSTimer*) timer {

    NSTimeInterval secondsOfDay = 24 * 60 * 60;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components: NSCalendarUnitMonth | NSCalendarUnitDay
                                               fromDate:_currentDate ];
 
    self.currentDate = [_currentDate dateByAddingTimeInterval:secondsOfDay];
    NSLog(@"day - %ld month - %ld ",(long)[components day],(long)[components month]);
    
    ASStudent* obj = nil;
    
    NSString* keyString = [NSString stringWithFormat:@"%@",[self.dateFormat stringFromDate:self.currentDate]];
    obj = [self.currentDictionary objectForKey:keyString];
   
    if (obj) {
        obj.dateAge++;
      NSLog(@"\n\n---------------------------------------");
      NSLog(@"Сегодня день рожденье у %@ %@ - рожден в - %@ ",obj.name , obj.famaly, [self.dateFormat stringFromDate:obj.dateOfBirth]);
      NSLog(@"Было %ld | Стало %ld",(NSInteger)obj.dateAge-1, (long)obj.dateAge);
      NSLog(@"\n\n---------------------------------------");

    }
}


-(void) objectComparison:(ASStudent*) oldObj andSecondObject:(ASStudent*) newObj {
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitWeekOfMonth | NSCalendarUnitDay  fromDate:oldObj.dateOfBirth toDate:newObj.dateOfBirth options:0];
    
    NSLog(@"%@ от %@ | year - %ld | month - %ld | weekday %ld | day %ld",oldObj.name, newObj.name, (long)components.year , (long)components.month, (long)components.weekOfMonth, (long)components.day);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
