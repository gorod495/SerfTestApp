//
//  CollectionViewHeader.swift
//  SafetyIsland safety island
//
//  Created by Городецкий Илья on 27.09.2022.
//  Copyright © 2022 Илья. All rights reserved.
//

import UIKit

protocol HeaderDelegate: AnyObject {
    func didTapEditBtn()
}

class CollectionViewHeader: UICollectionReusableView {
    
    // MARK: - Static
    static let identifier = "CollectionViewHeader"
    static func nib() -> UINib { return UINib(nibName: "CollectionViewHeader", bundle: nil) }
    
    // MARK: - Properties
    weak var delegate: HeaderDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    var title: String! {
        didSet {
            titleLbl.text = title
        }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Methods
    func setupHeader(title: String, canEdit: Bool) {
        titleLbl.text = title
        
        if !canEdit {
            editBtn.setImage(UIImage(named: "ic_pen"), for: .normal)
        } else {
            editBtn.setImage(UIImage(named: "ic_checkMark"), for: .normal)
        }
    }
    
    // MARK: - Actions
    @IBAction func clickOnEditBtn(_ sender: Any) {
        delegate?.didTapEditBtn()
    }
    
}
