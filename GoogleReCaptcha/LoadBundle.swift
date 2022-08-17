//
//  LoadBundle.swift
//  GoogleReCaptcha
//
//  Created by SV59349 on 17/08/22.
//

import UIKit

public class LoadBundle {
    public static func bundle(view: AnyClass) -> Bundle {
        let bundle = Bundle(for: view)
        guard let cocoapodsBundle = bundle
                .path(forResource: "GoogleReCaptcha", ofType: "bundle")
                .flatMap(Bundle.init(path:)) else {
                    return bundle
                }
        return cocoapodsBundle
    }
}
