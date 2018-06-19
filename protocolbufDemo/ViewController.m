//
//  ViewController.m
//  protocolbufDemo
//
//  Created by wupeng on 2018/6/19.
//  Copyright © 2018年 wupeng. All rights reserved.
//

#import "ViewController.h"
#import "Person.pbobjc.h"  //模型

@interface ViewController ()
@property (nonatomic, strong) NSData *myData; //数据

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startSerialize:(id)sender {
    // 创建对象
    Person *per = [[Person alloc] init];
    per.name = @"小明";
    per.age = 18;
    per.deviceType = Person_DeviceType_Ios;
    
    //对象数组属性：Person_Result
    Person_Result *result1 = [[Person_Result alloc] init];
    result1.title = @"简书";
    result1.URL = @"https://www.jianshu.com";
    
    Person_Result *result2 = [[Person_Result alloc] init];
    result2.title = @"博客园";
    result2.URL = @"http://cnblogs.com";
    
    [per.resultsArray addObjectsFromArray:@[result1, result2]]; //将对象添加到数组中
    
    //对象数组属性：Ani
    Animal *an1 = [[Animal alloc] init];
    an1.weight = 40;
    an1.price = 1000;
    an1.namme = @"哈士奇";
    
    [per.animalsArray addObject:an1];
    
    //对象序列化：存储或传递
    NSData *data = [per delimitedData];
    self.myData = data;
    
    self.showView.text = @"数据序列化成功！";
}
- (IBAction)startDeserialize:(id)sender {
    //二进制数据反序列化为对象
    GPBCodedInputStream *inputStream = [GPBCodedInputStream streamWithData:self.myData];
    
    NSError *error;
    Person *per = [Person parseDelimitedFromCodedInputStream:inputStream extensionRegistry:nil error:&error];
    
    if (error){
        self.showView.text = @"解析数据失败！";
        return;
    }
    
    //展示数据
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:@"二进制数据反序列化为对象\n"];
    [str appendFormat:@"name: %@, age: %d \n", per.name, per.age];
    
    for (Person_Result *item in per.resultsArray) {
        [str appendFormat:@"result.title: %@, result.url: %@\n", item.title, item.URL];
    }
    
    for (Animal *item in per.animalsArray) {
        [str appendFormat:@"animal.name: %@, animal.price: %.2f, animal.weight: %.2f\n", item.namme, item.price, item.weight];
    }
    
    self.showView.text = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
