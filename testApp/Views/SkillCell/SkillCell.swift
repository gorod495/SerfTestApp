//
//  SkillCell.swift
//  testApp
//
//  Created by Городецкий Илья on 01.08.2023.
//

import UIKit

protocol SkillCellDelegate: AnyObject {
    func didTapDeleteBtn(button: UIButton)
}

class SkillCell: UICollectionViewCell {
    
    // MARK: - Static
    static let identifier = "SkillCell"
    static func nib() -> UINib { return UINib(nibName: "SkillCell", bundle: nil) }
    
    // MARK: - Outlets
    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var skillLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    // MARK: - Properties
    weak var delegate: SkillCellDelegate?
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        customContentView.layer.cornerRadius = 12
    }
    
    // MARK: - Methods
    func setupCell(item: String, canEdit: Bool, index: Int) {
        skillLbl.text = item
        deleteBtn.tag = index
        deleteBtn.isHidden = !canEdit
        
        if item == "+" {
            deleteBtn.isHidden = true
        }
        
    }
    
    // MARK: - Actions
    @IBAction func clickOnDeleteBtn(_ sender: UIButton) {
        delegate?.didTapDeleteBtn(button: sender)
    }
    
}
