//
//  LinkedList.m
//  LinkedList
//
//  Created by Keynes Paul on 6/11/16.
//  Copyright © 2016 com.codeinobjc. All rights reserved.
//

#import "LinkedList.h"

@interface LinkedList()
@property(nonatomic,assign) Node *headNode,*tailNode;
-(Node*)createNewNodeWithData:(NSInteger)data;

@end

@implementation LinkedList

-(id)init
{
    if (self == [super init]) {
        //        self.headNode = self.tailNode;
    }
    return self;
}
#pragma mark -- create
-(Node*)createNewNodeWithData:(NSInteger)data
{
    Node *newNodeToInsert = (Node*)malloc(sizeof(Node));
    newNodeToInsert->data = (int)data;
    newNodeToInsert->nextNode = NULL;
    return newNodeToInsert;
}
#pragma mark -- Insert

-(void)insertNodeAtHeadWithData:(NSInteger)dataForNode success:(successBlock_t)success failure:(failureBlock_t)failure
{
    //    create a new node to insert
    Node *newNodeToInsert = [self createNewNodeWithData:dataForNode];
    if(self.headNode == NULL){
        self.tailNode = newNodeToInsert;
        //        self.headNode = newNodeToInsert;
    }
    newNodeToInsert->nextNode = self.headNode;
    self.headNode = newNodeToInsert;
    if (success) {
        success(self.headNode, YES);
    }
}

-(void)insertNodeAtTailWithData:(NSInteger)dataForNode success:(successBlock_t)success failure:(failureBlock_t)failure
{
    //    create a new node to insert
    Node *newNodeToInsert = [self createNewNodeWithData:dataForNode];
    if(!self.tailNode){
        self.tailNode = newNodeToInsert;
        self.headNode = newNodeToInsert;
    }
    self.tailNode->nextNode = newNodeToInsert;
    self.tailNode = newNodeToInsert;
    self.tailNode->nextNode= NULL;
    success(self.tailNode,YES);
}

-(void)insertNodeAfterTargetData:(NSInteger)targetData withData:(NSInteger)dataForNode success:(successBlock_t)success failure:(failureBlock_t)failure
{
    Node *newNodeToInsert = [self createNewNodeWithData:dataForNode];
    Node *temporaryNodeToHead = self.headNode;
    if(!temporaryNodeToHead)
    {
        [self insertNodeAtTailWithData:dataForNode success:success failure:failure];
        return;
    }
    while(temporaryNodeToHead->data != targetData && temporaryNodeToHead->nextNode != NULL) temporaryNodeToHead = temporaryNodeToHead->nextNode;
    if(temporaryNodeToHead->nextNode)
    {
        newNodeToInsert->nextNode = temporaryNodeToHead->nextNode;
        temporaryNodeToHead->nextNode = newNodeToInsert;
    }
    else
    {
        [self insertNodeAtTailWithData:dataForNode success:success failure:failure];
    }
}

#pragma mark -- print

-(void)printListAtHead
{
    [self printList:self.headNode];
}

-(void)printListAtTail
{
    [self printList:self.tailNode];
}

-(void)printList:(Node*)node;
{
    //    print data in increasing order from head node
    Node *traverser = node;
    if(!traverser) return;
    NSLog(@"%d",(*traverser).data);
    [self printList:(*traverser).nextNode];
}

-(void)reversePrintList
{
    [self reversePrintList:self.headNode];
}
-(void)reversePrintList:(Node*)node
{
    Node *traverser = node;
    if(!traverser) return;
    [self reversePrintList:(*traverser).nextNode];
    NSLog(@"%d",(*traverser).data);
}


#pragma mark -- delete

-(void)deleteNodeAtHeadWithSuccess:(successBlock_t)success failure:(failureBlock_t)failure
{
    if(!self.headNode)failure([NSError errorWithDomain:NSCocoaErrorDomain code:NSExecutableLoadError userInfo:@{@"error":@"Empty list"}]);
    Node *temporaryNodeToHead = self.headNode;
    self.headNode = self.headNode->nextNode;
    success(temporaryNodeToHead,YES);
    free(temporaryNodeToHead);
}

-(void)deleteNodeAtTailWithSuccess:(successBlock_t)success failure:(failureBlock_t)failure
{
    if(!self.tailNode)failure([NSError errorWithDomain:NSCocoaErrorDomain code:NSExecutableLoadError userInfo:@{@"error":@"Empty list"}]);
    Node *temporaryNodeToHead = self.headNode;
    while(temporaryNodeToHead->nextNode->nextNode) temporaryNodeToHead = temporaryNodeToHead->nextNode;
    self.tailNode = temporaryNodeToHead;
    self.tailNode->nextNode = NULL;
    free(temporaryNodeToHead->nextNode);
    success(temporaryNodeToHead,YES);
}

-(void)deleteNodeWithTargetData:(NSInteger)targetData success:(successBlock_t)success failure:(failureBlock_t)failure
{
    Node *temporaryNodeToHead = self.headNode;
    if(!temporaryNodeToHead)
    {
        failure([NSError errorWithDomain:NSCocoaErrorDomain code:NSExecutableLoadError userInfo:@{@"error":@"Empty list"}]);
        return;
    }
    while(temporaryNodeToHead->nextNode->nextNode  && temporaryNodeToHead->nextNode->data != targetData) temporaryNodeToHead = temporaryNodeToHead->nextNode;
    if(temporaryNodeToHead->nextNode && temporaryNodeToHead->nextNode->data == targetData)
    {
        Node *nodeToDelete = temporaryNodeToHead->nextNode;
        temporaryNodeToHead->nextNode = temporaryNodeToHead->nextNode->nextNode;
        success(nodeToDelete,YES);
        free(nodeToDelete);
    }
    else
    {
        failure([NSError errorWithDomain:NSCocoaErrorDomain code:NSExecutableLoadError userInfo:@{@"error":@"Node not found"}]);
        return;
    }
}

@end