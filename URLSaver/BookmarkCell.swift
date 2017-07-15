//
//  BookmarkCell.swift
//  URLSaver
//
//  Created by radhakrishnan S on 15/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

public class BookmarkCell: UITableViewCell {

    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
