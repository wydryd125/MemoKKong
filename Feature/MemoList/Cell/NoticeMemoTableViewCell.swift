//
//  NoticeMemoTableViewCell.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/27.
//

import UIKit
import SnapKit

class NoticeMemoTableViewCell: UITableViewCell {
    static let identifier = "NoticeMemoTableViewCell"
    
    var noticeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setAttribute()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttribute() {

        self.contentView.addSubview(noticeCollectionView)
        self.noticeCollectionView.backgroundColor = .backgroundColor
        self.noticeCollectionView.showsHorizontalScrollIndicator = false
        
    }
    
    private func setConstraint() {
        
        self.noticeCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }

}
