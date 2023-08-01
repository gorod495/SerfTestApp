//
//  ProfileVC.swift
//  testApp
//
//  Created by Городецкий Илья on 01.08.2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    fileprivate let headerID = String(describing: CollectionViewHeader.self)
    let mostPopularHeader = "id"
    fileprivate let headers = ["", "Мои навыки", "О себе"]
    fileprivate var canEditSkills = false
    fileprivate var skillsArr: [String] = ["MVI/MVVM", "Kotlin Coroutines", "Room", "OkHttp", "DataStore", "WorkManager"]
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfig()
    }
    
    // MARK: - Methods
    fileprivate func collectionViewConfig() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.collectionViewLayout = createLayout()
        
        let nib = UINib(nibName: headerID, bundle: nil)
        collectionView.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        collectionView.register(UserMainInfoCell.nib(), forCellWithReuseIdentifier: UserMainInfoCell.identifier)
        collectionView.register(SkillCell.nib(), forCellWithReuseIdentifier: SkillCell.identifier)
        collectionView.register(DescriptionCell.nib(), forCellWithReuseIdentifier: DescriptionCell.identifier)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {(sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize( widthDimension: .fractionalWidth(1),
                                                                                      heightDimension: .estimated(1)))
                item.contentInsets.trailing = 0
                item.contentInsets.leading = 0
                item.contentInsets.top = 0
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
                group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                group.interItemSpacing = .fixed(8)
                
            let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
            return section
                
            } else if sectionNumber == 1 {
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .absolute(44)))
                
                let group = NSCollectionLayoutGroup.horizontal( layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), subitems: [item])
                group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                group.interItemSpacing = .fixed(12)

                
            let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.interGroupSpacing = 12
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(59)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                
            return section
            
            } else if sectionNumber == 2 {
                let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
                item.contentInsets.trailing = 0
                item.contentInsets.leading = 0
                item.contentInsets.top = 0
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
                
                group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                group.interItemSpacing = .fixed(8)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 0
                
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(59)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                
                return section
            } else {
                return nil
            }
        }
    }
    
    func showAddSkillAlert() {
        let ac = UIAlertController(title: "Добавление навыка", message: "Введите название навыка которым вы владеете", preferredStyle: .alert)
        ac.addTextField()

        let addSkill = UIAlertAction(title: "Добавить", style: .default) { [unowned ac] _ in
            let newSkill = ac.textFields![0]
            self.skillsArr.append(newSkill.text ?? "")
            self.collectionView.reloadSections(IndexSet(integer: 1))
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) {_ in }

        ac.addAction(addSkill)
        ac.addAction(cancel)

        present(ac, animated: true)
    }
    
    
}

    // MARK: - Collection view data source & delegate
extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeader.identifier, for: indexPath) as! CollectionViewHeader
            let title = headers[indexPath.section]
            sectionHeader.setupHeader(title: title, canEdit: canEditSkills)
            sectionHeader.delegate = self
            if indexPath.section == 1 {
                sectionHeader.editBtn.isHidden = false
            } else {
                sectionHeader.editBtn.isHidden = true
            }
            
            return sectionHeader
            
        case UICollectionView.elementKindSectionFooter:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeader.identifier, for: indexPath) as! CollectionViewHeader
            sectionHeader.title = ""
            return sectionHeader
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            
        case 0, 2:
            return 1
            
        case 1:
            return canEditSkills ? (skillsArr.count + 1) : skillsArr.count
            
        default:
            return 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0:
            let mainInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: UserMainInfoCell.identifier, for: indexPath) as! UserMainInfoCell
            return mainInfoCell
            
        case 1:
            
            let skillCell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillCell.identifier, for: indexPath) as! SkillCell
            
            skillCell.delegate = self
            
            if canEditSkills && indexPath.item == skillsArr.count {
                skillCell.setupCell(item: "+", canEdit: canEditSkills, index: indexPath.item)
            } else {
                skillCell.setupCell(item: skillsArr[indexPath.item], canEdit: canEditSkills, index: indexPath.item)
            }
            
            return skillCell
            
        case 2:
            let descriptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionCell.identifier, for: indexPath) as! DescriptionCell
            return descriptionCell
            
        default:
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if canEditSkills && indexPath.section == 1 && indexPath.item == skillsArr.count {
            showAddSkillAlert()
        }
    }
}


    // MARK: - Header delegate
extension ProfileVC: HeaderDelegate {
    func didTapEditBtn() {
        canEditSkills = !canEditSkills
        collectionView.reloadSections(IndexSet(integer: 1))
    }
}

    // MARK: - Skill cell delegate
extension ProfileVC: SkillCellDelegate {
    func didTapDeleteBtn(button: UIButton) {
        let index = button.tag
        skillsArr.remove(at: index)
        collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    
}
