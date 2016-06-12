//
//  LinkedList.h
//  LinkedList
//
//  Created by Keynes Paul on 6/11/16.
//  Copyright © 2016 com.codeinobjc. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LinkedList <NSObject>
typedef struct Node Node;
struct Node{
    int data;
    Node *nextNode;
};
typedef void(^successBlock_t)(Node* node,BOOL result);
typedef void(^failureBlock_t)(NSError *error);
@required
-(void)insertNodeAtHeadWithData:(NSInteger)dataForNode success:(successBlock_t)success failure:(failureBlock_t)failure;
-(void)insertNodeAtTailWithData:(NSInteger)dataForNode success:(successBlock_t)success failure:(failureBlock_t)failure;
-(void)insertNodeAfterTargetData:(NSInteger)targetData withData:(NSInteger)dataForNode success:(successBlock_t)success failure:(failureBlock_t)failure;
-(void)deleteNodeAtHeadWithSuccess:(successBlock_t)success failure:(failureBlock_t)failure;
-(void)deleteNodeAtTailWithSuccess:(successBlock_t)success failure:(failureBlock_t)failure;
-(void)deleteNodeWithTargetData:(NSInteger)targetData success:(successBlock_t)success failure:(failureBlock_t)failure;
-(void)printListAtHead;
-(void)printListAtTail;
-(void)reversePrintList;
@end
@interface LinkedList : NSObject<LinkedList>
-(id)init;
@end
