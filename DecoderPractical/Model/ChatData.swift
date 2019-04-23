//
//  ChatData.swift
//  DecoderPractical
//
//  Created by Muvi on 09/04/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

struct ChatData: Decodable {
    let userName: String?
    let userImageUrl: String?
    let isSentByMe: Bool?
    let text: String?
}
