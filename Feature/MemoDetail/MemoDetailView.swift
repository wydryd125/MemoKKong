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
    var titleTextField = UITextField()
    var addDateLabel = UILabel()
    var memoTextView = UITextView()
    var noticeButton = UIButton()
    var privateButton = UIButton()
    var addButton = UIButton()
    
    let bag = DisposeBag()
    
    var selectedNotice = false
    var selectedPrivate = false
    
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
    func setMemoData(memo: Memo) {
        self.privateLabel.text = memo.selectedPrivate ? "PRIVATE MEMO" : ""
        
        self.titleTextField.text = memo.memoTitle
        self.memoTextView.text = memo.content
        
        self.addDateLabel.text = dateFormate(date: memo.insertDate)
        
        self.selectedNotice = memo.selectedNotice
        self.noticeButton.setImage(UIImage(named: self.selectedNotice ? "pinWhiteFilled.png" : "pinWhite.png"), for: .normal)
        
        self.selectedPrivate = memo.selectedPrivate
        self.privateButton.setImage(UIImage(named: self.selectedPrivate ? "lockWhiteFilled.png" : "lockWhite.png"), for: .normal)
    }
    
    
    // MARK: - UI
    private func setAttribute() {
        self.addSubview(self.backgroundView)
        
        [self.privateLabel, self.titleTextField, self.addDateLabel, self.memoTextView, self.noticeButton, self.privateButton, self.addButton].forEach {
            self.backgroundView.addSubview($0)
        }
        
        self.backgroundView.layer.cornerRadius = 24
        self.backgroundView.backgroundColor = .white
        self.backgroundView.addShadow(location: .bottom)
        
        self.privateLabel.text = ""
        self.privateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.privateLabel.textColor = .customDeepPinkColor
        
        self.titleTextField.text = ""
        self.titleTextField.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
        self.addDateLabel.text = dateFormate(date: Date())
        self.addDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.addDateLabel.textColor = .customLightGrayColor
        
        self.memoTextView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.memoTextView.textColor = .customLightGrayColor
        self.memoTextView.text = ""
        
        self.noticeButton.backgroundColor = .customYellowColor
        self.noticeButton.layer.cornerRadius = 20
        self.noticeButton.rx.tap
            .bind {
                self.selectedNotice.toggle()
                self.noticeButton.setImage(UIImage(named: self.selectedNotice ? "pinWhiteFilled.png" : "pinWhite.png" ), for: .normal)
            }
            .disposed(by: bag)
        
        self.privateButton.backgroundColor = .customDeepPinkColor
        self.privateButton.layer.cornerRadius = 20
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
            make.centerX.centerY.equalTo(guide)
        }
        
        self.privateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(16)
        }
        
        self.titleTextField.snp.makeConstraints { make in
            make.top.equalTo(privateLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.addDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleTextField)
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
    
    func dateFormate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter.string(from: date)
    }
}
