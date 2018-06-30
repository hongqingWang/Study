//
//  KVOInterviewQuestionViewController.m
//  Study
//
//  Created by 王红庆 on 2018/6/30.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "KVOInterviewQuestionViewController.h"
#import "Person.h"

@interface KVOInterviewQuestionViewController ()

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, strong) Person *person1;

@end

@implementation KVOInterviewQuestionViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupText];
    
    self.person1 = [[Person alloc] init];
    self.person1.age = 1;
    
    [self.person1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)dealloc {
    [self.person1 removeObserver:self forKeyPath:@"age"];
}

#pragma mark - Event Response
/**
 * 手动触发KVO
 */
- (void)kvo {
    
    [self.person1 willChangeValueForKey:@"age"];
    [self.person1 didChangeValueForKey:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    // keyPath = age
    NSLog(@"keyPath = %@", keyPath);
    /*
     change = {
     kind = 1;
     new = 1;
     old = 1;
     }
     */
    NSLog(@"change = %@", change);
    // context = (null)
    NSLog(@"context = %@", context);
}


#pragma mark - setupText
- (void)setupText {
    
    NSString *string1 = @"1.KVO 的本质是什么？\n"
    "\n"
    "- 利用 RuntimeAPI 动态生成一个子类，并且让 instance 对象的 isa 指向这个全新的子类\n"
    "- 当修改 instance 对象的属性时，会调用 Foundation 的 _NSSetxxxValueAndNotify 函数\n"
    "   - willChangeValueForKey:\n"
    "   - [super setter]\n"
    "   - didChangeValueForKey:\n"
    "内部会触发监听器(Observer)的监听方法(observeValueForKeyPath: ofObject: change: context:)\n"
    "\n";
    
    NSString *string2 = @"2.如何手动触发 KVO？\n"
    "\n"
    "手动调用\n"
    "   - willChangeValueForKey\n"
    "   - didChangeValueForKey\n"
    "\n";
    
    self.textView.text = [string1 stringByAppendingString:string2];
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textView];
    textView.frame = CGRectMake(16, 64, [UIScreen mainScreen].bounds.size.width - 16, [UIScreen mainScreen].bounds.size.height - 164);
    self.textView = textView;
    
    UIButton *kvoButton = [[UIButton alloc] init];
    [kvoButton setTitle:@"手动触发 KVO" forState:UIControlStateNormal];
    [kvoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [kvoButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:kvoButton];
    kvoButton.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 64 - 50, [UIScreen mainScreen].bounds.size.width, 50);
    [kvoButton addTarget:self action:@selector(kvo) forControlEvents:UIControlEventTouchUpInside];
    
}

@end
