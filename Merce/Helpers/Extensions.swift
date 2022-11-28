//
//  Extensions.swift
//  DiaryDingo
//
//  Created by Mark Rachapoom on 10/15/21.
//

import SwiftUI
import AVFoundation

// MARK: - COLOR
extension Color {
    
    enum COLOR_LEVEL {
        case primary
        case secondary
        case tertiary
    }
    
    enum COLOR_TYPE {
        case background
        case text
    }
    
    // 2 Modes colors
    static let srdpBackground = Color("SRDPBackground")
    
    static let lightBlue = Color("light-blue")
    
    // Single Colors
    static let dingoBlack = Color("black")
    static let dingoWhite = Color("white")
    static let dingoBrown = Color("brown")
    
    // Alert
    static let dingoRed = Color("red")
    static let dingoYellow = Color("yellow")
    static let dingoGreen = Color("green")
    static let dingoPurple = Color("love")
    static let dingoOrange = Color("happy")
    
    // Twitter
    static let twitterBlue = Color("twitter-blue")
    
    // Instagram
    static let instagramPurple = Color("instagram-purple")
    static let instagramRed = Color("instagram-red")
    static let instagramOrange = Color("instagram-orange")
    
    // Snapchat
    static let snapchatYellow = Color("snapchat-yellow")
    
    // Facebook
    static let facebookBlue = Color("facebook-blue")
    
    static let secondaryBackgroundColor = Color("secondary-background-color")
    
    /*
     export const lightColors = {
         accent: "#0025F5",
         // accent: "#0025F5",
         appleBlue: '#007AFF', // blue
         divider: '#3C3C4333',
         blue: '#007AFF',
         red: '#FF3B30',
         pink: '#FF2D55',
         green: "#34C759",
         orange: {
           border: '#FF9F0A',
           background: '#FFE2B6',
         },
         background: {
           primary: '#FFFFFF', // white
           secondary: '#F2F2F7',
           // secondary: "#F6F6F6",
           tertiary: '#00000002',
           border: '#E2E8F0',
         },
         text: {
           primary: '#000000', // black
           secondary: '#3C3C4360',
           tertiary: '#3C3C4333',
         },
       };
       
       export const darkColors = {
         accent: "#0025F5",
         // accent: "#0025F5",
         appleBlue: '#0A84FF', // blue
         divider: "#54545870",
         blue: '#0A84FF',
         red: '#FF453A',
         pink: '#FF375F',
         green: "#32D74B",
         orange: {
           border: '#FF9F0A',
           background: '#4D3003',
         },
         background: {
           primary: '#000000', // black
           // primary: "#121212",
           // secondary: '#242428',
           secondary: "#1C1B1B",
           tertiary: '#2C2C2E',
           border: '#ffffff29',
         },
         text: {
           primary: '#FFFFFF', // white
           secondary: '#EBEBF560',
           tertiary: '#EBEBF530',
         },
       };
     */
    
}

// MARK: - UIIMAGE
extension UIImage {
    
    func resizeSquareImage(newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}

// MARK: - ANIMATION

extension Animation {
    static let interactiveSpring = Animation.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)
    static let popupAnimation = Animation.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.8)
    static let actionSheetSpring = Animation.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.8)
}

// MARK: - TEXT

extension Text {
    public func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint) -> some View
    {
        self.overlay {
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self
            )
        }
    }
}


// MARK: - FONT
extension Font {
    
    // WEIGHT
    public enum FontWeight: String {
        case thin = "Poppins-Thin"
        case light = "Poppins-Light"
        case regular = "Poppins-Regular"
        case medium = "Poppins-Medium"
        case bold = "Poppins-Bold"
        case semiBold = "Poppins-SemiBold"
        case extraBold = "Poppins-ExtraBold"
        case black = "Poppins-Black"
    }
    
    // POPPINS FONT
    static public func poppins(size: CGFloat, weight: FontWeight) -> Font {
        return .custom(weight.rawValue, size: size)
    }
    
    static public func navigationInlineTitle() -> Font {
        return .system(.body, design: .default, weight: .semibold)
    }
}

extension View {
    // Conditional View Modifier
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
    
    func checkArea(color: Color = .dingoGreen) -> some View {
        return self.background(color.opacity(0.75))
    }
    
    // Shadow for Dark and Light mode
    func shadow() -> some View {
        self.shadow(color: .accentColor.opacity(0.05), radius: 8.0, x: 0.0, y: 4.0)
    }
}


// MARK: - STRING

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func trimAndLowercase() -> String {
        return self.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func removeSpecialCharsFromString() -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return self.filter {okayChars.contains($0) }
    }
}

// MARK: - DATE

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}


extension Calendar {
    func numberOfDayBetween(_ start: Date, and end: Date) -> Int {
        let startDate = startOfDay(for: start)
        let endDate = startOfDay(for: end)
        let numberOfDays = dateComponents([.day], from: startDate, to: endDate)
        
        return numberOfDays.day ?? 0
    }
}


extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}

// MARK: JSON - BUNDLE
extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) in the project")
        }
        
        return loadedData
    }
}


// MARK: For Core Data

extension URL {
    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}


// MARK: AVAUDIO

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}


