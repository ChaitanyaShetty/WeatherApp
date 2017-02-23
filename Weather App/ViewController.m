//
//  ViewController.m
//  Weather App
//
//  Created by chaitanya on 13/10/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"
#import "Reachability.h"

@interface ViewController () <SearchViewControllerDelegate>

@property (nonatomic) NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.activityIndicator startAnimating];
    
    self.jsonAPI = [[NSDictionary alloc]init];
    self.dateArray = [[NSMutableArray alloc]init];
    self.tempimageViewNameArray = [[NSMutableArray alloc]init];
    self.tempArray = [[NSMutableArray alloc]init];
    self.fahrenheitarray = [[NSMutableArray alloc]init];
    self.feelsArray = [[NSMutableArray alloc]init];
    self.windArray = [[NSMutableArray alloc]init];
    self.humidityArray = [[NSMutableArray alloc]init];
    self.pressureArray = [[NSMutableArray alloc]init];
    self.gustArray = [[NSMutableArray alloc]init];
    self.precipArray = [[NSMutableArray alloc]init];
    self.tempLowArray = [[NSMutableArray alloc]init];
    self.tempHighArray = [[NSMutableArray alloc]init];
    self.addCities = [[NSMutableArray alloc]init];
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    _timeLabel2.text = dateString;
    
    [self getsession:@"http://api.wunderground.com/api/b1da5535bc975303/geolookup/conditions/forecast/q/autoip.json"];

}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self CheckInternet];
//    
//    
//}
//
//- (void)CheckInternet
//{
//    Reachability *r = [Reachability reachabilityForInternetConnection];
//    NetworkStatus internetStatus = [r currentReachabilityStatus];
//    
//    if (internetStatus == NotReachable){
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"no wifi" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
//        [alert addAction:ok];
//        [self presentViewController:alert animated:YES completion:nil];
//    }
//    else {
//        // The stuff if want to do with connection
//        [self getsession:@"http://api.wunderground.com/api/b1da5535bc975303/geolookup/conditions/forecast/q/autoip.json"];
//    }

//}


//- (BOOL) currentNetworkStatus {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    BOOL connected;
//    BOOL isConnected;
//    const char *host = "www.apple.com";
//    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host);
//    SCNetworkReachabilityFlags flags;
//    connected = SCNetworkReachabilityGetFlags(reachability, &flags);
//    isConnected = NO;
//    isConnected = connected && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
//    CFRelease(reachability);
//    return isConnected;
//}

