//
//  Extensions.swift
//  Confessions
//
//  Created by Enrique Avina on 8/21/22.
//

import Foundation
import SwiftUI



extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Int {

    var shortStringRepresentation: String {
        if self == 0 {
            return "0"
        }
        
        let units = ["", "k", "M"]
        var interval = Double(self)
        var i = 0
        while i < units.count - 1 {
            if abs(interval) < 1000.0 {
                break
            }
            i += 1
            interval /= 1000.0
        }
        // + 2 to have one digit after the comma, + 1 to not have any.
        // Remove the * and the number of digits argument to display all the digits after the comma.
        return "\(String(format: "%0.*g", Int(log10(abs(interval))) + 2, interval))\(units[i])"
    }
}

func randomString(of length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var s = ""
    for _ in 0 ..< length {
        s.append(letters.randomElement()!)
    }
    return s
}

extension Date {
    func timeFromNowString() -> String {
        let dateTransformed = self.addingTimeInterval(TimeInterval(60))
        let diffComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: Date.now, to: dateTransformed)
        
        guard let day = diffComponents.day else {
            print("error decoding time")
            return ""
        }
        
        if day > 0 {
            if day == 1 {
                return "1 day"
            } else {
                return "\(day) days"
            }
        }
        
        guard let hour = diffComponents.hour else {
            print("error decoding time")
            return ""
        }
        
        if hour > 0 {
            if hour == 1 {
                return "1 hour"
            } else {
                return "\(hour) hours"
            }
        }
        
        guard let minute = diffComponents.minute else {
            print("error decoding time")
            return ""
        }
        
        if minute == 1 {
            return "1 minute"
        } else {
            return "\(minute) mins"
        }
    }
}
