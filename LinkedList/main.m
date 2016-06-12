//
//  main.m
//  LinkedList
//
//  Created by Keynes Paul on 5/27/16.
//  Copyright © 2016 com.codeinobjc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Stacks.h"


int main(int argc, char** argv)
{
    @autoreleasepool {
        Stacks *stack = [Stacks new];
        [stack pushWithData:10];
        [stack popData];
    }
    return 0;
}