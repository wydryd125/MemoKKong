//
//  MemoComposeView.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/14.
//

import UIKit
import RxSwift
import SnapKit

final class MemoComposeView: BaseView {
    
    // MARK: - Property
    private var backgroundView = UIView()
    var titleTextField = UITextField()
    var memoTextView = UITextView()
    var noticeButton = UIButton()
    var privateButton = UIButton()
    var addButton = UIButton()
    
    private var selectedNotice = false
    private var selectedPrivate = false
    private let bag = DisposeBag()
    
    
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
        
        [self.titleTextField, self.memoTextView, self.noticeButton, self.privateButton, self.addButton].forEach {
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
        self.noticeButton.setImage(UIImage(named: "pinWhite.png"), for: .normal)
        
        self.noticeButton.rx.tap
            .bind {
                self.selectedNotice.toggle()
                self.noticeButton.setImage(UIImage(named: self.selectedNotice ? "pinWhiteFilled.png" : "pinWhite.png" ), for: .normal)
            }
            .disposed(by: bag)
        
        self.privateButton.backgroundColor = .customDeepPinkColor
        self.privateButton.layer.cornerRadius = 20
        self.privateButton.setImage(UIImage(named: "lockWhite.png"), for: .normal)
        
        self.privateButton.rx.tap
            .bind {
                self.selectedPrivate.toggle()
                self.privateButton.setImage(UIImage(named: self.selectedPrivate ? "lockWhiteFilled.png" :  "lockWhite.png"), for: .normal)
            }
            .disposed(by: bag)
        
        self.addButton.backgroundColor = .customBlueColor
        self.addButton.layer.cornerRadius = 30
        self.addButton.setImage(UIImage(named: "checkWhite.png"), for: .normal)
        
    }
    
    private func setConstraint() {
        let guide = self.safeAreaLayoutGuide
        
        self.backgroundView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(guide.snp.height).multipliedBy(0.88)
            make.center.equalTo(guide)
            
        }
        
        self.titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
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
        
        self.privateButton.snp.makeConstraints { make in
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
