//
//  ViewController.h
//  Weather App
//
//  Created by chaitanya on 13/10/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSDictionary *jsonAPI;
@property (strong, nonatomic) NSMutableArray *addCities;
@property (strong, nonatomic) NSSet *uniquePlaces;

- (IBAction)PreviousButton:(id)sender;

- (IBAction)NextButton:(id)sender;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *countryArray;

@property (strong, nonatomic) IBOutlet UIImageView *timeImageView;
@property (strong, nonatomic) NSMutableArray *timeimageArray;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSMutableArray *timeArray;
@property (strong, nonatomic) NSMutableArray *timeArray2;

@property (strong, nonatomic) IBOutlet UIImageView *timeImageView2;
@property (strong, nonatomic) NSMutableArray *timeimageArray2;


@property (strong, nonatomic) IBOutlet UILabel *timeLabel2;
@property (strong, nonatomic) NSMutableArray *timeArray3;


@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSMutableArray *dateArray;
@property (strong, nonatomic) NSMutableArray *dateArray2;
@property (strong, nonatomic) NSMutableArray *dateArray3;




@property (strong, nonatomic) NSDictionary *dataArray;
@property (strong, nonatomic) NSDictionary *dataArray2;
@property (strong, nonatomic) NSDictionary *dataArray3;
@property (strong, nonatomic) NSDictionary *dataArray4;




@property (strong, nonatomic) IBOutlet UIImageView *tempimageView;
@property (strong, nonatomic) NSMutableArray *tempImageViewArray;
@property (strong, nonatomic) NSMutableArray *tempImageViewArray2;



@property (strong, nonatomic) IBOutlet UILabel *tempimageViewNameLabel;
@property (strong, nonatomic) NSMutableArray *tempimageViewNameArray;
@property (strong, nonatomic) NSMutableArray *tempimageViewNameArray2;



@property (strong, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic) NSMutableArray *tempArray;


@property (strong, nonatomic) IBOutlet UILabel *fahrenheitLabel;
@property (strong, nonatomic) NSMutableArray *fahrenheitarray;
@property (strong, nonatomic) NSMutableArray *fahrenheitarray2;


@property (strong, nonatomic) IBOutlet UIImageView *feelsImageView;
@property (strong, nonatomic) NSMutableArray *feelsImageViewArray;


@property (strong, nonatomic) IBOutlet UILabel *feelsLabel;
@property (strong, nonatomic) NSMutableArray *feelsArray;

@property (strong, nonatomic) IBOutlet UILabel *windLabel;
@property (strong, nonatomic) NSMutableArray *windArray;
@property (strong, nonatomic) NSMutableArray *windArray2;
@property (strong, nonatomic) NSMutableArray *windArray3;
@property (strong, nonatomic) NSMutableArray *windArray4;



//@property (strong, nonatomic) IBOutlet UIImageView *windImageView;
//@property (strong, nonatomic) NSMutableArray *windImageViewArray;
//



@property (strong, nonatomic) IBOutlet UILabel *humidityLabel;
@property (strong, nonatomic) NSMutableArray *humidityArray;


@property (strong, nonatomic) IBOutlet UIImageView *humidityImageView;
@property (strong, nonatomic) NSMutableArray *humidityImageViewArray;


@property (strong, nonatomic) IBOutlet UIImageView *pressureImageView;
@property (strong, nonatomic) NSMutableArray *pressureImageViewArray;

@property (strong, nonatomic) IBOutlet UILabel *pressureLabel;
@property (strong, nonatomic) NSMutableArray *pressureArray;

@property (strong, nonatomic) IBOutlet UIImageView *gustImageView;
@property (strong, nonatomic) NSMutableArray *gustImageViewArray;


@property (strong, nonatomic) IBOutlet UILabel *gustLabel;
@property (strong, nonatomic) NSMutableArray *gustArray;

@property (strong, nonatomic) IBOutlet UIImageView *precipImageView;
@property (strong, nonatomic) NSMutableArray *precipImageViewArray;

@property (strong, nonatomic) IBOutlet UILabel *precipLabel;
@property (strong, nonatomic) NSMutableArray *precipArray;
@property (strong, nonatomic) NSMutableArray *precipArray2;
@property (strong, nonatomic) NSMutableArray *precipArray3;



@property (strong, nonatomic) IBOutlet UIImageView *tempLowImageView;
@property (strong, nonatomic) NSMutableArray *tempLowImageViewArray;


@property (strong, nonatomic) IBOutlet UILabel *tempLowLabel;
@property (strong, nonatomic) NSMutableArray *tempLowArray;

@property (strong, nonatomic) IBOutlet UIImageView *tempHighImageView;
@property (strong, nonatomic) NSMutableArray *tempHighImageViewArray;


@property (strong, nonatomic) IBOutlet UILabel *tempHighLabel;
@property (strong, nonatomic) NSMutableArray *tempHighArray;



@end

