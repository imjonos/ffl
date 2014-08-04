//
//  FFLData.m
//  FFL
//
//  Created by NOs on 05.12.13.
//  Copyright (c) 2013 NOs. All rights reserved.
//

#import "FFLData.h"
#import "parser/HTMLParser.h"

@implementation FFLData
@synthesize done=m_done;
@synthesize titles=m_titles;
@synthesize error=m_error;

// чистка ресурсов
-(void) dealloc {
  

}

// документ начал парситься
- (void)parserDidStartDocument:(NSXMLParser *)parser {

    m_done = NO;
    m_titles = [NSMutableArray new];
    m_elements =[NSMutableArray new];
}
// парсинг окончен
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    m_done = YES;
}
// если произошла ошибка парсинга
-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    m_done = YES;
 //   m_error = [parseError retain];
}
// если произошла ошибка валидации
-(void) parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    m_done = YES;
  //  m_error = [validationError retain];
}
// встретили новый элемент
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // проверяем, нашли ли мы элемент "title"
    m_isTitle = [[elementName lowercaseString] isEqualToString:@"title"];
    
    
    if ( m_isTitle ) {
        // если да - создаем строку в которую запишем его значение
        m_title = [NSMutableString new];
    }
    
    m_isLink = [[elementName lowercaseString] isEqualToString:@"link"];
    
    if ( m_isLink ) {
        // если да - создаем строку в которую запишем его значение
        m_link = [NSMutableString new];
    }
    
    m_isDate = [[elementName lowercaseString] isEqualToString:@"pubdate"];
    
    if ( m_isDate ) {
        // если да - создаем строку в которую запишем его значение
        m_date = [NSMutableString new];
    }
    
    m_isDesc = [[elementName lowercaseString] isEqualToString:@"description"];
    
    if ( m_isDesc ) {
        // если да - создаем строку в которую запишем его значение
        m_desc = [NSMutableString new];
    }
    m_isCat = [[elementName lowercaseString] isEqualToString:@"category"];
    if ( m_isCat ) {
        // если да - создаем строку в которую запишем его значение
        m_cat = [NSMutableString new];
    }

    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
    if([[elementName lowercaseString] isEqualToString:@"title"]){
       
        if([m_elements count]>0){
            NSMutableArray *m_elements_back=[[NSMutableArray alloc] initWithArray:m_elements copyItems:YES];
            [m_titles addObject:m_elements_back];
            [m_elements removeAllObjects];
        }
        [m_elements addObject:@""];
        [m_elements addObject:@""];
        [m_elements addObject:@""];
        [m_elements addObject:@""];
        [m_elements addObject:@""];
       
        
    }
    
    // если элемент title закончился - добавим строку в результат
    if ( m_isTitle ) {
        //[m_titles addObject:m_title];
        //[m_elements addObject:m_title];
        [m_elements removeObjectAtIndex:0];
        [m_elements insertObject:m_title atIndex:0];
        m_isTitle=NO;
        
       // [m_title release];
    }
    
    if ( m_isLink ) {
        //[m_elements addObject:m_link];
        // [m_title release];
        [m_elements removeObjectAtIndex:1];
        [m_elements insertObject:m_link atIndex:1];
        
        m_isLink=NO;
    }
    
    if ( m_isDate ) {
        //[m_elements addObject:m_date];
        // [m_title release];
        [m_elements removeObjectAtIndex:2];
        [m_elements insertObject:m_date atIndex:2];
        
        m_isDate=NO;
    }
    
    if ( m_isDesc ) {
        //[m_elements addObject:m_desc];
        // [m_title release];
        [m_elements removeObjectAtIndex:3];
        [m_elements insertObject:m_desc atIndex:3];
        
        m_isDesc=NO;
    }
    
    if ( m_isCat ) {
        //[m_elements addObject:m_cat];
        // [m_title release];
        [m_elements removeObjectAtIndex:4];
        [m_elements insertObject:m_cat atIndex:4];
        
        m_isCat=NO;
    }
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // если сейчас получаем значение элемента title
    // добавим часть его значения к строке
    if ( m_isTitle ) {
        [m_title appendString:string];
    }
    
    if ( m_isLink ) {
        [m_link appendString:string];
    }
    
    if ( m_isDate ) {
        
       NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        assert(enUSPOSIXLocale != nil);
        
        [dateFormat setLocale:enUSPOSIXLocale];
        
        [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
        // [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDate *date = [dateFormat dateFromString:string];
        [dateFormat setDateFormat:@"EE, Y-MM-dd HH:mm:ss"];
         NSString *dateString =  [dateFormat stringFromDate:date];
       // NSLog(@"%@ %@ %@",string,dateString,date);
        if([dateString length]>0) [m_date appendString:dateString];
    }
    
    if ( m_isDesc ) {
        [m_desc appendString:string];
        NSString *strCat=[self getCatFromHtml:string];
       // NSLog(@"->%@",strCat);
        if([strCat length]!=0) {
            //[m_cat appendString:strCat];
            [m_elements removeObjectAtIndex:4];
            [m_elements insertObject:strCat atIndex:4];
           // m_isCat=YES;
        }
        
    }
    
    if ( m_isCat ) {
        if([m_cat length]==0) {
            NSString *strCat=[self stringByStrippingHTML:string];
            [m_cat appendString:strCat];
        }
    }
    
    
}

-(NSString *) stringByStrippingHTML:(NSString *)source{
    NSRange r;
    NSString *s = source;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}


-(NSUInteger) inString:(NSString *)source Find: (NSString *) find
{

    NSUInteger cnt = 0, length = [source length];
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [source rangeOfString: find options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            cnt++; 
        }
    }
    
    return cnt;
}
-(NSString *) getCatFromHtml:(NSString *)text{
    NSString *result=@"";
    
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:text error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        
    }else{
    
        HTMLNode *bodyNode = [parser body];
        
        NSArray *postNodes = [bodyNode findChildTags:@"a"];
        int i=0;
        for (HTMLNode *postNode in postNodes) {
            NSString *nameOfCat = [postNode contents];
            
            if(i<2 && [self inString:nameOfCat Find:@"http"]==0 && [self inString:nameOfCat Find:@"www"]==0){
                if([result length]==0) result=nameOfCat;
                else
                result=[NSString stringWithFormat:@"%@ %@",result,nameOfCat];
            }
            i++;
        }

        
    }
    
    
    return result;
}

@end
