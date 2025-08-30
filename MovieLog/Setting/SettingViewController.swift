//
//  SettingViewController.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit
import RxSwift
import RxCocoa

class SettingViewController: UIViewController {

    private let infoBox = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#292929")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let nickName = {
        let label = Label(size: 18, weight: .bold, alignment: .left)
        label.text = UserDefaults.standard.string(forKey: "NickName")
        return label
    }()
    
    private let date = {
        let label = Label(size: 13, weight: .regular, alignment: .right)
        label.text = "\(UserDefaults.standard.string(forKey: "Date") ?? "") 가입 >"
        return label
    }()
    
    let likeCount = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#4A6246")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    private let question = {
        let button = SettingButton(title: "자주 묻는 질문")
        return button
    }()
    
    private let line1 = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    private let inquiry = {
        let button = SettingButton(title: "1:1 문의")
        return button
    }()
    
    private let line2 = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    private let alarm = {
        let button = SettingButton(title: "알림 설정")
        return button
    }()
    
    private let line3 = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    let delete = {
        let button = SettingButton(title: "탈퇴하기")
        return button
    }()
    
    private let line4 = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func bind() {
        UserDefaultsHelper.likeMovies
            .map { "\($0.count)개의 무비박스 보관 중"}
            .bind(to: likeCount.rx.title())
            .disposed(by: disposeBag)
        
        delete.rx.tap
            .bind(with: self) { owner, _ in
                let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴하시면 데이터가 모두 초기화됩니다.\n탈퇴하시겠습니까?", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "취소", style: .cancel)
                let ok = UIAlertAction(title: "확인", style: .default) { _ in
                    UserDefaults.standard.removeObject(forKey: "NickName")
                    UserDefaults.standard.removeObject(forKey: "LikeMovie")
                    UserDefaultsHelper.clearRecentSearch()
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                        let nav = UINavigationController(rootViewController: OnboardingViewController())
                        window.rootViewController = nav
                        window.makeKeyAndVisible()
                    }
                }
                alert.addAction(cancel)
                alert.addAction(ok)
                owner.present(alert, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureHierarchy() {
        [infoBox, nickName, date, likeCount, question, inquiry, alarm, delete, line1, line2, line3, line4]
            .forEach { view.addSubview($0) }
    }
    
    private func configureLayout() {
        infoBox.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(120)
        }
        nickName.snp.makeConstraints { make in
            make.top.equalTo(infoBox.snp.top).offset(20)
            make.leading.equalTo(infoBox.snp.leading).offset(20)
        }
        date.snp.makeConstraints { make in
            make.centerY.equalTo(nickName.snp.centerY)
            make.trailing.equalTo(infoBox.snp.trailing).offset(-20)
        }
        likeCount.snp.makeConstraints { make in
            make.top.equalTo(nickName.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(infoBox.snp.horizontalEdges).inset(20)
            make.height.equalTo(44)
        }
        question.snp.makeConstraints { make in
            make.top.equalTo(infoBox.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(infoBox.snp.horizontalEdges)
        }
        line1.snp.makeConstraints { make in
            make.top.equalTo(question.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        inquiry.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
        }
        line2.snp.makeConstraints { make in
            make.top.equalTo(inquiry.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        alarm.snp.makeConstraints { make in
            make.top.equalTo(line2.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
        }
        line3.snp.makeConstraints { make in
            make.top.equalTo(alarm.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        delete.snp.makeConstraints { make in
            make.top.equalTo(line3.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
        }
        line4.snp.makeConstraints { make in
            make.top.equalTo(delete.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
            make.height.equalTo(1)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .black
        navigationItem.title = "설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
