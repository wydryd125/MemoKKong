//
//  MemoDetailView.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/17.
//

import UIKit
import RxSwift
import SnapKit

final class MemoDetailView: BaseView {
    
    // MARK: - Property
    private var backgroundView = UIView()
    var privateLabel = UILabel()
    var titleLabel = UILabel()
    var addDateLabel = UILabel()
    var memoTextView = UITextView()
    var noticeButton = UIButton()
    var privateButton = UIButton()
    var addButton = UIButton()
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setAttribute()
        self.setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Interface
    
    
    
    // MARK: - UI
    private func setAttribute() {
        self.addSubview(self.backgroundView)
        
        [self.privateLabel, self.titleLabel, self.addDateLabel, self.memoTextView, self.noticeButton, self.privateButton, self.addButton].forEach {
            self.backgroundView.addSubview($0)
        }
        
        self.backgroundView.layer.cornerRadius = 24
        self.backgroundView.backgroundColor = .white
        self.backgroundView.addShadow(location: .bottom)
        
        self.privateLabel.text = "PRIVATE MEMO"
        self.privateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.privateLabel.textColor = .customDeepPinkColor
        
        self.titleLabel.text = "그냥 메모야"
        self.titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
        self.addDateLabel.text = "2022.09.18 08:18"
        self.addDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.addDateLabel.textColor = .customLightGrayColor
        
        self.memoTextView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.memoTextView.textColor = .customLightGrayColor
        
        self.noticeButton.backgroundColor = .customYellowColor
        self.noticeButton.layer.cornerRadius = 20
        self.noticeButton.setImage(UIImage(named: "pinWhite.png"), for: .normal)
        
        self.privateButton.backgroundColor = .customDeepPinkColor
        self.privateButton.layer.cornerRadius = 20
        self.privateButton.setImage(UIImage(named: "lockWhite.png"), for: .normal)
        
        self.addButton.backgroundColor = .customBlueColor
        self.addButton.layer.cornerRadius = 30
        self.addButton.setImage(UIImage(named: "checkWhite.png"), for: .normal)
        
    }
    
    private func setConstraint() {
        let guide = self.safeAreaLayoutGuide
        
        self.backgroundView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(guide.snp.height).multipliedBy(0.88)
            make.centerX.centerY.equalTo(guide)
        }
        
        self.privateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(16)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(privateLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.addDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel).inset(8)
        }
        
        self.noticeButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(24)
            make.width.height.equalTo(40)
        }
        
        self.addButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(24)
            make.width.height.equalTo(60)
        }
        
        self.privateButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.addButton.snp.leading).inset(-8)
            make.bottom.equalTo(self.addButton)
            make.width.height.equalTo(40)
        }
        
        self.memoTextView.snp.makeConstraints { make in
            make.top.equalTo(self.addDateLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.backgroundView).inset(12)
            make.bottom.equalTo(self.addButton.snp.top).inset(-16)
        }
        
    }
}
