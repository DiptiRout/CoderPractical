//
//  ChatViewModel.swift
//  DecoderPractical
//
//  Created by Muvi on 10/04/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

struct ChatViewModel {
    let content: String
    let senderID: String
    let senderName: String
    
    init(chat: ChatData) {
        self.content = chat.text ?? ""
        self.senderName = chat.userName ?? ""
        self.senderID = "001"
    }
}
