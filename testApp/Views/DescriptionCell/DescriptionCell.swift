//
//  DescriptionCell.swift
//  testApp
//
//  Created by Городецкий Илья on 01.08.2023.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    
    // MARK: - Static
    static let identifier = "DescriptionCell"
    static func nib() -> UINib { return UINib(nibName: "DescriptionCell", bundle: nil) }

}
