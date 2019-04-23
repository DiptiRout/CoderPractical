//
//  CodeDetailsCell.swift
//  DecoderPractical
//
//  Created by Muvi on 09/04/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit

class CodeDetailsCell: UITableViewCell {

    static let CellID = "CodeCell"
    
    
    @IBOutlet weak var userImageView: CachedImageView!
    @IBOutlet weak var codeTitleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var codeTAG: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var dislikeLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet var thumbs: [UIImageView]!
    
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbs.forEach { (imageView) in
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor.darkGray
        }
        shadowView.dropShadow(opacity: 1, radius: 3)
        shadowView.layer.cornerRadius = 10
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        userImageView.clipsToBounds = true
        
    }

    var codesViewModel: CodesViewModel! {
        didSet {
            userImageView.loadImage(urlString: codesViewModel.userImage)
            codeTitleLabel.text = codesViewModel.title
            userNameLabel.text = codesViewModel.userName
            codeTAG.text = codesViewModel.codeLanguage
            commentsLabel.text = codesViewModel.comments
            likeLabel.text = codesViewModel.upvotes
            dislikeLabel.text = codesViewModel.downvotes
        }
    }

}
