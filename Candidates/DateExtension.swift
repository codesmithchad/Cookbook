//
//  DateExtension.swift
//  Student
//
//  Created by Ajiaco on 28/03/2019.
//  Copyright © 2019 TPR. All rights reserved.
//

import Foundation

extension String {
    // MARK: - UTC timestamp
    /**
     시간 문자열을 지정된 포맷의 UTC 시간 문자열로 변환하는 익스텐션
        * 서버로부터 받은 시간을 포매팅하는데 사용 (MyBoardManager, NotificationsManger, TutoringRoomManager)
     - Parameter format: String, 변환할 시간 포맷
     - Returns: format String, 인자의 형태로 변환된 시간 문자열
     */
    func stringDateParser(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss+SSSS"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    
    // MARK: - GMT timestamp
    /**
     시간 문자열을 지정된 포맷의 GMT 시간 문자열로 변환하는 익스텐션
        * 영수증의 만료일 변환에 사용
     - Parameter format: String, 변환할 시간 포맷
     - Returns: String, format 인자의 형태로 변환된 시간 문자열
     */
    func stringDateParserGMT(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    
    // MARK: - Date string to Date
    /**
     시간 문자열을 Date 객체로 변환하는 익스텐션
        * TutoringRoomManager의 채팅 내용 시간 비교에 사용, 직접 시간을 표시하는데는 사용하지 않음
     - Returns: yyyy-MM-dd HH:mm:ss+SSSS 포맷의 문자열을 Date로 변환한 객체
     */
    func utcFormDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss+SSSS"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        return dateFormatter.date(from: self)
    }
}


extension Date {
    // MARK: - ISO8601 Formatter
    /**
     Date 객체를 ISO8601 포맷의 스트링으로 변환하는 익스텐션
        * Logger의 자체로깅 시간 인자로 사용
     - Returns: UTC 타임존, yyyy-MM-dd'T'HH:mm:ssxxxxx 포맷으로 변환된 문자열
     */
    func iso8601FormDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx" // "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone? // TimeZone(secondsFromGMT: 0)
        
        
        return dateFormatter.string(from: self)
//        return dateFormatter.date(from: self)
    }
    
    /**
     기준일로 부터 경과한 날 수
     - Returns: Int, 계산한 날 수
     */
    func estimateDaysFromNow() -> Int? {
        let calendar = Calendar(identifier: .gregorian)
        let now = Date()
        let components = calendar.dateComponents([.day], from: self, to: now)
        
        return components.day
    }
}
