import Foundation

// 解析対象の JSON
let jsonString1 = """
    {
        "response": {
            "area": [
                "北海道",
                "東北",
                "関東"
            ]
        }
    }
    """
print(jsonString1)
print("-------------")

// JSON の "response" 部分に対応する構造体（Codable に準拠）
// 解析対象の JSON 全体の構造
struct ResponsePart: Codable {
    let response: AreaPart
}

// JSON の "area" 部分に対応する構造体（Codable に準拠）
// 全体を表す ResponsePart のプロパティとして利用
struct AreaPart: Codable {
    let area: [String]
}

// Data -> Codable に利用
let decoder = JSONDecoder()

// Codable -> Data に利用
let encoder = JSONEncoder()

// Decode: String -> Data -> ResponsePart
let data1 = jsonString1.data(using: .utf8)!
let responsePart1 = try! decoder.decode(ResponsePart.self, from: data1)
print("JSON から構造体への変換結果")
print(responsePart1.response.area)
print("-------------")

// Encode: ResponsePart -> Data -> String
let responsePart2 = ResponsePart(response: AreaPart(area: ["Makati", "Tagaytay", "Matabungkay"]))
let data2 = try! encoder.encode(responsePart2)
let jsonString2 = String(data: data2, encoding: .utf8)!
print("構造体から JSON への変換結果")
print(jsonString2)