-(void)getsession:(NSString *)jsonUrl {
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidesWhenStopped = YES;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    //    self.urlString  = [NSString stringWithFormat:@"http://api.wunderground.com/api/b1da5535bc975303/geolookup/conditions/forecast/q/India/bangalore.json"];
    
    //    self.urlString = [_urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //   // NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSURL* url = [NSURL URLWithString:jsonUrl];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            
            [self.activityIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                self.jsonAPI = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (_jsonAPI != nil && [self.jsonAPI valueForKey:@"forecast"] != nil) {
                    
                    NSLog(@"All the data %@", self.jsonAPI);
                    
                    
                    self.dataArray = [[[self.jsonAPI valueForKey:@"forecast"]valueForKey:@"simpleforecast"]valueForKey:@"forecastday"];
                    
                    self.dataArray2 = [self.jsonAPI valueForKey:@"current_observation"];
                    
                    self.dataArray3 = [[[self.jsonAPI valueForKey:@"forecast"]valueForKey:@"txt_forecast"]valueForKey:@"forecastday"];
                    
                    self.dataArray4 = [self.jsonAPI valueForKey:@"location"];;
                    self.cityArray = [_dataArray4 valueForKey:@"city"];
                    self.countryArray = [_dataArray4 valueForKey:@"country_name"];
                    NSLog(@"cityarray %@%@", _cityArray, _countryArray);
                    self.navigationItem.title = [NSString stringWithFormat:@"%@, %@", _cityArray, _countryArray];
                    
                    
                    
                    self.pressureImageViewArray = [self.dataArray3 valueForKey:@"icon_url"];
                    NSLog(@"pressureImageViewArray %@" , _pressureImageViewArray);
                    
                    
                    self.feelsImageViewArray = [self.dataArray3 valueForKey:@"icon_url"];
                    NSLog(@"pressureImageViewArray %@" , _feelsImageViewArray);
                    
//                    self.windImageViewArray = [self.dataArray3 valueForKey:@"icon_url"];
//                    NSLog(@"windImageViewArray %@", _windImageViewArray);
                    
                    self.humidityImageViewArray = [self.dataArray3 valueForKey:@"icon_url"];
                    NSLog(@"humidityImageViewArray %@", _humidityImageViewArray);
                    
                    self.gustImageViewArray = [self.dataArray3 valueForKey:@"icon_url"];
                    NSLog(@"gustImageViewArray %@", _gustImageViewArray);
                    
                    self.precipImageViewArray = [self.dataArray3 valueForKey:@"icon_url"];
                    NSLog(@"precipImageViewArray %@", _precipImageViewArray);
                    
                    self.tempLowImageViewArray = [self.dataArray3 valueForKey:@"icon_url"];
                    NSLog(@"tempLowImageViewArray %@", _tempLowImageViewArray);
                    
                    
                    self.tempHighImageViewArray = [self.dataArray3 valueForKey:@"icon_url"];
                    NSLog(@"tempHighImageViewArray %@", _tempHighImageViewArray);
                    
                    
                    self.timeimageArray = [self.dataArray3 valueForKey:@"icon_url"];
                    NSLog(@"timeimageArray %@", _timeimageArray);
                    
                    self.timeimageArray2 = [self.dataArray3 valueForKey:@"icon_url"];
                    NSLog(@"timeimageArray2 %@", _timeimageArray2);
                    
                    
                    
                    
                    
                    self.feelsArray = [self.dataArray2 valueForKey:@"feelslike_c"];
                    NSLog(@"feelsArray data %@", _feelsArray);
                    
                    
                    self.pressureArray = [self.dataArray2 valueForKey:@"pressure_mb"];
                    NSLog(@"pressure array %@", _pressureArray);
                    
                    self.gustArray = [self.dataArray2 valueForKey:@"wind_gust_mph"];
                    NSLog(@"gust array data %@", _gustArray);
                    
                    self.humidityArray = [self.dataArray valueForKey:@"avehumidity"];
                    int tempHumidity = [[_dataArray2 valueForKey:@"relative_humidity"]intValue];
                    NSLog(@"tempHumidity data %@", _humidityArray);
                    
                    
                    
                    self.windArray = [[self.dataArray valueForKey:@"avewind"] valueForKey:@"kph"];
                    self.windArray2 = [[self.dataArray valueForKey:@"avewind"] valueForKey:@"dir"];
                    NSLog(@"wind data %@", _windArray);
                    
                    int tempWind = [[_dataArray2 valueForKey:@"wind_dir"]intValue];
                    int tempWind2 = [[_dataArray2 valueForKey:@"wind_gust_kph"]intValue];
                    
                    
                    
                    self.fahrenheitarray = [[self.dataArray valueForKey:@"high"]valueForKey:@"fahrenheit"];
                    int tempfahrenheit = [[self.dataArray2 valueForKey:@"temp_f"]intValue];
                    NSLog(@"fahrenheit data %@", _fahrenheitarray);
                    
                    self.tempArray = [[self.dataArray valueForKey:@"high"]valueForKey:@"celsius"];
                    int tempCelsius = [[self.dataArray2 valueForKey:@"temp_c"]intValue];
                    
                    self.precipArray = [[self.dataArray valueForKey:@"qpf_allday"]valueForKey:@"in"];
                    NSLog(@"precip data %@", _precipArray);
                    
                    self.tempimageViewNameArray = [self.dataArray valueForKey:@"conditions"];
                    NSLog(@"conditions data %@", _tempimageViewNameArray);
                    
                    self.tempHighArray = [[self.dataArray valueForKey:@"high"]valueForKey:@"celsius"];
                    NSLog(@"temphigh data %@", _tempHighArray);
                    self.tempLowArray = [[self.dataArray valueForKey:@"low"]valueForKey:@"celsius"];
                    NSLog(@"templow data %@", _tempLowArray);
                    
                    self.dateArray = [[self.dataArray valueForKey:@"date"]valueForKey:@"weekday_short"];
                    self.dateArray2 = [[self.dataArray valueForKey:@"date"]valueForKey:@"day"];
                    self.dateArray3 = [[self.dataArray valueForKey:@"date"]valueForKey:@"month"];
                    
                    self.tempImageViewArray = [self.dataArray valueForKey:@"icon_url"];
                    _tempImageViewArray2 = [self.dataArray2 valueForKey:@"icon_url"];
                    NSLog(@"tempimageviewArray data %@", _tempImageViewArray);
                    
                    
                    self.timeArray = [[self.dataArray valueForKey:@"date"]valueForKey:@"hour"];
                    self.timeArray2 = [[self.dataArray valueForKey:@"date"]valueForKey:@"min"];
                    NSLog(@"timearray data %@ %@", _timeArray, _timeArray2);
                    
//                    NSArray *tempHumidity = [_humidityArray objectAtIndex:0];
//                    
                    
//                    NSArray *tempWind = [_windArray objectAtIndex:0];
//                    NSArray *tempWind2 = [_windArray2 objectAtIndex:0];
//                    
//                    NSArray *tempfahrenheit = [_fahrenheitarray objectAtIndex:0];
//                    
                    
                    NSArray *tempPrecip = [_precipArray objectAtIndex:0];
                    
                    NSArray *tempcondition = [_tempimageViewNameArray objectAtIndex:0];
                    
                    NSArray *tempHigh = [_tempHighArray objectAtIndex:0];
                    
                    NSArray *tempLow = [_tempLowArray objectAtIndex:0];
                    
                    
                    NSArray *date = [_dateArray objectAtIndex:0];
                    NSArray *date2 = [_dateArray2 objectAtIndex:0];
                    NSArray *date3 = [_dateArray3 objectAtIndex:0];
                    self.dateLabel.text = [NSString stringWithFormat:@"%@|%@|%@", date, date2, date3];
                    
                    //   NSArray *feels = [_feelsArray objectAtIndex:0];
                    
                    NSData *imagedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _tempImageViewArray2]]];
                  
