import UIKit

final class ChangeNavigationBarBackgroundColorViewController: UIViewController {

    @IBOutlet private weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "title blah blah"
        view.backgroundColor = .systemGreen
        updateBackgroundColor(CGFloat(slider.value))
    }

    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        updateBackgroundColor(CGFloat(sender.value))
    }

    private func updateBackgroundColor(_ alpha: CGFloat) {
        let backgroundColor = UIColor.red.withAlphaComponent(alpha)
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
//        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.backgroundColor = backgroundColor
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.barTintColor = backgroundColor
        
    }
}
