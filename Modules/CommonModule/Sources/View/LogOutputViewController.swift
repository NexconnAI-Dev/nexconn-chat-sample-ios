import UIKit

open class LogOutputViewController: UIViewController {
    private let stackView = UIStackView()
    private let textView = UITextView()

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }

    public func addActionButton(title: String, action: Selector) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: action, for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stackView.insertArrangedSubview(button, at: max(stackView.arrangedSubviews.count - 1, 0))
    }

    public func appendLog(_ message: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let line = "[\(formatter.string(from: Date()))] \(message)\n"
        DispatchQueue.main.async {
            self.textView.text += line
            guard !self.textView.text.isEmpty else { return }
            let range = NSRange(location: self.textView.text.count - 1, length: 1)
            self.textView.scrollRangeToVisible(range)
        }
    }

    private func setupLayout() {
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        textView.isEditable = false
        textView.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 8
        textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 280).isActive = true
        stackView.addArrangedSubview(textView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
