//
//  DatePickerViewController.m
//  TextFieldDatePicker
//
//  Created by Aryan Gh on 6/18/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()
@property (nonatomic, strong) CKCalendarView *calendarView;
@end

@implementation DatePickerViewController

#pragma mark - UIViewController MEthods -

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.contentSizeForViewInPopover = CGSizeMake(self.calendarView.frame.size.width, self.calendarView.frame.size.height);
	[self.view addSubview:self.calendarView];
	
	if (self.minDate)
		self.calendarView.minimumDate = self.minDate;
	
	if (self.maxDate)
		self.calendarView.maximumDate = self.maxDate;
	
	if (self.date)
		self.calendarView.selectedDate = self.date;
}

- (CKCalendarView *)calendarView
{
	if (!_calendarView)
	{
		_calendarView = [[CKCalendarView alloc] initWithStartDay:startMonday];
		_calendarView.layer.cornerRadius = 0;
		_calendarView.delegate = self;
	}
	
	return _calendarView;
}

#pragma mark - CKCalendarViewDelegate Methods -

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
	[self.delegate datePickerViewControllerDidSelectDate:date];
}

@end
