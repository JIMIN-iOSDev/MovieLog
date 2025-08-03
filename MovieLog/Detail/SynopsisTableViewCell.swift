//
//  SynopsisTableViewCell.swift
//  MovieLog
//
//  Created by Jimin on 8/3/25.
//

import UIKit
import SnapKit

class SynopsisTableViewCell: BaseTableViewCell {

    static let identifier = "SynopsisTableViewCell"
    
    private let synopsis = {
        let label = Label(size: 15, weight: .regular, alignment: .left)
        label.text = "교내 그룹은 첫 학기에 이미 결정되는 것!. 우리의 에리카(니카이도 후미) 역시 첫 학기에 자신에 말을 처음 걸어준 센 언니들과 그룹이 되면서 거짓말은 시작되었다. 모두들 남자친구와의 경험을 자랑스레 늘어놓는 그 무리에서, 뒤 쳐질 수 없었던 에리카는 가상의 남자친구와의 일들을 늘어놓기 시작했다. '나는 OO 했어'라는 말에 '그쯤이야 뭐...'라며 잔득 거짓말을 해놓은 상태.  어느날 화장실에 친구들이 자신의 말에 의구심을 품는다는 것을 알아버린 에리카는 베스트 프렌드 산다(카도와키 무기)와 함께 잘생긴 어느 남학생을 무턱대고 도촬해 버리고 그를 자신의 남자친구라 거짓말을 늘어놓게 된다. 하지만 그가 8반의 킹카 사타(야마자키 켄토)라는 것이 밝혀지면서, 자신의 거짓말 인생에 큰 위기를 맞게 되는 에리카. 그순간 '자신의 멍뭉이'가 되는 조건으로 에리카의 거짓말에 사타가 합류하기로 하면서 위기는 일단락된다.  사타라는 양치기 왕자님이 점점 좋아지는 에리카. 그녀의 늑대소녀 이야기는 해피엔딩이 될 수 있을까?"
        label.numberOfLines = 3
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(synopsis)
    }
    
    override func configureLayout() {
        synopsis.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
