//
//  Stacks.m
//  LinkedList
//
//  Created by Keynes Paul on 6/11/16.
//  Copyright © 2016 com.codeinobjc. All rights reserved.
//

#import "Stacks.h"
#import "LinkedList.h"
@interface Stacks()
@property(nonatomic,retain) LinkedList *linkedList;
@end

@implementation Stacks

-(LinkedList*)linkedList
{
    if (!_linkedList) {
        _linkedList = [LinkedList new];
    }
    return _linkedList;
}

-(id)init
{
    if (self == [super init]) {
    }
    return self;
}
-(void)pushWithData:(NSInteger)data
{
    [self.linkedList insertNodeAtHeadWithData:10 success:^(Node *node, BOOL result) {
        if (result) {
            NSLog(@"Node with data:%d added",node->data);
        }
    } failure:^(NSError *error) {
       
    }];
}

-(void)popData
{

    [self.linkedList deleteNodeAtHeadWithSuccess:^(Node *node, BOOL result) {
        if (result) {
            NSLog(@"Node with data:%d deleted",node->data);
        }
    } failure:^(NSError *error) {
        NSLog(@"Error:%@",[error valueForKey:@"error"]);
    }];
}
@end
