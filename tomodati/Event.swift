//
//  Event.swift
//  tomodati
//
//  Created by 海月 on 2022/07/06.
//

import Foundation
import FirebaseFirestoreSwift

struct EventData: Codable{
    @DocumentID var id: String?
    var date: Date
    var topic: String
    var spot: String
    var user1: String
    var user2: String
}


