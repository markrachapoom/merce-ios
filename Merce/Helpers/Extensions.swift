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
    
    
    /// Average color of the image, nil if it cannot be found
    var averageColor: UIColor? {
        // convert our image to a Core Image Image
        guard let inputImage = CIImage(image: self) else { return nil }
        
        // Create an extent vector (a frame with width and height of our current input image)
        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)
        
        // create a CIAreaAverage filter, this will allow us to pull the average color from the image later on
        guard let filter = CIFilter(name: "CIAreaAverage",
                                    parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        // A bitmap consisting of (r, g, b, a) value
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        
        // Render our output image into a 1 by 1 image supplying it our bitmap to update the values of (i.e the rgba of the 1 by 1 image will fill out bitmap array
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)
        
        // Convert our bitmap images of r, g, b, a to a UIColor
        return UIColor(red: CGFloat(bitmap[0]) / 255,
                       green: CGFloat(bitmap[1]) / 255,
                       blue: CGFloat(bitmap[2]) / 255,
                       alpha: CGFloat(bitmap[3]) / 255)
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



