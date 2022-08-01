//
//  MemoListTableViewCell.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/19.
//

import UIKit
import SnapKit

class MemoListTableViewCell: UITableViewCell {
    static let identifier = "MemoListTableViewCell"
    
    private let backgoundView = UIView()
    var privateLabel = UILabel()
    var memoLabel = UILabel()
    var dateLabel = UILabel()
    var noticeImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setAttribute()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawCell(memo: Memo?) {
        if let memo = memo {
            privateLabel.text = memo.selectedPrivate ? "PRIVATE MEMO" : ""
            noticeImageView.isHidden = memo.selectedNotice ? false : true
            memoLabel.text = memo.memoTitle
            dateLabel.text = dateFormate(date: memo.insertDate)
        }
    }
    
    func dateFormate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter.string(from: date)
    }
    
    private func setAttribute() {
        addSubview(backgoundView)
        backgoundView.addSubview(noticeImageView)
        
        [privateLabel, memoLabel, dateLabel].forEach {
            backgoundView.addSubview($0)
        }
        
        backgroundColor = .backgroundColor
        
        backgoundView.backgroundColor = .white
        backgoundView.layer.cornerRadius = 8
        backgoundView.addShadow(location: .bottom)
        
        privateLabel.text = "PRIVATE MEMO"
        privateLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        privateLabel.textColor = .customDeepPinkColor
        
        memoLabel.textColor = .black
        memoLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        dateLabel.textColor = .customLightGrayColor
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        noticeImageView.layer.cornerRadius = 20
        noticeImageView.layer.borderWidth = 4
        noticeImageView.layer.borderColor = UIColor.customYellowColor.cgColor
        noticeImageView.backgroundColor = .customYellowColor
        noticeImageView.contentMode = .center
        noticeImageView.image = UIImage(named: "pinWhiteFilled.png")
        
    }
    
    private func setConstraint() {
        backgoundView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        privateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
        }
        
        noticeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
            make.width.height.equalTo(40)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(noticeImageView)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(noticeImageView.snp.leading).inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(memoLabel)
        }
        
        
    }
    
}
