//
//  SDLData.m
//  LoveAnime
//
//  Created by qianfeng_sdl on 16/7/25.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLData.h"
//#import "FMDatabase.h"
//#import "FMDatabaseQueue.h"

/*
@implementation SDLData
//异步数据库
static FMDatabaseQueue *_queue;

+ (void)initialize{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/DataBase.rdb",NSHomeDirectory()];
    NSLog(@"---------path:%@",path);
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [_queue inDatabase:^(FMDatabase *db) {
        //创建登录表
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Table_user(user_ID varchar(200) PRIMARY KEY , name varchar(50), icon varchar(200),  online INTEGER)"];
        //创建关注表
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Table_save(save_ID varchar(200) PRIMARY KEY , user_ID varchar(200) ,icon varchar(200), name varchar(100))"];
        
        //创建主页数据表(三个model)
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Table_hot(save_ID varchar(200) PRIMARY KEY ,icon varchar(200), name varchar(100))"];
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Table_cosplay(save_ID varchar(200) PRIMARY KEY ,icon varchar(200), name varchar(100))"];
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Table_day(save_ID varchar(200) PRIMARY KEY ,icon varchar(200), name varchar(100))"];
        
        //创建分类数据表
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Table_cartoon(save_ID varchar(200) PRIMARY KEY ,icon varchar(200), name varchar(100))"];
        
        //创建新闻数据表
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Table_finding(save_ID varchar(200) PRIMARY KEY ,icon varchar(200), name varchar(100),url varchar(100))"];
        
        
    }];
}
#pragma mark -对登陆者进行相关操作
//添加登陆者
+ (void)insertWithUser:(SSDKUser *)user{
    
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = nil;
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM Table_user WHERE user_ID = '%@';",user.uid];
        result = [db executeQuery:querySql];
        //新的的登陆者不存在数据库中
        if(result.next == NO){
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO Table_user(user_ID,name,icon,online) values(?,?,?,1)"];
            //NSLog(@"uid:%@-------name:%@------icon:%@",user.uid,user.nickname,user.icon);
            BOOL RE = [db executeUpdate:sql,user.uid,user.nickname,user.icon];
           // NSLog(@"%d",RE);
        }else{
            //数据库已有用户 直接上线
            NSString *sql = [NSString stringWithFormat:@"UPDATE Table_user SET online = 1 WHERE user_ID = ?"];
            [db executeUpdate:sql,user.uid];
        }
        [result close];
    }];
}
//查询登陆者
+ (BOOL)selectDataWithUser:(void (^)(SSDKUser *person))user{
//+ (BOOL)selectDataWithUser:(SSDKUser *)user
    __block BOOL userResult;
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *selectSql = @"SELECT * FROM Table_user WHERE online = 1";
        FMResultSet *ser = [db executeQuery:selectSql];
        if(ser.next){
            userResult = YES;
            SSDKUser *user1 = [[SSDKUser alloc]init];
            user1.uid = [ser stringForColumn:@"user_ID"];
            user1.nickname = [ser stringForColumn:@"name"];
            user1.icon = [ser stringForColumn:@"icon"];
            user(user1);
            
        }else{
            userResult = NO;
        }
       
        
        [ser close];
    }];
    return userResult;
}
//离线
+ (void)offlineWithUser:(SSDKUser *)user{
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"UPDATE Table_user SET online = 0 WHERE user_ID = ?";
        //NSLog(@"%@",sql);
        BOOL ret = [db executeUpdate:sql,user.uid ];
        //NSLog(@"%d",ret);
        
    }];
}
//上线
+ (void)onlineWithUser:(SSDKUser *)user{
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *qle = @"UPDATE Table_user SET online = 1 WHERE user_ID =?";
        [db executeUpdate:qle,user.uid];
    }];
}
#pragma mark -收藏功能
//向数据库里添加关注参数
+ (void)insertWithSave:(AnimeMessageModel *)model andUser_ID:(NSString *)user_ID{
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = [NSString stringWithFormat:@"SELECT * FROM Table_save WHERE save_ID = %@",model.video_id];
        FMResultSet *set = [db executeQuery:str];
        if(set.next == NO){
            NSString *sqlStr = @"INSERT INTO Table_save(save_ID,user_ID,icon,name) values(?,?,?,?)";
            [db executeUpdate:sqlStr,model.video_id,user_ID,model.cover,model.name];
            //NSLog(@"ret = %d",ret);
        }
        [set close];
        
    }];
}
//查询是否已经关注
+(BOOL)selectDataWithSave:(NSString *)video_id andUser:(NSString *)user_id{
    __block BOOL userResult;
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = [NSString stringWithFormat:@"SELECT * FROM Table_save WHERE save_ID = ? AND user_ID = ?"];
        //NSLog(@"-----%@",str);
        //SELECT * FROM Table_save WHERE save_ID = 32491 AND user_ID = 6577C808541C0436D282B38B5703B11F
        //  6577C808541C0436D282B38B5703B11F
        FMResultSet *set = [db executeQuery:str,video_id,user_id];
        if(set.next){
            userResult = YES;
        }else{
            userResult = NO;
        }
        [set close];
        
    }];
    return userResult;

}
//查询数据库中的关注信息
+ (NSArray *)selectDataWithSaveUser_ID:(NSString *)user_ID{
    
     NSMutableArray *dataArrM = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
       
        //多表联合查询
        //NSString *selectStr = @"SELETE save_ID, icon, name FROM Table_save INNER JOIN Table_user ON Table_save.user_ID = Table_user.user_ID WHERE Table_user.user_ID = ? ";
        NSString *str = @"SELECT * FROM Table_save WHERE user_ID = ?";
        FMResultSet *set = [db executeQuery:str,user_ID];
        while ([set next]) {
            AnimeMessageModel *model = [[AnimeMessageModel alloc]initWithResultSet:set];
            [dataArrM addObject:model];
            
        }
        
        
    }];
    return dataArrM;
}
//删除关注信息
+ (void)deleteWithSave:(AnimeMessageModel *)model{
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *deleteStr = @"DELETE FROM Table_save WHERE save_ID  = ?";
        [db executeUpdate:deleteStr,model.video_id ];
    }];
}


#pragma mark -主页数据的相关操作
+ (void)insertWithHot:(HotModel *)model{
    
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = [NSString stringWithFormat:@"SELECT * FROM Table_hot WHERE save_ID = %@",model.id1];
        FMResultSet *set = [db executeQuery:str];
        if(set.next == NO){
            NSString *str =@"INSERT INTO Table_hot(save_ID,name,icon) values(?,?,?)";
            [db executeUpdate:str,model.id1,model.name,model.pic];
        }
        [set close];
    }];
}
+ (void)insertWithDay:(DayModel *)model{
    
    
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = [NSString stringWithFormat:@"SELECT * FROM Table_day WHERE save_ID = %@",model.id1];
        FMResultSet *set = [db executeQuery:str];
        if(set.next == NO){
            NSString *str =@"INSERT INTO Table_day(save_ID,name,icon) values(?,?,?)";
            [db executeUpdate:str,model.id1,model.name,model.pic];
        }
        [set close];
    }];
}
+ (void)insertWithCosplay:(CosPlayModel *)model{
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        NSString *str = [NSString stringWithFormat:@"SELECT * FROM Table_cosplay WHERE save_ID = %@",model.Id];
        FMResultSet *set = [db executeQuery:str];
        if(set.next == NO){
            NSString *str =@"INSERT INTO Table_cosplay(save_ID,name,icon) values(?,?,?)";
            [db executeUpdate:str,model.Id,model.Title,model.DefaultImage];
        }
        [set close];
    }];
}
//查找动漫信息
+ (NSArray *)selectDataWithHot{
    
    NSMutableArray *arrM = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = @"SELECT * FROM Table_hot";
        FMResultSet *set = [db executeQuery:str];
        while ([set next]) {
            HotModel *hot = [[HotModel alloc]initWithResult:set];
            [arrM addObject:hot];
        }
        [set close];
    }];
    return arrM;
    
}
+ (NSArray *)selectDataWithDay{
    
    NSMutableArray *arrM = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = @"SELECT * FROM Table_day";
        FMResultSet *set = [db executeQuery:str];
        while ([set next]) {
            DayModel *hot = [[DayModel alloc]initWithResult:set];
            [arrM addObject:hot];
        }
        [set close];
    }];
    return arrM;
}
+ (NSArray *)selectDataWithCosplay{
    NSMutableArray *arrM = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = @"SELECT * FROM Table_day";
        FMResultSet *set = [db executeQuery:str];
        while ([set next]) {
            CosPlayModel *hot = [[CosPlayModel alloc]initWithSet:set];
            [arrM addObject:hot];
        }
        [set close];
        
    }];
    return arrM;
}
#pragma mark -分类页面数据的操作
+ (void)insertWithCartoon:(CartoonModel *)model{
    
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = [NSString stringWithFormat:@"SELECT * FROM Table_cartoon WHERE save_ID = %@",model.id1];
        FMResultSet *set = [db executeQuery:str];
        if(set.next == NO){
            NSString *str =@"INSERT INTO Table_cartoon(save_ID,name,icon) values(?,?,?)";
            [db executeUpdate:str,model.id1,model.name,model.pic];
        }
        [set close];
    }];
}

+ (NSArray *)selectDataWithCartoon{
    
    
    NSMutableArray *arrM = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = @"SELECT * FROM Table_cartoon";
        FMResultSet *set = [db executeQuery:str];
        while ([set next]) {
            CartoonModel *hot = [[CartoonModel alloc]initWithResult:set];
            [arrM addObject:hot];
        }
        [set close];
    }];
    return arrM;
}
#pragma mark -新闻页面数据操作
+ (void)insertWithFinding:(FindingModel *)model{
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = [NSString stringWithFormat:@"SELECT * FROM Table_finding WHERE save_ID = %@",model.article_id];
        FMResultSet *set = [db executeQuery:str];
        if(set.next == NO){
            NSString *str =@"INSERT INTO Table_finding(save_ID,name,icon,url) values(?,?,?,?)";
            [db executeUpdate:str,model.article_id,model.title,model.cover,model.page_url];
        }
        [set close];
    }];
}

+ (NSArray *)selectDataWithFinding{
    NSMutableArray *arrM = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *str = @"SELECT * FROM Table_finding";
        FMResultSet *set = [db executeQuery:str];
        while ([set next]) {
            FindingModel *hot = [[FindingModel alloc]initWithResult:set];
            [arrM addObject:hot];
        }
        [set close];
    }];
    return arrM;
}


//清除缓存信息
+ (void)deletePartOfCacheInSqlite {
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        //[db executeUpdate:@"DELETE FROM Table_user"];
        [db executeUpdate:@"DELETE FROM Table_save"];
        [db executeUpdate:@"DELETE FROM Table_day"];
        [db executeUpdate:@"DELETE FROM Table_hot"];
        [db executeUpdate:@"DELETE FROM Table_cosplay"];
        [db executeUpdate:@"DELETE FROM Table_cartoon"];
        [db executeUpdate:@"DELETE FROM Table_finding"];
        
    }];
    
}









//- (instancetype)init{
//    if(self = [super init]){
//        NSString *path = [NSString stringWithFormat:@"%@/Documents/DataBase.rdb",NSHomeDirectory()];
//        NSLog(@"---------path:%@",path);
//        _dataBase = [[FMDatabase alloc]initWithPath:path];
////      创建数据库对象
////      通过数据库指定路径创建数据库对象（数据库管理者对象）
//        BOOL ret = [_dataBase open];
//        if(ret){
//            NSLog(@"数据库创建并打开成功");
//        }else{
//            NSLog(@"数据库创建打开失败");
//        }
//        
//    }
//    return self;
//}
////创建表
//- (void)createTable{
//    NSString *table_User = @"CREATE TABLE IF NOT EXISTS Table_user(user_ID INTEGER PRIMARY KEY , name varchar(50), icon varchar(200),  online INTEGER)";
//    [_dataBase executeUpdate:table_User];
//    
//    NSString *Table_Save = @"CREATE TABLE IF NOT EXISTS Table_save(save_id INTEGER PRIMARY KEY , icon varchar(200), name varchar(100))";
//    [_dataBase executeUpdate:Table_Save];
//    
//}

@end
*/