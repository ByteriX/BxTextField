import Foundation
import Darwin

// Structures ///////////////////////////////////////////////////////////////////////

struct Plist {
    let filename: String
    let dict: NSDictionary
}

struct Leak {
    let name: String
    let description: String
    let debugDescription: String
    let displayAddress: String
    let isCycle: Bool
    let isRootLeak: Bool
    let allocationTimestamp: Int
    let count: Int
    let size: Int
    let bundleName: String?

    var id: String { 
        var text = name.isEmpty ? "unknown" : name
        if let bundleName = bundleName, !bundleName.isEmpty {
            text.append(" (\(bundleName))")
        }
        return text
    }

    init?(dict: NSDictionary) {
        guard   let name = dict["name"] as? String,
                let description = dict["description"] as? String,
                let debugDescription = dict["debugDescription"] as? String,
                let displayAddress = dict["displayAddress"] as? String,
                let isCycle = dict["isCycle"] as? Bool,
                let isRootLeak = dict["isRootLeak"] as? Bool,
                let allocationTimestamp = dict["allocationTimestamp"] as? Int,
                let count = dict["count"] as? Int,
                let size = dict["size"] as? Int
        else { return nil }
        self.name = name
        self.description = description
        self.debugDescription = debugDescription
        self.displayAddress = displayAddress
        self.isCycle = isCycle
        self.isRootLeak = isRootLeak
        self.allocationTimestamp = allocationTimestamp
        self.count = count
        self.size = size

        self.bundleName = description
            .components(separatedBy: " ")
            .filter { !$0.isEmpty && $0 != name && !$0.contains("DVT_") && !$0.contains("0x") }
            .joined(separator: " ")
    }
}

struct Report {
    let createdAt: Date
    let leaks: [Leak]
    init?(plist: Plist) {
        let filenameComponents = plist.filename.components(separatedBy: "-")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        guard   filenameComponents.count == 3,
                let createdAt = dateFormatter.date(from: filenameComponents[1]),
                let leaksRaw = plist.dict["com.apple.xray.instrument-type.homeleaks"] as? [NSDictionary]
        else { return nil }

        self.createdAt = createdAt
        self.leaks = leaksRaw.compactMap { leakRaw in
            let leak = Leak(dict: leakRaw)
            return leak
        }
    }
}

class Statistics {
    var leaksCountByName: [String: Int]

    init() {
        leaksCountByName = [:]
    }

    func analyze(report: Report) {
        for leak in report.leaks {
            leaksCountByName[leak.id] = (leaksCountByName[leak.id] ?? 0) + leak.count
        }
    }

    func printInfo() {
        if leaksCountByName.count == 0 {
            print("No leaks.")
        } else {
            print("Found leaks:")
            let sortedLeaks = leaksCountByName.enumerated().sorted(by: { $0.1.value >= $1.1.value }).map { $1 }
            for (key, value) in sortedLeaks {
                print(" \(value)x \(key)")
            }
        }
    }

    func save(to url: URL) {
        let out = [
            "leaksCountByName": leaksCountByName
        ]
        let dict = NSDictionary(dictionary: out)
        try! dict.write(to: url)
    }
}

// Helpers ///////////////////////////////////////////////////////////////////////

func print(error: String) {
    fputs("Error: \(error)\n", stderr)
}

func fullPathFromCurrentDirectory(for path: String) -> URL? {
    let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    return URL(fileURLWithPath: path, relativeTo: currentDirectoryURL)
}

func loadPlists(from directoryURL: URL) throws -> [Plist] {
    let fileManager = FileManager.default
    let plistsFiles = try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
    let plists = plistsFiles.compactMap { plistFile -> Plist? in
        guard let dict = NSDictionary(contentsOf: plistFile) else { return nil }
        return Plist(filename: plistFile.lastPathComponent, dict: dict)
    }
    let sortedPlists = plists.sorted(by: { $0.filename < $1.filename })
    return sortedPlists
}

// Parse arguments ///////////////////////////////////////////////////////////////////////

guard CommandLine.arguments.count == 3 else {
    print("usage: ParsedTraceToStatistics folder_with_parsed_trace_files output_file_for_statistics")
    exit(1)
}

guard let directoryURL = fullPathFromCurrentDirectory(for: CommandLine.arguments[1]) else {
    print(error: "Invalid path \"\(CommandLine.arguments[1])\" for folder with parsed trace files.")
    exit(1)
}

guard let outputURL = fullPathFromCurrentDirectory(for: CommandLine.arguments[2]) else {
    print(error: "Invalid path \"\(CommandLine.arguments[2])\" for output file for statistics.")
    exit(1)
}

// Create statistics file ///////////////////////////////////////////////////////////////////////

do {
    let plists = try loadPlists(from: directoryURL)
    let reports = plists.compactMap { Report(plist: $0) }
    let stats = Statistics()
    reports.forEach { stats.analyze(report: $0) }
    stats.save(to: outputURL)
    stats.printInfo()
} catch {
    print(error: "\(error)")
    exit(1)
}