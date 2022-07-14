//
//  MemoComposeView.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/14.
//

import UIKit
import SnapKit

final class MemoComposeView: BaseView {
    
    // MARK: - Property
    private var backgroundView = UIView()
    var titleTextField = UITextField()
    var memoTextView = UITextView()
    var noticeButton = UIButton()
    var secretButton = UIButton()
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
    
        [self.titleTextField, self.memoTextView, self.noticeButton, self.secretButton, self.addButton].forEach {
            self.backgroundView.addSubview($0)
        }
        
        self.backgroundView.layer.cornerRadius = 24
        self.backgroundView.backgroundColor = .white
        self.backgroundView.addShadow(location: .bottom)
        
        
        self.titleTextField.placeholder = "어떤 메모일까요 ?"
        self.titleTextField.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
        self.memoTextView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.memoTextView.textColor = .customLightGrayColor
        
        self.noticeButton.backgroundColor = .customYellowColor
        self.noticeButton.layer.cornerRadius = 20
        
        self.secretButton.backgroundColor = .customDeepPinkColor
        self.secretButton.layer.cornerRadius = 20
        
        self.addButton.backgroundColor = .customBlueColor
        self.addButton.layer.cornerRadius = 30
        
    }
    
    private func setConstraint() {
        let guide = self.safeAreaLayoutGuide
        
        self.backgroundView.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top).inset(32)
            make.bottom.equalTo(guide.snp.bottom).inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        self.titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.noticeButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(24)
            make.width.height.equalTo(40)
        }
        
        self.addButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(24)
            make.width.height.equalTo(60)
        }
        
        self.secretButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.addButton.snp.leading).inset(-8)
            make.bottom.equalTo(self.addButton)
            make.width.height.equalTo(40)
        }
        
        self.memoTextView.snp.makeConstraints { make in
            make.top.equalTo(self.titleTextField.snp.bottom).offset(24)
            make.leading.trailing.equalTo(self.backgroundView).inset(12)
            make.bottom.equalTo(self.addButton.snp.top).inset(-16)
        }
        
    }
}