//                    
                    
                    NSData *pressureImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_pressureImageViewArray objectAtIndex:1]]];
                    
                    
                    NSData *feels = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_feelsImageViewArray objectAtIndex:4]]];
                    
                    NSData *humidity = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_humidityImageViewArray objectAtIndex:7]]];
                    
                    
 //                  NSData *wind = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_windImageViewArray objectAtIndex:5]]];
//                    self.windImageView.image = [UIImage imageNamed:@"images (1).png"];
//                    
                  
                    NSData *gust = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_gustImageViewArray objectAtIndex:7]]];
                    
                    
                    NSData *precip = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_precipImageViewArray objectAtIndex:5]]];
                    
                    
                    NSData *tempLowimage = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_tempLowImageViewArray objectAtIndex:0]]];
                    
                    NSData *tempHighimage = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_tempHighImageViewArray objectAtIndex:1]]];
                    
                    NSData *timeimage = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_timeimageArray objectAtIndex:3]]];
                    
                    NSData *timeimage2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_timeimageArray2 objectAtIndex:6]]];
                    
                    
                    
                    NSArray *time = [_timeArray objectAtIndex:0];
                    NSArray *min = [_timeArray2 objectAtIndex:0];
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.humidityLabel.text = [NSString stringWithFormat:@"%d%%", tempHumidity];
                        self.windLabel.text = [NSString stringWithFormat:@"%d, %d", tempWind, tempWind2];
                        
                        self.fahrenheitLabel.text = [NSString stringWithFormat:@"+%d° Fahrenheit", tempfahrenheit];
                        
                        self.tempLabel.text = [NSString stringWithFormat:@"+%d°C", tempCelsius];
                        
                        self.precipLabel.text = [NSString stringWithFormat:@"%@%%", tempPrecip];
                        
                        self.tempimageViewNameLabel.text = [NSString stringWithFormat:@"%@", tempcondition];
                        
                        self.feelsLabel.text = [NSString stringWithFormat:@"%@°C", _feelsArray];
                        
                        self.pressureLabel.text = [NSString stringWithFormat:@"%@", _pressureArray];
                        
                        self.gustLabel.text = [NSString stringWithFormat:@"%@", _gustArray];
                        
                        self.pressureImageView.image = [UIImage imageWithData:pressureImage];
                        
                        self.feelsImageView.image = [UIImage imageWithData:feels];
                        
                        self.humidityImageView.image = [UIImage imageWithData:humidity];
                      
