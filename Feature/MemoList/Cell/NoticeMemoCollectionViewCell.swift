//
//  NoticeMemoCollectionViewCell.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/18.
//

import UIKit
import SnapKit

class NoticeMemoCollectionViewCell: UICollectionViewCell {
    static let identifier = "NoticeMemoCollectionViewCell"
    
    let pointView = UIView()
    let privateView = UIView()
    let memoLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setAttribute()
        self.setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawCell(memo: Memo) {
        memoLabel.text = memo.memoTitle
        dateLabel.text = dateFormate(date: memo.insertDate)
        privateView.isHidden = memo.selectedPrivate ? false : true
        
    }
    
    func dateFormate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter.string(from: date)
    }
    
    private func setAttribute() {
        [pointView, privateView, memoLabel, dateLabel].forEach {
            addSubview($0)
        }
        
        backgroundColor = .white
        layer.cornerRadius = 8
        addShadow(location: .bottom)
        
        pointView.backgroundColor = .customYellowColor
        pointView.layer.cornerRadius = 8
        
        privateView.backgroundColor = .customDeepPinkColor
        privateView.layer.cornerRadius = 8
        
        memoLabel.textColor = .black
        memoLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        dateLabel.textColor = .customLightGrayColor
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    private func setConstraint() {
        
        pointView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.width.height.equalTo(16)
        }
        
        privateView.snp.makeConstraints { make in
            make.top.equalTo(pointView.snp.top)
            make.leading.equalTo(pointView.snp.trailing).offset(4)
            make.width.height.equalTo(16)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(memoLabel)
        }
    }
}
