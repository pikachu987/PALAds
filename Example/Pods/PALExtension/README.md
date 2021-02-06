# PALExtension

[![CI Status](https://img.shields.io/travis/pikachu987/PALExtension.svg?style=flat)](https://travis-ci.org/pikachu987/PALExtension)
[![Version](https://img.shields.io/cocoapods/v/PALExtension.svg?style=flat)](https://cocoapods.org/pods/PALExtension)
[![License](https://img.shields.io/cocoapods/l/PALExtension.svg?style=flat)](https://cocoapods.org/pods/PALExtension)
[![Platform](https://img.shields.io/cocoapods/p/PALExtension.svg?style=flat)](https://cocoapods.org/pods/PALExtension)
![](https://img.shields.io/badge/Supported-iOS9%20%7C%20OSX%2010.9-4BC51D.svg?style=flat-square)
![](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PALExtension is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PALExtension'
```

## Method

```swift
--------------------------------------------------
[Array+] - jsonStringify

[1,2,3,4]

[
  {
    "b" : "test2",
    "a" : "test"
  },
  {
    "a" : "test",
    "b" : "test2"
  },
  {
    "a" : "test",
    "b" : "test2"
  }
]
--------------------------------------------------

--------------------------------------------------
[CGFloat+] - CGFloat.minimum

1e-08
--------------------------------------------------

--------------------------------------------------
[CGFloat+] - CGFloat(180).degreesToRadians

3.141592653589793
--------------------------------------------------

--------------------------------------------------
[CGFloat+] - CGFloat(180).radiansToDegrees

10313.240312354817
--------------------------------------------------

--------------------------------------------------
[CGFloat+] - CGFloat(-50).abs

50.0
--------------------------------------------------

--------------------------------------------------
[CGFloat+] - CGFloat(32134443231).priceComma

32,134,440,000
--------------------------------------------------

--------------------------------------------------
[CGFloat+] - CGFloat(3213444323331).storage

3.2 TB
--------------------------------------------------

--------------------------------------------------
[CGFloat+] - CGFloat(3213444323331).storage(decimal: 2)

3.2134 TB
--------------------------------------------------

--------------------------------------------------
[Date+] - Date(milliseconds: 1478307201053)

2016-11-05 00:53:21 +0000
--------------------------------------------------

--------------------------------------------------
[Date+] - Date(milliseconds: 0)

1970-01-01 00:00:00 +0000
--------------------------------------------------

--------------------------------------------------
[Date+] - Date().dateTuple

(year: "2021", month: "01", day: "17", hour: "21", minute: "16", second: "05")
--------------------------------------------------

--------------------------------------------------
[Date+] - Date().dateTupleInt

(year: Optional(2021), month: Optional(1), day: Optional(17), hour: Optional(21), minute: Optional(16), second: Optional(5))
--------------------------------------------------

--------------------------------------------------
[Date+] - Date().timeZoneDate

2021-01-17 21:16:05 +0000
--------------------------------------------------

--------------------------------------------------
[Date+] - Date().timeZoneRevertDate

2021-01-17 03:16:05 +0000
--------------------------------------------------

--------------------------------------------------
[Date+] - Date().getDate()

2021-01-17
--------------------------------------------------

--------------------------------------------------
[Date+] - Date().getTime()

21:16:05
--------------------------------------------------

--------------------------------------------------
[Date+] - Date().betweenDays(Date(timeIntervalSince1970: 1478307201053))

17091392
--------------------------------------------------

--------------------------------------------------
[Date+] - Date().equalYear(Date(timeIntervalSince1970: 1478307201053))

false
--------------------------------------------------

--------------------------------------------------
[Date+] - Date().equalMonth(Date(timeIntervalSince1970: 1478307201053))

false
--------------------------------------------------

--------------------------------------------------
[Date+] - Date().equalDay(Date(timeIntervalSince1970: 1478307201053))

false
--------------------------------------------------

--------------------------------------------------
[Date+] - Date.format("2020-02-01 09:30:21", format: "yyyy-MM-dd HH:mm:SS")

2020-02-01 00:30:00 +0000
--------------------------------------------------

--------------------------------------------------
[Dictionary+] - jsonStringify

{"b":"test2","a":"test"}
{
  "a" : "test",
  "b" : "test2"
}
--------------------------------------------------

--------------------------------------------------
[Double+] - Double(90).degreesToRadians

1.5707963267948966
--------------------------------------------------

--------------------------------------------------
[Double+] - Double(90).radiansToDegrees

5156.620156177409
--------------------------------------------------

--------------------------------------------------
[Double+] - Double(-90).abs

90.0
--------------------------------------------------

--------------------------------------------------
[Double+] - Double(2333333000000).priceComma

2,333,333,000,000
--------------------------------------------------

--------------------------------------------------
[Double+] - Double(2333333000000).storage

2.3 TB
--------------------------------------------------

--------------------------------------------------
[Double+] - Double(2333333000000).storage(decimal: 7)

2.3333330 TB
--------------------------------------------------

--------------------------------------------------
[Float+] - Float(90).degreesToRadians

1.5707963
--------------------------------------------------

--------------------------------------------------
[Float+] - Float(90).radiansToDegrees

5156.6206
--------------------------------------------------

--------------------------------------------------
[Float+] - Float(-90).abs

90.0
--------------------------------------------------

--------------------------------------------------
[Float+] - Float(2333333000000).priceComma

2,333,333,000,000
--------------------------------------------------

--------------------------------------------------
[Float+] - Float(2333333000000).storage

2.3 TB
--------------------------------------------------

--------------------------------------------------
[Float+] - Float(2333333000000).storage(decimal: 7)

2.3333330 TB
--------------------------------------------------

--------------------------------------------------
[Int+] - Int(90).degreesToRadians

1.5707963267948966
--------------------------------------------------

--------------------------------------------------
[Int+] - Int(90).radiansToDegrees

5156.620156177409
--------------------------------------------------

--------------------------------------------------
[Int+] - Int(-90).abs

90
--------------------------------------------------

--------------------------------------------------
[Int+] - Int(2333333000000).priceComma

2,333,333,000,000
--------------------------------------------------

--------------------------------------------------
[Int+] - Int(2333333000000).storage

2.3 TB
--------------------------------------------------

--------------------------------------------------
[Int+] - Int(2333333000000).storage(decimal: 7)

2.3333330 TB
--------------------------------------------------

--------------------------------------------------
[NSObject+] - self.classNameToString

PALExtension_Example.ViewController
--------------------------------------------------

--------------------------------------------------
[NSObject+] - UINavigationController.classNameToString

UINavigationController
--------------------------------------------------

--------------------------------------------------
[String+] - "가나다라test".euckrEncoding

%B0%A1%B3%AA%B4%D9%B6%F3test
--------------------------------------------------

--------------------------------------------------
[String+] - "test".localized

test
--------------------------------------------------

--------------------------------------------------
[String+] - "test".range

Index(_rawBits: 1)..<Index(_rawBits: 196865)
--------------------------------------------------

--------------------------------------------------
[String+] - "[1,2,3,4]".parseJSON

(
    1,
    2,
    3,
    4
)
--------------------------------------------------

--------------------------------------------------
[String+] - "{"a":"test","b":"test2"}".parseJSON

{
    a = test;
    b = test2;
}
--------------------------------------------------

--------------------------------------------------
[String+] - "test".base64Decoding

3 bytes
--------------------------------------------------

--------------------------------------------------
[String+] - "pikachu77769@gmail.com".isValidEmail

true
--------------------------------------------------

--------------------------------------------------
[String+] - "http://www.naver.com".isValidUrl

true
--------------------------------------------------

--------------------------------------------------
[String+] - "가나다".isValidKo

true
--------------------------------------------------

--------------------------------------------------
[String+] - "가나다test".isValidKo

true
--------------------------------------------------

--------------------------------------------------
[String+] - "test".localizedWithComment("comment")

test
--------------------------------------------------

--------------------------------------------------
[String+] - "test example".substring(from: 2)

st example
--------------------------------------------------

--------------------------------------------------
[String+] - "test example".substring(from: 2, to: 4)

st 
--------------------------------------------------

--------------------------------------------------
[String+] - "test example".substring(from: 2, length: 4)

st e
--------------------------------------------------

--------------------------------------------------
[String+] - "test example".nsRange("amp")

{7, 3}
--------------------------------------------------

--------------------------------------------------
[String+] - "12.3123123123333".decimalFormat

12.312312
--------------------------------------------------

--------------------------------------------------
[String+] - "12.3123123123333".decimalFormat(2)

12.31
--------------------------------------------------

--------------------------------------------------
[String+] - "2020-01-01 18:30:25".toDateString(inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "yyyy.MM.dd HH/mm/ss"

2020.01.01 18/30/25
--------------------------------------------------

--------------------------------------------------
[String+] - "39213.213.4355.349494".matches("[0-9]+")

["39213", "213", "4355", "349494"]
--------------------------------------------------

--------------------------------------------------
[String+] - "http://www.naver.com ~~!@!@#!#@!#@!#!@dsafifdsaoifd http://www.google.com adifsafajisdf".urlLink

http://www.naver.com
http://www.google.com
http://www.naver.com
--------------------------------------------------

--------------------------------------------------
[String+] - "01012341234".format([3, 4, 4], separator: "-")

010-1234-1234
--------------------------------------------------

--------------------------------------------------
[String+] - "3215498765".format([3, 2, 5], separator: "-")

321-54-98765
--------------------------------------------------

--------------------------------------------------
[String+] - "20200621".format([4, 2, 2], separator: ".")

2020.06.21
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor(light: .black, dark: .white))

<UIDynamicProviderColor: 0x60000361dd00; provider = <__NSMallocBlock__: 0x600003806550>>
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor(hex: 0xffffff)

UIExtendedSRGBColorSpace 1 1 1 1
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor(hexString: "ffffff")

UIExtendedSRGBColorSpace 1 1 1 1
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor.blue.red

0.0
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor.blue.green

0.0
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor.blue.blue

1.0
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor.blue.alpha

1.0
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor.blue.toHexString

0000FF
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor.blue.equal(color: .blue)

true
--------------------------------------------------

--------------------------------------------------
[UIDevice+] - UIDevice.deviceModelType

simulator
--------------------------------------------------

--------------------------------------------------
[UIDevice+] - UIDevice.deviceType

simulator
--------------------------------------------------

--------------------------------------------------
[UIDevice+] - UIDevice.deviceSimulatorModelType

iPhone12
--------------------------------------------------

--------------------------------------------------
[UIDevice+] - UIDevice.deviceSimulatorType

iPhone
--------------------------------------------------

--------------------------------------------------
[UIDevice+] - UIDevice.machineString

x86_64
--------------------------------------------------

--------------------------------------------------
[UIFont+] - UIFont.fontNames

["AcademyEngravedLetPlain", "AlNile", "AlNile-Bold", "AmericanTypewriter", "AmericanTypewriter-Light", "AmericanTypewriter-Semibold", "AmericanTypewriter-Bold", "AmericanTypewriter-Condensed", "AmericanTypewriter-CondensedLight", "AmericanTypewriter-CondensedBold", "AppleColorEmoji", "AppleSDGothicNeo-Regular", "AppleSDGothicNeo-Thin", "AppleSDGothicNeo-UltraLight", "AppleSDGothicNeo-Light", "AppleSDGothicNeo-Medium", "AppleSDGothicNeo-SemiBold", "AppleSDGothicNeo-Bold", "AppleSymbols", "ArialMT", "Arial-ItalicMT", "Arial-BoldMT", "Arial-BoldItalicMT", "ArialHebrew", "ArialHebrew-Light", "ArialHebrew-Bold", "ArialRoundedMTBold", "Avenir-Book", "Avenir-Roman", "Avenir-BookOblique", "Avenir-Oblique", "Avenir-Light", "Avenir-LightOblique", "Avenir-Medium", "Avenir-MediumOblique", "Avenir-Heavy", "Avenir-HeavyOblique", "Avenir-Black", "Avenir-BlackOblique", "AvenirNext-Regular", "AvenirNext-Italic", "AvenirNext-UltraLight", "AvenirNext-UltraLightItalic", "AvenirNext-Medium", "AvenirNext-MediumItalic", "AvenirNext-DemiBold", "AvenirNext-DemiBoldItalic", "AvenirNext-Bold", "AvenirNext-BoldItalic", "AvenirNext-Heavy", "AvenirNext-HeavyItalic", "AvenirNextCondensed-Regular", "AvenirNextCondensed-Italic", "AvenirNextCondensed-UltraLight", "AvenirNextCondensed-UltraLightItalic", "AvenirNextCondensed-Medium", "AvenirNextCondensed-MediumItalic", "AvenirNextCondensed-DemiBold", "AvenirNextCondensed-DemiBoldItalic", "AvenirNextCondensed-Bold", "AvenirNextCondensed-BoldItalic", "AvenirNextCondensed-Heavy", "AvenirNextCondensed-HeavyItalic", "Baskerville", "Baskerville-Italic", "Baskerville-SemiBold", "Baskerville-SemiBoldItalic", "Baskerville-Bold", "Baskerville-BoldItalic", "BodoniSvtyTwoITCTT-Book", "BodoniSvtyTwoITCTT-BookIta", "BodoniSvtyTwoITCTT-Bold", "BodoniSvtyTwoOSITCTT-Book", "BodoniSvtyTwoOSITCTT-BookIt", "BodoniSvtyTwoOSITCTT-Bold", "BodoniSvtyTwoSCITCTT-Book", "BodoniOrnamentsITCTT", "BradleyHandITCTT-Bold", "ChalkboardSE-Regular", "ChalkboardSE-Light", "ChalkboardSE-Bold", "Chalkduster", "Charter-Roman", "Charter-Italic", "Charter-Bold", "Charter-BoldItalic", "Charter-Black", "Charter-BlackItalic", "Cochin", "Cochin-Italic", "Cochin-Bold", "Cochin-BoldItalic", "Copperplate", "Copperplate-Light", "Copperplate-Bold", "Courier", "Courier-Oblique", "Courier-Bold", "Courier-BoldOblique", "CourierNewPSMT", "CourierNewPS-ItalicMT", "CourierNewPS-BoldMT", "CourierNewPS-BoldItalicMT", "Damascus", "DamascusLight", "DamascusMedium", "DamascusSemiBold", "DamascusBold", "DevanagariSangamMN", "DevanagariSangamMN-Bold", "Didot", "Didot-Italic", "Didot-Bold", "DINAlternate-Bold", "DINCondensed-Bold", "EuphemiaUCAS", "EuphemiaUCAS-Italic", "EuphemiaUCAS-Bold", "Farah", "Futura-Medium", "Futura-MediumItalic", "Futura-Bold", "Futura-CondensedMedium", "Futura-CondensedExtraBold", "Galvji", "Galvji-Bold", "GeezaPro", "GeezaPro-Bold", "Georgia", "Georgia-Italic", "Georgia-Bold", "Georgia-BoldItalic", "GillSans", "GillSans-Italic", "GillSans-Light", "GillSans-LightItalic", "GillSans-SemiBold", "GillSans-SemiBoldItalic", "GillSans-Bold", "GillSans-BoldItalic", "GillSans-UltraBold", "GranthaSangamMN-Regular", "GranthaSangamMN-Bold", "Helvetica", "Helvetica-Oblique", "Helvetica-Light", "Helvetica-LightOblique", "Helvetica-Bold", "Helvetica-BoldOblique", "HelveticaNeue", "HelveticaNeue-Italic", "HelveticaNeue-UltraLight", "HelveticaNeue-UltraLightItalic", "HelveticaNeue-Thin", "HelveticaNeue-ThinItalic", "HelveticaNeue-Light", "HelveticaNeue-LightItalic", "HelveticaNeue-Medium", "HelveticaNeue-MediumItalic", "HelveticaNeue-Bold", "HelveticaNeue-BoldItalic", "HelveticaNeue-CondensedBold", "HelveticaNeue-CondensedBlack", "HiraMaruProN-W4", "HiraMinProN-W3", "HiraMinProN-W6", "HiraginoSans-W3", "HiraginoSans-W6", "HiraginoSans-W7", "HoeflerText-Regular", "HoeflerText-Italic", "HoeflerText-Black", "HoeflerText-BlackItalic", "Kailasa", "Kailasa-Bold", "Kefa-Regular", "KhmerSangamMN", "KohinoorBangla-Regular", "KohinoorBangla-Light", "KohinoorBangla-Semibold", "KohinoorDevanagari-Regular", "KohinoorDevanagari-Light", "KohinoorDevanagari-Semibold", "KohinoorGujarati-Regular", "KohinoorGujarati-Light", "KohinoorGujarati-Bold", "KohinoorTelugu-Regular", "KohinoorTelugu-Light", "KohinoorTelugu-Medium", "LaoSangamMN", "MalayalamSangamMN", "MalayalamSangamMN-Bold", "MarkerFelt-Thin", "MarkerFelt-Wide", "Menlo-Regular", "Menlo-Italic", "Menlo-Bold", "Menlo-BoldItalic", "DiwanMishafi", "MuktaMahee-Regular", "MuktaMahee-Light", "MuktaMahee-Bold", "MyanmarSangamMN", "MyanmarSangamMN-Bold", "Noteworthy-Light", "Noteworthy-Bold", "NotoNastaliqUrdu", "NotoNastaliqUrdu-Bold", "NotoSansKannada-Regular", "NotoSansKannada-Light", "NotoSansKannada-Bold", "NotoSansMyanmar-Regular", "NotoSansMyanmar-Light", "NotoSansMyanmar-Bold", "NotoSansOriya", "NotoSansOriya-Bold", "Optima-Regular", "Optima-Italic", "Optima-Bold", "Optima-BoldItalic", "Optima-ExtraBlack", "Palatino-Roman", "Palatino-Italic", "Palatino-Bold", "Palatino-BoldItalic", "Papyrus", "Papyrus-Condensed", "PartyLetPlain", "PingFangHK-Regular", "PingFangHK-Ultralight", "PingFangHK-Thin", "PingFangHK-Light", "PingFangHK-Medium", "PingFangHK-Semibold", "PingFangSC-Regular", "PingFangSC-Ultralight", "PingFangSC-Thin", "PingFangSC-Light", "PingFangSC-Medium", "PingFangSC-Semibold", "PingFangTC-Regular", "PingFangTC-Ultralight", "PingFangTC-Thin", "PingFangTC-Light", "PingFangTC-Medium", "PingFangTC-Semibold", "Rockwell-Regular", "Rockwell-Italic", "Rockwell-Bold", "Rockwell-BoldItalic", "SavoyeLetPlain", "SinhalaSangamMN", "SinhalaSangamMN-Bold", "SnellRoundhand", "SnellRoundhand-Bold", "SnellRoundhand-Black", "Symbol", "TamilSangamMN", "TamilSangamMN-Bold", "Thonburi", "Thonburi-Light", "Thonburi-Bold", "TimesNewRomanPSMT", "TimesNewRomanPS-ItalicMT", "TimesNewRomanPS-BoldMT", "TimesNewRomanPS-BoldItalicMT", "TrebuchetMS", "TrebuchetMS-Italic", "TrebuchetMS-Bold", "Trebuchet-BoldItalic", "Verdana", "Verdana-Italic", "Verdana-Bold", "Verdana-BoldItalic", "ZapfDingbatsITC", "Zapfino"]
--------------------------------------------------

--------------------------------------------------
[UIFont+] - UIFont.semiBoldSystemFont(ofSize: 17)

<UICTFont: 0x7fb025d21f30> font-family: ".SFUI-Semibold"; font-weight: bold; font-style: normal; font-size: 17.00pt
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor.red.image(CGSize(width: 100, height: 50)

<UIImage:0x600000454b40 anonymous {100, 50}>
--------------------------------------------------

--------------------------------------------------
[UIImageView+] - self.imageView.imageFrame

(0.0, 55.99173553719008, 200.0, 88.01652892561984)
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor.red.hsv

HSV(hue: 0.0, saturation: 1.0, value: 1.0)
--------------------------------------------------

--------------------------------------------------
[UIColor+] - UIColor.red.hsv.rgb

UIExtendedSRGBColorSpace 0.392157 0.588235 0.784314 1
0.39215686274509803
0.7843137254901961
0.5882352941176471
UIExtendedSRGBColorSpace 0.392157 0.588235 0.784314 1
0.39215686274509803
0.7843137254901961
0.5882352941176471
--------------------------------------------------

height: 80.0
textView.height: 30.0, max: 300.0
```

## Author

pikachu987, pikachu77769@gmail.com

## License

PALExtension is available under the MIT license. See the LICENSE file for more info.
