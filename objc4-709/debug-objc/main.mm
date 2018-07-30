//
//  main.m
//  debug-objc
//
//  Created by Jason on 03/05/2017.
//
//

#import <Foundation/Foundation.h>
// 1. 引入runtime库
#import "objc.h"
#import <objc/runtime.h>
#import <objc/message.h>

// 2. 声名一个 函数指针 用于保存 原方法入口地址
void (*origin_say) (id,SEL);

// 3. 定义一个 hook 实现
void hook_say(id receiver, SEL cmd) {
    NSLog(@"hook -- before");
    // 4 执行原方法实现
    if (origin_say) {
        origin_say(receiver, cmd);
    }
    NSLog(@"hook -- after");
}

void hookStart(){
    NSLog(@"开始 hook ");
    // 获取 person 类对象
    Class cls = objc_getClass("Person");
    Method orginMethod = class_getInstanceMethod(cls, NSSelectorFromString(@"say"));
    origin_say = (void (*) (id,SEL)) method_setImplementation(orginMethod, (IMP)hook_say);
    NSLog(@"结束 hook ");
}



//@interface Person: NSObject
//- (void)say;
//@end
//@implementation Person
//- (void)say{
//    NSLog(@"%s",__func__);
//}
//@end
//
//@implementation Person (Category)
//- (void)say{
//    NSLog(@"1111");
//}
//@end
//@implementation Person (Category1)
//- (void)say{
//    NSLog(@"11112222");
//}
//@end
//@implementation Person (Category2)
//- (void)say{
//    NSLog(@"11112222");
//}
//@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *a = @[@"one",@"two"];
//        void* indexedIvars = object_getIndexedIvars(a);
//        NSLog(@"%@", *(id *)(indexedIvars + 0));
//        NSLog(@"%@", *(id *)(indexedIvars + sizeof(NSArray*)));
//        NSLog(@"%@", *(id *)(indexedIvars + sizeof(NSArray*)*2));
        

    }
    return 0;
}
