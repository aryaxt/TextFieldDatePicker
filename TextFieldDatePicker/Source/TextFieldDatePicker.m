//
//  TextFieldDatePicker.m
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

#import "TextFieldDatePicker.h"

@interface TextFieldDatePicker()
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) DatePickerViewController *datePickerViewController;
@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation TextFieldDatePicker

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{
        [self initialize];
    }
	
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		[self initialize];
	}
	
	return self;
}

- (void)initialize
{
	self.datePickerMode = UIDatePickerModeDate;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
		inputView.backgroundColor = [UIColor clearColor];
		self.inputView = inputView;
	}
	else
	{
		[self.datePicker addTarget:self action:@selector(datePickerDidChange:) forControlEvents:UIControlEventValueChanged];
		self.inputView = self.datePicker;
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(textFieldDidBeginEditing:)
												 name:UITextFieldTextDidBeginEditingNotification
											   object:self];
	
	self.dateFormatter = [[NSDateFormatter alloc] init];
	[self.dateFormatter setDateFormat:@"MM/dd/yyyy"];
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	if ([self.popoverController isPopoverVisible])
	{
		[self.popoverController presentPopoverFromRect:self.frame
												inView:self.superview
							  permittedArrowDirections:UIPopoverArrowDirectionAny
											  animated:YES];
	}
}

#pragma mark - UITextField Notification -

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	self.datePickerViewController.minDate = self.minDate;
	self.datePickerViewController.maxDate = self.maxDate;
	self.datePickerViewController.date = self.date;
	self.datePicker.date = (self.date) ? self.date : [NSDate date];
	self.datePicker.minimumDate = self.minDate;
	self.datePicker.maximumDate = self.maxDate;
	
	[self.popoverController presentPopoverFromRect:self.frame
											inView:self.superview
						  permittedArrowDirections:UIPopoverArrowDirectionAny
										  animated:YES];
	
	// on iphone we want to automatically select the current selected day on date picker if date is not selected
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
	{
		self.date = self.datePicker.date;
	}
}

#pragma mark - UIDatePicker action -

- (void)datePickerDidChange:(id)sender
{
	self.date = self.datePicker.date;
}

#pragma mark - UIPopoverControllerDelegate Methods -

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	[self resignFirstResponder];
}

#pragma mark - DatePickerViewControllerDelegate Methods -

- (void)datePickerViewControllerDidSelectDate:(NSDate *)date
{
	self.date = date;
	
	[self.popoverController dismissPopoverAnimated:YES];
	[self resignFirstResponder];
	
	[self.delegate textFieldDatePicker:self didSelectDate:date];
}

#pragma mark - Private Methods -

- (void)updateText
{
	self.text = [self.dateFormatter stringFromDate:self.date];
}

#pragma mark - Setter & Getter -

- (void)setDate:(NSDate *)date
{
	_date = date;
	[self updateText];
}

- (UIPopoverController *)popoverController
{
	if (!_popoverController && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		_popoverController = [[UIPopoverController alloc] initWithContentViewController:self.datePickerViewController];
		_popoverController.delegate = self;
	}
	
	return _popoverController;
}

- (DatePickerViewController *)datePickerViewController
{
	if (!_datePickerViewController)
	{
		_datePickerViewController = [[DatePickerViewController alloc] init];
		_datePickerViewController.delegate = self;
	}
	
	return _datePickerViewController;
}

- (UIDatePicker *)datePicker
{
	if (!_datePicker)
	{
		_datePicker= [[UIDatePicker alloc] init];
		_datePicker.datePickerMode = self.datePickerMode;
	}
	
	return _datePicker;
}

@end