//                        self.windImageView.image = [UIImage imageWithData:wind];
//                      
                        self.tempHighLabel.text = [NSString stringWithFormat:@"%@°C", tempHigh];
                        self.tempLowLabel.text = [NSString stringWithFormat:@"%@°C", tempLow];
                        
                       self.tempimageView.image = [UIImage imageWithData:imagedata];
                        
                        self.gustImageView.image = [UIImage imageWithData:gust];
                        
                        
                        self.precipImageView.image = [UIImage imageWithData:precip];
                        
                        self.tempLowImageView.image = [UIImage imageWithData:tempLowimage];
                        
                        self.tempHighImageView.image = [UIImage imageWithData:tempHighimage];
                        
                        self.timeImageView.image = [UIImage imageWithData:timeimage];
                        
                        self.timeImageView2.image = [UIImage imageWithData:timeimage2];
                        
                        
                        self.timeLabel.text = [NSString stringWithFormat:@"%@:%@", time, min];
                    });
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Loading" message:@"data is nil" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            self.navigationItem.title = [NSString stringWithFormat:@"%@, %@", _cityArray, _countryArray];
                            
                        }];
                        [alert addAction:ok];
                        [self presentViewController:alert animated:YES completion:nil];
                    });
                }
            });
            
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Loading" message:@"data is nil" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
        
    }];
    
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)PreviousButton:(id)sender {
    
    if (_dataArray.count == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Wrong Input " message:@"data is nill" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
    
    if (self.index == 0) {
        _index = _dataArray.count;
    }
    _index--;
    
    NSArray *tempHumidity = [_humidityArray objectAtIndex:_index];
    self.humidityLabel.text = [NSString stringWithFormat:@"%@%%", tempHumidity];
    
    NSArray *tempWind = [_windArray objectAtIndex:_index];
    NSArray *tempWind2 = [_windArray2 objectAtIndex:_index];
    self.windLabel.text = [NSString stringWithFormat:@"%@, %@", tempWind, tempWind2];
    
    NSData *tempLowimage = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_tempLowImageViewArray objectAtIndex:_index]]];
    self.tempLowImageView.image = [UIImage imageWithData:tempLowimage];
    
    
    NSArray *tempfahrenheit = [_fahrenheitarray objectAtIndex:_index];
    self.fahrenheitLabel.text = [NSString stringWithFormat:@"+%@° Fahrenheit", tempfahrenheit];
    
    

    
    
    NSArray *tempCelsius = [_tempArray objectAtIndex:_index];
    self.tempLabel.text = [NSString stringWithFormat:@"+%@°C", tempCelsius];
    
    NSArray *tempPrecip = [_precipArray objectAtIndex:_index];
    self.precipLabel.text = [NSString stringWithFormat:@"%@%%", tempPrecip];
    
    NSArray *tempcondition = [_tempimageViewNameArray objectAtIndex:_index];
    self.tempimageViewNameLabel.text = [NSString stringWithFormat:@"%@", tempcondition];
    
    NSArray *tempHigh = [_tempHighArray objectAtIndex:_index];
    self.tempHighLabel.text = [NSString stringWithFormat:@"%@°C", tempHigh];
    NSArray *tempLow = [_tempLowArray objectAtIndex:_index];
    self.tempLowLabel.text = [NSString stringWithFormat:@"%@°C", tempLow];
    
    
    NSArray *date = [_dateArray objectAtIndex:_index];
    NSArray *date2 = [_dateArray2 objectAtIndex:_index];
    NSArray *date3 = [_dateArray3 objectAtIndex:_index];
    self.dateLabel.text = [NSString stringWithFormat:@"%@|%@|%@", date, date2, date3];
    
    
    NSData *feels = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_feelsImageViewArray objectAtIndex:_index]]];
    self.feelsImageView.image = [UIImage imageWithData:feels];
    
    NSData *humidity = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_humidityImageViewArray objectAtIndex:_index]]];
    self.humidityImageView.image = [UIImage imageWithData:humidity];
    
    
