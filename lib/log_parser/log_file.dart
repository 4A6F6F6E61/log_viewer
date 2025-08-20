import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/services.dart';

enum LogFileError { emptyLine, parseTimeStamp }

class LogEntry {
  LogEntry({required this.timestamp, required this.filter, required this.content});

  final DateTime timestamp;
  final String filter;
  final String content;

  @override
  String toString() {
    return """LogEntry: {
      timestamp: $timestamp
      filter: $filter
      content: $content
    }""";
  }
}

class LogFile {
  LogFile._();

  static Future<LogFile> file(String path) async {
    final file = LogFile._();
    file.currentLine = 0;
    file.lines = await File(path).readAsLines();
    return file;
  }

  static Future<LogFile> asset(String path) async {
    final file = LogFile._();
    file.currentLine = 0;
    file.lines = (await rootBundle.loadString(path)).split("\n");
    return file;
  }

  List<String> lines = [];
  int currentLine = 0;

  Set<String> filters = {};
  List<LogEntry> entries = [];

  Future<void> parse() async {
    for (currentLine = 0; currentLine < lines.length; ++currentLine) {
      try {
        final entry = await _parseLine();
        entries.add(entry);
        filters.add(entry.filter);
      } catch (e) {
        switch (e) {
          case LogFileError.emptyLine:
            {
              dev.log("Line: $currentLine is empty; skipping...");
              break;
            }
          case LogFileError.parseTimeStamp:
            {
              dev.log("Unable to parse timestamp for line: $currentLine");
              return; // TODO: REMOVE
              break;
            }
          case RangeError _:
            {
              rethrow;
            }
          default:
            {
              dev.log("Unexpected error occurred: $e");
              break;
            }
        }
      }
    }
  }

  bool first = true;

  Future<LogEntry> _parseLine() async {
    final iter = lines[currentLine].split(" ").iterator;

    DateTime timestamp;
    String filter = "other";
    String content = "";

    if (!iter.moveNext()) {
      throw LogFileError.emptyLine;
    }

    timestamp = parseTimeStamp(iter.current);
    if (first) {
      first = false;
      dev.log("timestamp: $timestamp");
    }

    if (!iter.moveNext()) {
      // TODO: Not sure how to handle it if a line only has a timestamp;
      // TODO: In theory, this should never happen
      return LogEntry(timestamp: timestamp, filter: filter, content: content);
    }

    if (iter.current.startsWith("[")) {
      filter = iter.current.replaceFirst("[", "").replaceFirst("]", "");
    }

    while (iter.moveNext()) {
      content += " ${iter.current}";
    }

    // If the next lines don't start with a TimeStamp,
    // add them to the content of the current line
    if (currentLine + 1 < lines.length) {
      while (!lines[currentLine + 1].trim().startsWith("<")) {
        ++currentLine;
        content += "\n${lines[currentLine]}";

        if (currentLine + 1 == lines.length) break;
      }
    }

    return LogEntry(timestamp: timestamp, filter: filter, content: content);
  }

  DateTime parseTimeStamp(String timeStampString) {
    DateTime result;
    try {
      // Remove < >
      timeStampString = timeStampString.replaceFirst('<', '').replaceFirst('>', '');
      // Check if the timestamp contains milliseconds
      int dotIndex = timeStampString.indexOf('.');
      if (dotIndex != -1) {
        // Remove everything starting from the dot
        timeStampString = timeStampString.substring(0, dotIndex);
        // Add the Z back
        timeStampString += 'Z';
      }
      result = DateTime.parse(timeStampString);
    } catch (e) {
      dev.log("Unable to parse: $e", name: "LogFile.parseTimeStamp");
      throw LogFileError.parseTimeStamp;
    }
    return result;
  }
}
