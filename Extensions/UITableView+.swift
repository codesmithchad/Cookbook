import UIKit

extension UITableView {
    func setEmptyView() {
        self.separatorStyle = .none
        let emptyView = UIView(frame: CGRect(x: center.x, y: center.y, width: bounds.size.width, height: bounds.size.height))
        let emptyHeaderBottomView = UIView()
        let emptyBackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 26
        }
        let emptyImageView = UIImageView(image: Asset.Assets.icEmptypageWarning.image).then {
            $0.contentMode = .scaleAspectFit
        }
        let emptyLabel = UILabel().then { label in
            label.text = Strings.allEmptyContents
            label.textColor = .gray600
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textAlignment = .center
        }
        emptyView.addSubview(emptyHeaderBottomView)
        emptyHeaderBottomView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(tableHeaderView?.frame.size.height ?? 0)
            make.left.right.bottom.equalToSuperview()
        }
        emptyHeaderBottomView.addSubview(emptyBackView)
        emptyBackView.addArrangedSubviews(emptyImageView, emptyLabel)
        emptyImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(26)
        }
        emptyBackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.backgroundView = emptyView
    }

    func restoreEmptyView(_ lineStyle: UITableViewCell.SeparatorStyle = .singleLine) {
        self.backgroundView = nil
        self.separatorStyle = lineStyle
    }

    func reloadDataKeepOffset(topBaseFlag: Bool) {
        let beforeFirstRow = indexPathsForVisibleRows?.first
        let beforeRowCount = numberOfRows(inSection: 0)
        reloadData()
        layoutIfNeeded()

        let afterRowCount = numberOfRows(inSection: 0)
        let rowNum = topBaseFlag ? (beforeFirstRow?.row ?? 0) : ((beforeFirstRow?.row ?? 0) + (afterRowCount - beforeRowCount))
        guard rowNum >= 0 && rowNum < afterRowCount else { return }
        scrollToRow(at: IndexPath(row: rowNum, section: 0), at: .top, animated: false)
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
//            fatalError("Unable Dequeue Reusable")
            printLog("👺👺👺👺👺👺 Unable Dequeue Reusable \(T.reuseIdentifier) for \(indexPath)")
            return T(style: .default, reuseIdentifier: T.reuseIdentifier)
        }
        return cell
    }
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
//            fatalError("Unable Dequeue Reusable")
            printLog("👺👺👺👺👺👺 Unable Dequeue Reusable \(T.reuseIdentifier)")
            return T(style: .default, reuseIdentifier: T.reuseIdentifier)
        }
        return cell
    }
}
