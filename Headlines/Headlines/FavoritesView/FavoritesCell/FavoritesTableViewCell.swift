//
//  FavoritesTableViewCell.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleILabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var article: Article? {
        didSet {
            configureCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

private extension FavoritesTableViewCell {
    
    // configure favorite cell
    func configureCell() {
        titleILabel.text = article?.webTitle
        let formatter = ISO8601DateFormatter()
        if let pubDate = article?.webPublicationDate,
           let date = formatter.date(from: pubDate) {
            subTitleLabel.text = date.convertDateToString()
        }
        if let imageURL = article?.fields?.main?.url?.absoluteURL {
            iconImageView.sd_setImage(with: imageURL)
        }
    }
}
