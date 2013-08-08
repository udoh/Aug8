//
//  Author+Create.h
//  Aug1
//
//  Created by Udo Hoppenworth on 8/5/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import "Author.h"

@interface Author (Create)

+ (Author *)authorWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;

@end
