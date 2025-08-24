import SwiftUI

struct CurvedShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let curveHeight: CGFloat = 30

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.midX - 35, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.midX + 35, y: 0),
                          control: CGPoint(x: rect.midX, y: -curveHeight))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}
