/**
 This component is available in the following variants:
    - ✅ Standard
    - ✅ Dot
    - ✅ Pulse
 
 With the following attributes:
    - Color:
        - ✅ `Alert`
        - ✅ `Primary`
        - ✅ `Secondary`
        - ✅ `Success`
    - Limit:
        - ✅ `max9`
        - ✅ `max99`
        - ✅ `unlimited`
 
 NatBadge is a class that represents a component from the Design System.
 
 The badge colors change according to the current brand configured in the Design System.
 They also change according to the user's properties of Light and Dark mode.
 
 NatBadge has three variants: `standard`, `dot` and `pulse`.
 It can be configured with colors `alert`, `primary`, `secondary` and `success`.
 
 Example of usage:
 
        let badge = NatBadge(style: .standard, color: .alert)
        badge.configure(limit: .unlimited)
 
 - Requires:
 It's necessary to configure the Design System with a theme or fatalError will be raised.
 
        DesignSystem().configure(with: AvailableTheme)
*/

public final class NatBadge: UIView {

    // MARK: - Private properties

    internal var centerCircleLayer = CAShapeLayer()
    internal var backgroundCircleLayer = CAShapeLayer()
    internal var circleLayerContainer = CAShapeLayer()

    private let style: Style
    private let color: Color
    private var value = 0
    private var limit: Limit = .unlimited {
        didSet {
            configure(count: value)
        }
    }

    private var shouldAppear: Bool {
        return (style != .standard || (style == .standard && value > 0))
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = NatFonts.font(ofSize: getComponentAttributeFromTheme(\.badgeLabelFontSize),
                                   withWeight: getComponentAttributeFromTheme(\.badgeLabelPrimaryFontWeight),
                                   withFamily: getComponentAttributeFromTheme(\.badgeLabelPrimaryFontFamily))
        label.textColor = color.content
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Inits

    public init(style: Style, color: Color) {
        self.style = style
        self.color = color
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setup() {
        backgroundColor = .clear
        addConstraintsFor(style: style)
    }

    private func addConstraintsFor(style: NatBadge.Style) {
        translatesAutoresizingMaskIntoConstraints = false

        let heightConstraint = heightAnchor.constraint(equalToConstant: style.height)
        let widthConstraint = widthAnchor.constraint(equalToConstant: style.height)
        var constraints: [NSLayoutConstraint] = [heightConstraint, widthConstraint]

        if style == .standard {
            addSubview(label)
            widthConstraint.priority = .defaultLow
            constraints = [
                heightConstraint,
                widthConstraint,
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: style.borderRadius/2),
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -style.borderRadius/2),
                label.topAnchor.constraint(equalTo: topAnchor),
                label.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        }

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - UI methods

    override public func draw(_ rect: CGRect) {
        let path: UIBezierPath?

        if style == .pulse {
            drawPulse()
            scaleAnimation()
            opacityAnimation()
            centerCircleLayer.fillColor = color.box.cgColor
            backgroundCircleLayer.fillColor = color.box.withAlphaComponent(getTokenFromTheme(\.opacityMedium)).cgColor
        } else {
            path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: bounds.size),
                                cornerRadius: style.borderRadius)
            color.box.set()
            path?.fill()
        }
    }

    // MARK: - Internal methods

    internal func addToView(_ view: UIView) {
        if let existingBadge = view.subviews.compactMap({
            $0 as? NatBadge
        }).first {
            existingBadge.removeFromSuperview()
        }

        if shouldAppear {
            view.addSubview(self)
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            topAnchor.constraint(equalTo: view.topAnchor, constant: 0.1).isActive = true
        }
    }

    // MARK: - Public methods

    public func configure(count: Int) {
        value = count
        isHidden = count <= 0

        if count <= 0 {
            label.text = nil
            return
        }

        guard let maxValue = limit.maxValue else {
            label.text = "\(count)"
            return
        }

        if count <= maxValue {
            label.text = "\(count)"
        } else {
            label.text = limit.text
        }
    }

    public func configure(limit: Limit) {
        self.limit = limit
    }
}
