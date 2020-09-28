import Foundation
import Darwin

// Structures ///////////////////////////////////////////////////////////////////////

struct Plist {
    let filename: String
    let dict: NSDictionary
}

func mergeLeaks(from statistics: [Statistics]) -> [String: [Int]] {
    var allLeaksCountByName: [String: [Int]] = [:]
    for stat in statistics {
        for (leak, count) in stat.leaksCountByName {
            if allLeaksCountByName[leak] == nil {
                allLeaksCountByName[leak] = [count]
            } else {
                allLeaksCountByName[leak]?.append(count)
            }
        }
    }
    return allLeaksCountByName
}

func median(of array: [Int]) -> Float {
    let sorted = array.sorted()
    if sorted.count % 2 == 0 {
        return Float((sorted[(sorted.count / 2)] + sorted[(sorted.count / 2) - 1])) / 2
    } else {
        return Float(sorted[(sorted.count - 1) / 2])
    }
}

class Statistics {
    var leaksCountByName: [String: Int]

    init(dict: NSDictionary) {
        leaksCountByName = dict["leaksCountByName"] as? [String: Int] ?? [:]
    }

    init(averageOf statistics: [Statistics]) {
        let allLeaksCountByName = mergeLeaks(from: statistics)
        leaksCountByName = [:]
        for (leak, counts) in allLeaksCountByName {
            let total = counts.reduce(0, +)
            leaksCountByName[leak] = total / counts.count
        }
    }

    init(medianOf statistics: [Statistics]) {
        let allLeaksCountByName = mergeLeaks(from: statistics)
        leaksCountByName = [:]
        for (leak, counts) in allLeaksCountByName {
            leaksCountByName[leak] = Int(median(of: counts))
        }
    }

    func removeCommonLeaks(with statistics: Statistics, keepThoseWithDistanceBiggerThan: Int) {
        for (leak, count) in statistics.leaksCountByName {
            guard let foundCount = leaksCountByName[leak] else { continue }
            if abs(foundCount-count) > keepThoseWithDistanceBiggerThan {
                continue
            } else {
                leaksCountByName[leak] = nil
            }
        }
    }

    func printInfo() {
        if leaksCountByName.count == 0 {
            print("No leaks.")
        } else {
            let sortedLeaks = leaksCountByName.enumerated().sorted(by: { $0.1.value >= $1.1.value }).map { $1 }
            for (key, value) in sortedLeaks {
                print(" \(value)x \(key)")
            }
        }
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

func loadPlists(from plistURLs: [URL]) -> [Plist] {
    let plists = plistURLs.compactMap { plistFile -> Plist? in
        guard let dict = NSDictionary(contentsOf: plistFile) else { return nil }
        return Plist(filename: plistFile.lastPathComponent, dict: dict)
    }
    return plists
}

// Parse arguments ///////////////////////////////////////////////////////////////////////

guard CommandLine.arguments.count > 1 else {
    print("Usage: MeasureStatisticsNovelty stat_1 stat_2 ... stat_n stat_latest")
    print("Will measure how muh stat_latest changed when compared to average of stat_1 stat_2 ... stat_n")
    exit(1)
}

let plistPaths = CommandLine.arguments[1..<CommandLine.arguments.count]
let plistURLs = plistPaths.compactMap { fullPathFromCurrentDirectory(for: $0) }
let plists = loadPlists(from: plistURLs)
let statistics = plists.compactMap { Statistics(dict: $0.dict) }
let latestStatistics = statistics[statistics.count-1]
let oldStatistics = Array(statistics[0..<statistics.count-1])

let commonAmongOldStatistics = Statistics(averageOf: oldStatistics)
print("\nCommon average among old leaks:\n")
commonAmongOldStatistics.printInfo()

print("\nLatest leaks:\n")
latestStatistics.printInfo()

let tolerance: Int = 10
print("\nAny new leaks? (latest leaks after substracting old leaks with tolerance \(tolerance)):\n")
latestStatistics.removeCommonLeaks(with: commonAmongOldStatistics, keepThoseWithDistanceBiggerThan: tolerance)
latestStatistics.printInfo()
