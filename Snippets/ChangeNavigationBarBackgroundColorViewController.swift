import UIKit

final class ChangeNavigationBarBackgroundColorViewController: UIViewController {

    @IBOutlet private weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "title blah blah"
        view.backgroundColor = .systemGreen
        setupNavBar()
    }

    private func setupNavBar() {
        updateBackgroundColor(CGFloat(slider.value))
    }

    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        print("\(sender.value)")
        updateBackgroundColor(CGFloat(sender.value))
    }

    private func updateBackgroundColor(_ alpha: CGFloat) {
        let backgroundColor = UIColor.red.withAlphaComponent(alpha)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = backgroundColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.barTintColor = backgroundColor
        
    }
}
