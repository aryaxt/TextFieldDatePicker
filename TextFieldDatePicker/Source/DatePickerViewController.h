//
//  DatePickerViewController.h
//  TextFieldDatePicker
//
//  Created by Aryan Gh on 6/18/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CKCalendarView.h"

@protocol DatePickerViewControllerDelegate <NSObject>
@optional
- (void)datePickerViewControllerDidSelectDate:(NSDate *)date;
@end

@interface DatePickerViewController : UIViewController <CKCalendarDelegate>

@property (nonatomic, weak) id <DatePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDate *date;

@end
