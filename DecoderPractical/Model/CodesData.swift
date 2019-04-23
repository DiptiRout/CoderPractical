//
//  CodesData.swift
//  DecoderPractical
//
//  Created by Muvi on 09/04/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

struct CodesData: Decodable {
    let userName: String?
    let userImageUrl: String?
    let time: String?
    let tags: [String]?
    let title: String?
    let code: String?
    let codeLanguage: String?
    let upvotes: Int?
    let downvotes: Int?
    let comments: Int?
}