//    NSData *wind = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_windImageViewArray objectAtIndex:_index]]];
//   self.windImageView.image = [UIImage imageWithData:wind];
//    
    
    NSData *gust = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_gustImageViewArray objectAtIndex:_index]]];
    self.gustImageView.image = [UIImage imageWithData:gust];
    
    
    
    NSData *precip = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_precipImageViewArray objectAtIndex:_index]]];
    self.precipImageView.image = [UIImage imageWithData:precip];
    
    
    
    
    NSData *tempHighimage = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_tempHighImageViewArray objectAtIndex:_index]]];
    self.tempHighImageView.image = [UIImage imageWithData:tempHighimage];
    
    NSData *timeimage = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_timeimageArray objectAtIndex:_index]]];
    self.timeImageView.image = [UIImage imageWithData:timeimage];
    
    NSData *timeimage2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_timeimageArray2 objectAtIndex:_index]]];
    self.timeImageView2.image = [UIImage imageWithData:timeimage2];
    
    
    NSData *imagedata2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_tempImageViewArray objectAtIndex:_index]]];
    self.tempimageView.image = [UIImage imageWithData:imagedata2];
    
    
    
    NSArray *time = [_timeArray objectAtIndex:_index];
    NSArray *min = [_timeArray2 objectAtIndex:_index];
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@", time, min];
    
    
    }
    
    
}

- (IBAction)NextButton:(id)sender {
    if (_dataArray == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Wrong Input " message:@"data is nill" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
    
    if (self.index == ([self.dataArray count])) {
        _index = 0;
    }
    
    NSArray *tempHumidity = [_humidityArray objectAtIndex:_index];
    self.humidityLabel.text = [NSString stringWithFormat:@"%@%%", tempHumidity];
    
    NSArray *tempWind = [_windArray objectAtIndex:_index];
    NSArray *tempWind2 = [_windArray2 objectAtIndex:_index];
    self.windLabel.text = [NSString stringWithFormat:@"%@, %@", tempWind, tempWind2];
    
    NSArray *tempfahrenheit = [_fahrenheitarray objectAtIndex:_index];
    self.fahrenheitLabel.text = [NSString stringWithFormat:@"+%@° Fahrenheit", tempfahrenheit];
    
    
    NSArray *tempCelsius = [_tempArray objectAtIndex:_index];
    self.tempLabel.text = [NSString stringWithFormat:@"+%@°C", tempCelsius];
    
    NSArray *tempPrecip = [_precipArray objectAtIndex:_index];
    self.precipLabel.text = [NSString stringWithFormat:@"%@%%", tempPrecip];
    
    NSArray *tempcondition = [_tempimageViewNameArray objectAtIndex:_index];
    self.tempimageViewNameLabel.text = [NSString stringWithFormat:@"%@", tempcondition];
    
    NSArray *tempHigh = [_tempHighArray objectAtIndex:_index];
    self.tempHighLabel.text = [NSString stringWithFormat:@"%@°C", tempHigh];
    NSArray *tempLow = [_tempLowArray objectAtIndex:_index];
    self.tempLowLabel.text = [NSString stringWithFormat:@"%@°C", tempLow];
    
    
    NSArray *date = [_dateArray objectAtIndex:_index];
    NSArray *date2 = [_dateArray2 objectAtIndex:_index];
    NSArray *date3 = [_dateArray3 objectAtIndex:_index];
    self.dateLabel.text = [NSString stringWithFormat:@"%@|%@|%@", date, date2, date3];
    
    
    NSData *feels = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_feelsImageViewArray objectAtIndex:_index]]];
    self.feelsImageView.image = [UIImage imageWithData:feels];
    
    NSData *humidity = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_humidityImageViewArray objectAtIndex:_index]]];
    self.humidityImageView.image = [UIImage imageWithData:humidity];
    
    
