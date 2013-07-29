//
//  DatePickerViewController.m
//  TextFieldDatePicker
//
//  Created by Aryan Gh on 6/18/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//
// https://github.com/aryaxt/TextFieldDatePicker
//
// Permission to use, copy, modify and distribute this software and its documentation
// is hereby granted, provided that both the copyright notice and this permission
// notice appear in all copies of the software, derivative works or modified versions,
// and any portions thereof, and that both notices appear in supporting documentation,
// and that credit is given to Aryan Ghassemi in all documents and publicity
// pertaining to direct or indirect use of this code or its derivatives.
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
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
	if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerViewControllerDidSelectDate:)])
		[self.delegate datePickerViewControllerDidSelectDate:date];
}

@end
