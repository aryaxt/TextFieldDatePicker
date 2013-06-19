//
//  TextFieldDatePicker.h
//  TextFieldDatePicker
//
//  Created by Aryan Gh on 6/18/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"

@class TextFieldDatePicker;
@protocol TextFieldDatePickerDelegate <UITextFieldDelegate>
- (void)textFieldDatePicker:(TextFieldDatePicker *)textFieldDatePicker didSelectDate:(NSDate *)date;
@end

@interface TextFieldDatePicker : UITextField <UITextFieldDelegate, DatePickerViewControllerDelegate>

@property (nonatomic, weak) IBOutlet id <TextFieldDatePickerDelegate> datePickerDelegate;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end
