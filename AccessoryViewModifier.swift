
extension View {
    @ContentBuilder
    func accessoryView<V: View>(@ContentBuilder _ view: @escaping () -> V)
        -> some View
    {
        self
            .modifier(
                AccessoryViewModifier(accessoryView: view)
            )
    }
}

struct AccessoryViewModifier<V: View>: ViewModifier {
    @ContentBuilder var accessoryView: () -> V

    func body(content: Content) -> some View {
        content
            .background {
                WindowAccessor(onWindow: self.setupAccessoryView(for:))
            }
    }

    private func setupAccessoryView(for window: NSWindow) {
        // Prevent duplicate injections
        guard window.titlebarAccessoryViewControllers.isEmpty else { return }

        let accessoryVC = NSTitlebarAccessoryViewController()

        let hostingView = NSHostingView(rootView: accessoryView())

        accessoryVC.view = hostingView
        // Match the hosting view frame to the desired height
        // NOTE that setting it directly on like below has no effect.
        // WRONG: hostingView.frame.size = CGSize(width: window.frame.width, height: 100)
        accessoryVC.view.frame.size = hostingView.fittingSize

        // `bottom` to Position the accessory view below the standard titlebar/toolbar
        accessoryVC.layoutAttribute = .bottom

        window.addTitlebarAccessoryViewController(accessoryVC)
    }
}

struct WindowAccessor: NSViewRepresentable {
    let onWindow: (NSWindow) -> Void

    func makeNSView(context: Context) -> WindowAccessorView {
        let view = WindowAccessorView(onWindow: onWindow)
        return view
    }

    func updateNSView(_ nsView: WindowAccessorView, context: Context) {}

    // Subclassing NSView to override viewDidMoveToWindow
    class WindowAccessorView: NSView {
        let onWindow: (NSWindow) -> Void

        init(onWindow: @escaping (NSWindow) -> Void) {
            self.onWindow = onWindow
            super.init(frame: .zero)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()
            guard let window = self.window else {
                return
            }
            self.onWindow(window)
        }
    }
}
