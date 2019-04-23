//
//  CodesViewModel.swift
//  DecoderPractical
//
//  Created by Muvi on 10/04/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit

struct CodesViewModel {
    let title: String
    let userName: String
    let userImage: String
    let time: String
    let codeLanguage: String
    let upvotes: String
    let downvotes: String
    let comments: String
    
    init(codes: CodesData) {
        self.title = codes.title ?? ""
        self.userName = codes.userName ?? ""
        self.userImage = codes.userImageUrl ?? ""
        self.time = codes.time ?? ""
        self.codeLanguage = codes.codeLanguage ?? ""
        self.upvotes = "\(codes.upvotes ?? 0)"
        self.downvotes = "\(codes.downvotes ?? 0)"
        self.comments = "\(codes.comments ?? 0)"
    }
}
