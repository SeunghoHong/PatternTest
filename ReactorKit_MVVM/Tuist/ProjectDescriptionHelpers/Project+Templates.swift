import ProjectDescription


public extension TargetDependency {
    static let alamofire: TargetDependency = .package(product: "Alamofire")
    static let kingfisher: TargetDependency = .package(product: "Kingfisher")
    static let rxSwift: TargetDependency = .package(product: "RxSwift")
    static let rxCocoa: TargetDependency = .package(product: "RxCocoa")
    static let reactorKit: TargetDependency = .package(product: "ReactorKit")
    static let snapKit: TargetDependency = .package(product: "SnapKit")
    static let pinLayout: TargetDependency = .package(product: "PinLayout")
    static let flexLayout: TargetDependency = .package(product: "FlexLayout")
    static let flexLayoutYoga: TargetDependency = .package(product: "FlexLayoutYoga")
    static let flexLayoutYogaKit: TargetDependency = .package(product: "FlexLayoutYogaKit")
}


public extension Package {
    static let alamofire: Package = .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.0.0")
    static let kingfisher: Package = .package(url: "https://github.com/onevcat/Kingfisher.git", from: "6.0.0")
    static let rxSwift: Package = .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0")
    static let reactorKit: Package = .package(url: "https://github.com/ReactorKit/ReactorKit.git", from: "3.0.0")
    static let snapKit: Package = .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0")
    static let pinLayout: Package = .package(url: "https://github.com/layoutBox/PinLayout.git", .upToNextMajor(from: "1.10.0"))
    static let flexLayout: Package = .package(url: "https://github.com/layoutBox/FlexLayout.git", .upToNextMajor(from: "1.3.0"))
}


extension Project {

    public static func app(
        name: String,
        platform: Platform
    ) -> Project {
        let targets = makeAppTargets(
            name: name,
            platform: platform,
            dependencies: [
                .alamofire,
                .kingfisher,
                .rxSwift,
                .rxCocoa,
                .reactorKit,
                .snapKit,
                .pinLayout,
                .flexLayout,
                .flexLayoutYoga,
                .flexLayoutYogaKit
            ]
        )

        return Project(
            name: name,
            organizationName: "raymond",
            packages: [
                .alamofire,
                .kingfisher,
                .rxSwift,
                .reactorKit,
                .snapKit,
                .pinLayout,
                .flexLayout,
            ],
            targets: targets
        )
    }
}


extension Project {

    private static func makeFrameworkTargets(
        name: String,
        platform: Platform
    ) -> [Target] {
        let sources = Target(
            name: name,
            platform: platform,
            product: .framework,
            bundleId: "com.raymond.\(name)",
            infoPlist: .default,
            sources: ["\(name)/Sources/**"],
            resources: [],
            dependencies: []
        )

        let tests = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "com.raymond.\(name)Tests",
            infoPlist: .default,
            sources: ["\(name)/Tests/**"],
            resources: [],
            dependencies: [.target(name: name)]
        )

        return [sources, tests]
    }

    private static func makeAppTargets(
        name: String,
        platform: Platform,
        dependencies: [TargetDependency]
    ) -> [Target] {
        let platform: Platform = platform
        let infoPlist: [String : InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
         ]

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "com.raymond.\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["\(name)/Sources/**"],
            resources: ["\(name)/Resources/**"],
            dependencies: dependencies,
            settings: Settings.settings(configurations: [
                .debug(
                    name: "Debug",
                    settings: [
                        "GCC_PREPROCESSOR_DEFINITIONS" : ["DEBUG=1", "FLEXLAYOUT_SWIFT_PACKAGE=1"]
                    ]
                ),
                .release(
                    name: "Release",
                    settings: [
                        "GCC_PREPROCESSOR_DEFINITIONS" : ["FLEXLAYOUT_SWIFT_PACKAGE=1"]
                    ]
                )
            ])
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "com.raymond.\(name)Tests",
            infoPlist: .default,
            sources: ["\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ]
        )

        return [mainTarget, testTarget]
    }
}
