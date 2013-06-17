//
//  ViewController.m
//  Address
//
//  Created by 饺子 on 13-6-17.
//  Copyright (c) 2013年 *. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
    [addressBtn autorelease];
    
    [addressBtn setTitle:@"通讯录" forState:UIControlStateNormal];
  
    [addressBtn  addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addressBtn];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)btnClick
{
    ABPeoplePickerNavigationController *peoleVC = [[ABPeoplePickerNavigationController alloc] init];
    peoleVC.peoplePickerDelegate = self;
    [self presentModalViewController:peoleVC animated:YES];
    //特别注意，这里要使用膜态弹出。
    [peoleVC release];
}


- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    NSLog(@"peoplePickerNavigationControllerDidCancel");
    
    [self dismissModalViewControllerAnimated:YES];
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    //取联系人姓名
    NSString *name = (NSString *)ABRecordCopyCompositeName(person);
    NSLog(@"=======>%@",name);
    
    //判断点击的区域
    if (property == kABPersonPhoneProperty)
    {
        //取出当前点击的区域中所有的内容
        ABMutableMultiValueRef phoneMulti =  ABRecordCopyValue(person,kABPersonPhoneProperty);
        //根据点击的那一行对应的identifier取出所在的索引
        int index =  ABMultiValueGetIndexForIdentifier(phoneMulti, identifier);
        //根据索引把相应的值取出
        NSString *phone =  (NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        
        NSLog(@"%@",phone);
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
