//
//  ViewController.m
//  Sqlite
//
//  Created by student14 on 01/12/16.
//  Copyright © 2016 Felix-Divesh. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)InsertDB:(id)sender {
    
    
    NSArray *dir= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath= [NSString stringWithFormat:@"%@/Mydb.sqlite",[dir lastObject]];
    sqlite3 *db;
    
    if(sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        const char *query="insert into employee values(12,'Sandesh','Vadgaon',12345)";
        if( sqlite3_exec(db, query, NULL, NULL, NULL)==SQLITE_OK)
        {
            NSLog(@" successfully inserted record");
        }
        else
        {
            NSLog(@"Fail to insert record");
        }
    }
    else
    {
        NSLog(@"fail to open database");
    }
    sqlite3_close(db);
    
}

- (IBAction)ReadDB:(id)sender {
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dbpath=[NSString stringWithFormat:@"%@/Mydb.sqlite",[dir lastObject]];
    
    sqlite3 *db;
    
    sqlite3_stmt *mystmt;
    
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        const char * query="select * from employee";
        
        if(sqlite3_prepare(db, query, -1, &mystmt, NULL)==SQLITE_OK)
        {
            while (sqlite3_step(mystmt)==SQLITE_ROW) {
                
                int t1 = sqlite3_column_int(mystmt,0);
                NSString *t2=[ NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt,1)];
                
                NSString *t3=[ NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt,2)];
                int t4 = sqlite3_column_int(mystmt,3);
                
                NSLog(@"%i   %@     %@     %i",t1,t2,t3,t4);
                
            }
            
            
        }
        else
        {
            NSLog(@"fail to execute query");
        }
        
    }
    
    sqlite3_close(db);
    
    
}
@end