//    NSData *wind = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_windImageViewArray objectAtIndex:_index]]];
//    self.windImageView.image = [UIImage imageWithData:wind];
//    
//    
    NSData *gust = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_gustImageViewArray objectAtIndex:_index]]];
    self.gustImageView.image = [UIImage imageWithData:gust];
    
    
    
    NSData *precip = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_precipImageViewArray objectAtIndex:_index]]];
    self.precipImageView.image = [UIImage imageWithData:precip];
    
    
    NSData *tempLowimage = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_tempLowImageViewArray objectAtIndex:_index]]];
    self.tempLowImageView.image = [UIImage imageWithData:tempLowimage];
    
    NSData *tempHighimage = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_tempHighImageViewArray objectAtIndex:_index]]];
    self.tempHighImageView.image = [UIImage imageWithData:tempHighimage];
    
    NSData *timeimage = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_timeimageArray objectAtIndex:_index]]];
    self.timeImageView.image = [UIImage imageWithData:timeimage];
    
    NSData *timeimage2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_timeimageArray2 objectAtIndex:_index]]];
    self.timeImageView2.image = [UIImage imageWithData:timeimage2];
    
     NSData *imagedata2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_tempImageViewArray objectAtIndex:_index]]];
    self.tempimageView.image = [UIImage imageWithData:imagedata2];
    
    
    NSArray *time = [_timeArray objectAtIndex:_index];
    NSArray *min = [_timeArray2 objectAtIndex:_index];
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@", time, min];
    
    
    _index++;
    }
    
}
- (IBAction)NextCity:(id)sender {
    if (_addCities.count == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Wrong Input " message:@"data is nill" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        
   
    
    if (self.index == ([self.addCities count])) {
       
        _index = 0;
       
    }
    //self.title = [NSString stringWithFormat:@"%@", [_addCities objectAtIndex:_index]];
    NSString *url = @"http://api.wunderground.com/api/b1da5535bc975303/geolookup/conditions/forecast/q/%@.json";
    NSString *urlString = [url stringByReplacingOccurrencesOfString:@"%@" withString:[_addCities objectAtIndex:_index]];
    NSString *url2 = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self getsession:url2];
    NSLog(@"url2 data %@", url2);
    
    _index++;
    }
    
}
- (IBAction)PreviousCity:(id)sender {
    
    if (_addCities.count == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Wrong Input " message:@"data is nill" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        
    
    
    if (self.index == 0) {
        _index = _addCities.count;
        
           }
    _index--;
    NSString *url = @"http://api.wunderground.com/api/b1da5535bc975303/geolookup/conditions/forecast/q/%@.json";
    NSString *urlString = [url stringByReplacingOccurrencesOfString:@"%@" withString:[_addCities objectAtIndex:_index]];
    NSString *url2 = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self getsession:url2];
    NSLog(@"url2 data %@", url2);
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SearchVCID"]) {
        SearchViewController* searchVC = [segue destinationViewController];
        searchVC.delegate = self;
    }
}

- (void)searchedText:(NSString *)text {
    self.title = text;
    
    NSString *url = @"http://api.wunderground.com/api/b1da5535bc975303/geolookup/conditions/forecast/q/%@.json";
    NSString *urlString = [url stringByReplacingOccurrencesOfString:@"%@" withString:text];
    NSString *url2 = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self getsession:url2];

    [self.addCities addObject:_cityArray];
    [self.addCities insertObject:text atIndex:1];
    NSLog(@"Addcities data :%@", _addCities);

   
}


-(void)stopAnimating {
    
}


@end
