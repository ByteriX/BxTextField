// swift-tools-version: 5.4
/**
 *	@file Package.swift
 *	@namespace BxTextField
 *
 *	@details Swift packege manager file
 *	@date 02.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxTextField.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import PackageDescription

let package = Package(
    name: "BxTextField",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BxTextField",
            targets: ["BxTextField"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        //
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BxTextField",
            dependencies: [],
            path: "BxTextField/Source"),
//        .testTarget(
//            name: "BxTextFieldTests",
//            dependencies: ["BxTextField"]),
//        .testTarget(
//            name: "BxTextFieldUITests",
//            dependencies: ["BxTextField"]),
    ],
    swiftLanguageVersions: [.v5]
)
