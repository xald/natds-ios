import NatDS
import UIKit

final class RadioButtonViewController: UIViewController, SampleItem {

    static let name = "RadioButton"

    // MARK: - Private properties

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = NatSpacing.tiny
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let groupStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = NatSpacing.tiny
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let groupFirstRadioButton: NatRadioButton = {
        let radioButton = NatRadioButton()
        radioButton.configure(isSelected: true)
        radioButton.configure(text: "Button 1")
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private let groupSecondRadioButton: NatRadioButton = {
        let radioButton = NatRadioButton()
        radioButton.configure(text: "Button 2")
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private let groupThirdRadioButton: NatRadioButton = {
        let radioButton = NatRadioButton()
        radioButton.configure(text: "Button 3")
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private let enabledUnselectedRadioButton: NatRadioButton = {
        let radioButton = NatRadioButton()
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private let enabledSelectedRadioButton: NatRadioButton = {
        let radioButton = NatRadioButton()
        radioButton.configure(isSelected: true)
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private let disabledUnselectedRadioButton: NatRadioButton = {
        let radioButton = NatRadioButton()
        radioButton.configure(isSelected: false)
        radioButton.configure(isEnabled: false)
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private let disabledSelectedRadioButton: NatRadioButton = {
        let radioButton = NatRadioButton()
        radioButton.configure(isSelected: true)
        radioButton.configure(isEnabled: false)
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private let enabledUnselectedLabelRadioButton: NatRadioButton = {
        let radioButton = NatRadioButton()
        radioButton.configure(text: "Enabled unselected with label")
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private let enabledSelectedLabelRadioButton: NatRadioButton = {

        let radioButton = NatRadioButton()
        radioButton.configure(text: "Enabled selected with label")
        radioButton.configure(isSelected: true)
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private let disabledUnselectedLabelRadioButton: NatRadioButton = {
        let radioButton = NatRadioButton()
        radioButton.configure(text: "Disabled unselected with label")
        radioButton.configure(isSelected: false)
        radioButton.configure(isEnabled: false)
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private let disabledSelectedLabelRadioButton: NatRadioButton = {
        let radioButton = NatRadioButton()
        radioButton.configure(text: "Disabled selected with label")
        radioButton.configure(isSelected: true)
        radioButton.configure(isEnabled: false)
        radioButton.translatesAutoresizingMaskIntoConstraints = false

        return radioButton
    }()

    private lazy var radioButtonGroup: NatRadioButtonGroup = {
        let group = NatRadioButtonGroup()
        group.configure(radioButtons: [groupFirstRadioButton, groupSecondRadioButton, groupThirdRadioButton])
        return group
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHandlers()
    }

    // MARK: - Private methods

    private func setup() {
        title = Self.name
        view.backgroundColor = NatColors.background
        view.addSubview(scrollView)

        scrollView.addSubview(containerView)
        containerView.addSubview(groupStackView)
        containerView.addSubview(stackView)

        groupStackView.addArrangedSubview(groupFirstRadioButton)
        groupStackView.addArrangedSubview(groupSecondRadioButton)
        groupStackView.addArrangedSubview(groupThirdRadioButton)

        stackView.addArrangedSubview(enabledUnselectedRadioButton)
        stackView.addArrangedSubview(enabledSelectedRadioButton)
        stackView.addArrangedSubview(disabledUnselectedRadioButton)
        stackView.addArrangedSubview(disabledSelectedRadioButton)
        stackView.addArrangedSubview(enabledUnselectedLabelRadioButton)
        stackView.addArrangedSubview(enabledSelectedLabelRadioButton)
        stackView.addArrangedSubview(disabledUnselectedLabelRadioButton)
        stackView.addArrangedSubview(disabledSelectedLabelRadioButton)

        addConstraints()
    }
}

extension RadioButtonViewController {

    private func addConstraints() {
        let containerHeightConstraint = containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        containerHeightConstraint.priority = .defaultLow

        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -NatSpacing.small),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: NatSpacing.small),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerHeightConstraint,

            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: NatSpacing.small),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),

            groupStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: NatSpacing.small),
            groupStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            groupStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupHandlers() {
        enabledUnselectedRadioButton.configure { isChecked in
            let alert = UIAlertController(title: "Taps",
                                          message: "It's marked as \(isChecked)",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        radioButtonGroup.configure(selectionHandler: { [weak self] selectedRadioButton in
            let selectedGroupButtonName = self?.getSelectedGroupButtonName(selectedButton: selectedRadioButton) ?? ""

            let alert = UIAlertController(title: "Taps",
                                          message: "Selected \(selectedGroupButtonName)",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            self?.present(alert, animated: true, completion: nil)
        })
    }

    private func getSelectedGroupButtonName(selectedButton: NatRadioButton?) -> String? {
        if selectedButton == groupFirstRadioButton {
            return "Group button 1"
        } else if selectedButton == groupSecondRadioButton {
            return "Group button 2"
        } else if selectedButton == groupThirdRadioButton {
            return "Group button 3"
        } else {
            return nil
        }
    }
 }
