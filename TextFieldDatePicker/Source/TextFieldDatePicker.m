//
//  TextFieldDatePicker.m
//  TextFieldDatePicker
//
//  Created by Aryan Gh on 6/18/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "TextFieldDatePicker.h"

@interface TextFieldDatePicker()
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) DatePickerViewController *datePickerViewController;
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
	UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
	inputView.backgroundColor = [UIColor clearColor];
	self.inputView = inputView;
	
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
	
	[self.popoverController presentPopoverFromRect:self.frame
											inView:self.superview
						  permittedArrowDirections:UIPopoverArrowDirectionAny
										  animated:YES];
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
	if (!_popoverController)
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

@end
