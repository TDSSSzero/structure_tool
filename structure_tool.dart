import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:args/args.dart';

//dart structure_tool.dart generate -s /Users/tb_daoyinglin/FlutterProject/scratch_card

// --- 常量定义 ---
const String commandGenerate = 'generate';
const String commandRecreate = 'recreate';
const String defaultJsonOutput = 'structures/project_structure.json';

/// 主函数 - 脚本入口
void main(List<String> arguments) {
  final parser = ArgParser()
    ..addCommand(commandGenerate,
        ArgParser()..addOption('source', abbr: 's', help: '源 Flutter 项目的根目录路径.', mandatory: true))
    ..addCommand(commandRecreate, ArgParser()
      ..addOption('input', abbr: 'i', help: '输入的 JSON 文件路径.', defaultsTo: defaultJsonOutput)
      ..addOption('output', abbr: 'o', help: '重建项目结构的目标目录.', defaultsTo: '.'));

  try {
    final argResults = parser.parse(arguments);
    final command = argResults.command;

    if (command == null) {
      printUsage(parser);
      return;
    }

    if (command.name == commandGenerate) {
      final sourcePath = command['source'] as String;
      handleGenerate(sourcePath);
    } else if (command.name == commandRecreate) {
      final inputJson = command['input'] as String;
      final outputPath = command['output'] as String;
      handleRecreate(inputJson, outputPath);
    }
  } catch (e) {
    print('错误: ${e.toString()}\n');
    printUsage(parser);
  }
}

// =================================================================
// 1. 生成 JSON 结构
// =================================================================

/// 处理生成命令
void handleGenerate(String sourcePath) {
  final sourceDir = Directory(sourcePath);
  if (!sourceDir.existsSync()) {
    print('错误: 源目录不存在于 "$sourcePath"');
    exit(1);
  }
  print('正在扫描源项目: $sourcePath');

  // 定义要扫描的子目录
  final partsToScan = ['lib', 'android'];
  final List<Map<String, dynamic>> rootChildren = [];

  for (var partName in partsToScan) {
    final partDir = Directory(p.join(sourceDir.path, partName));
    if (partDir.existsSync()) {
      print('  -> 正在处理 $partName...');
      rootChildren.add(directoryToJson(partDir));
    } else {
      print('  -> 未找到 $partName 目录，已跳过。');
    }
  }

  // 创建根节点
  final structureJson = {
    'name': p.basename(sourcePath),
    'type': 'directory',
    'children': rootChildren,
  };

  // 格式化并保存 JSON 文件
  final jsonString = JsonEncoder.withIndent('  ').convert(structureJson);
  final outputFile = File(defaultJsonOutput);
  outputFile.writeAsStringSync(jsonString);

  print('\n✅ 成功！项目结构已保存到: ${outputFile.absolute.path}');
}

/// 递归地将目录转换为 JSON Map
Map<String, dynamic> directoryToJson(Directory dir) {
  final List<Map<String, dynamic>> children = [];
  final entities = dir.listSync()..sort((a,b) => a.path.compareTo(b.path));

  for (final entity in entities) {
    if (entity is Directory) {
      children.add(directoryToJson(entity)); // 递归
    } else if (entity is File) {
      children.add({'name': p.basename(entity.path), 'type': 'file'});
    }
  }

  return {
    'name': p.basename(dir.path),
    'type': 'directory',
    'children': children,
  };
}


// =================================================================
// 2. 从 JSON 重建结构
// =================================================================

/// 处理重建命令
void handleRecreate(String inputJsonPath, String outputPath) {
  final inputFile = File(inputJsonPath);
  if (!inputFile.existsSync()) {
    print('错误: 输入的 JSON 文件不存在于 "$inputJsonPath"');
    exit(1);
  }

  final outputDir = Directory(outputPath);
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  print('正在从 "$inputJsonPath" 读取结构...');
  final jsonString = inputFile.readAsStringSync();
  final structure = jsonDecode(jsonString) as Map<String, dynamic>;

  print('正在目标位置创建结构: ${outputDir.absolute.path}');

  // 从根节点的子节点开始创建（lib, android 等）
  final rootChildren = structure['children'] as List;
  for (final node in rootChildren) {
    buildStructureFromJson(node, outputDir.path);
  }

  print('\n✅ 成功！项目结构已重建完毕。');
}

/// 递归地从 JSON Map 创建文件/目录
void buildStructureFromJson(Map<String, dynamic> node, String parentPath) {
  final name = node['name'] as String;
  final type = node['type'] as String;
  final currentPath = p.join(parentPath, name);

  if (type == 'directory') {
    print('  创建目录: $currentPath');
    Directory(currentPath).createSync(recursive: true);
    if (node.containsKey('children')) {
      for (final childNode in (node['children'] as List)) {
        buildStructureFromJson(childNode, currentPath); // 递归
      }
    }
  } else if (type == 'file') {
    print('  创建文件: $currentPath');
    File(currentPath).createSync(); // 创建空文件
  }
}

/// 打印用法信息
void printUsage(ArgParser parser) {
  print('用法: dart structure_tool.dart <command> [options]\n');
  print('可用命令:');
  print('  generate: 从现有项目生成一个 project_structure.json 文件。');
  print('  recreate: 从一个 project_structure.json 文件重建项目结构。\n');
  print('全局选项:');
  print(parser.usage);
}