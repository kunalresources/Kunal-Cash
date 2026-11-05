import UIKit

enum CliffImageShave {
    static func pineJPEG(from image: UIImage) -> Data? {
        guard let scaled = birchScaled(image) else { return nil }
        var quality: CGFloat = 0.92
        var data = scaled.jpegData(compressionQuality: quality)
        while let d = data, d.count > 600_000, quality > 0.06 {
            quality -= 0.07
            data = scaled.jpegData(compressionQuality: quality)
        }
        if let d = data, d.count <= 600_000 { return d }
        return creekShrink(scaled)
    }

    private static func birchScaled(_ image: UIImage) -> UIImage? {
        var w = image.size.width * image.scale
        var h = image.size.height * image.scale
        var longSide = max(w, h)
        var shortSide = min(w, h)
        var didChange = false
        if longSide > 6000 {
            let s = 6000 / longSide
            w *= s
            h *= s
            longSide = max(w, h)
            shortSide = min(w, h)
            didChange = true
        }
        if shortSide < 128 {
            let s = 128 / shortSide
            w *= s
            h *= s
            longSide = max(w, h)
            if longSide > 6000 {
                let t = 6000 / longSide
                w *= t
                h *= t
            }
            didChange = true
        }
        if !didChange { return image }
        let size = CGSize(width: max(1, floor(w)), height: max(1, floor(h)))
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }

    private static func creekShrink(_ image: UIImage) -> Data? {
        var factor: CGFloat = 0.92
        var img = image
        while factor > 0.2 {
            let s = CGSize(width: max(128, img.size.width * factor), height: max(128, img.size.height * factor))
            let format = UIGraphicsImageRendererFormat.default()
            format.scale = 1
            let renderer = UIGraphicsImageRenderer(size: s, format: format)
            img = renderer.image { _ in img.draw(in: CGRect(origin: .zero, size: s)) }
            if let d = img.jpegData(compressionQuality: 0.72), d.count <= 600_000 { return d }
            factor -= 0.06
        }
        return img.jpegData(compressionQuality: 0.5)
    }
}
