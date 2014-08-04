//
//  FFLData.h
//  FFL
//
//  Created by NOs on 05.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFLData : NSObject <NSXMLParserDelegate>{
    BOOL m_done;
    BOOL m_isTitle;
    BOOL m_isLink;
    BOOL m_isDate;
    BOOL m_isDesc;
    BOOL m_isCat;
    
    NSError* m_error;
    NSMutableArray* m_titles;
    NSMutableArray* m_elements;
    
    NSMutableString* m_title;
    NSMutableString* m_link;
    NSMutableString* m_date;
    NSMutableString* m_desc;
    NSMutableString* m_cat;
    
}
-(NSString *) getCatFromHtml:(NSString *)text;
-(NSUInteger) inString:(NSString *)source Find: (NSString *) find;
-(NSString *) stringByStrippingHTML:(NSString *)source;
// свойство-флаг, который показывает закончен ли парсинг

@property (readonly) BOOL done;
// если есть ошибка - ее описание, если нет - nil
@property (readonly) NSError* error;
// результат парсинга
@property (readonly) NSArray* titles;

@end
