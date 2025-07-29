# Structure Tool

[English](#english) | [中文](#中文)

---

## English

### Overview

Structure Tool is a Dart command-line utility designed to help Flutter developers copy and recreate project directory structures. This tool allows you to extract the folder structure from an existing Flutter project and recreate it elsewhere, making it perfect for project templating and structure replication.

### Features

- **Generate Structure**: Extract directory structure from existing Flutter projects
- **Recreate Structure**: Rebuild project structure from saved JSON files
- **Selective Scanning**: Focuses on important directories (`lib`, `android`)
- **JSON Export**: Saves structure as readable JSON format
- **Cross-platform**: Works on all platforms supported by Dart

### Installation

1. Ensure you have Dart SDK installed
2. Clone or download this repository
3. Navigate to the project directory

### Usage

#### Generate Structure from Existing Project

```bash
dart structure_tool.dart generate -s /path/to/your/flutter/project
```

This command will:
- Scan the specified Flutter project directory
- Extract the structure of `lib` and `android` folders
- Generate a `project_structure.json` file in the current directory

#### Recreate Structure from JSON

```bash
dart structure_tool.dart recreate -i project_structure.json -o /path/to/new/location
```

This command will:
- Read the structure from the specified JSON file
- Create directories and empty files at the target location
- Recreate the exact folder structure

### Command Line Options

#### Generate Command
- `-s, --source`: Source Flutter project root directory path (required)

#### Recreate Command
- `-i, --input`: Input JSON file path (default: `project_structure.json`)
- `-o, --output`: Target directory for recreating structure (default: current directory)

### Example Workflow

1. **Extract structure from an existing project:**
   ```bash
   dart structure_tool.dart generate -s ~/my_flutter_app
   ```

2. **Recreate structure in a new location:**
   ```bash
   dart structure_tool.dart recreate -i project_structure.json -o ~/new_project
   ```

### Dependencies

This tool uses the following Dart packages:
- `path`: For cross-platform path manipulation
- `args`: For command-line argument parsing

### Use Cases

- **Project Templates**: Create reusable project structures
- **Team Standardization**: Ensure consistent project organization
- **Migration**: Transfer project structures between environments
- **Documentation**: Visualize project architecture

---

## 中文

### 概述

Structure Tool 是一个专为 Flutter 开发者设计的 Dart 命令行工具，用于复制和重建项目目录结构。该工具允许您从现有的 Flutter 项目中提取文件夹结构，并在其他地方重新创建，非常适合项目模板化和结构复制。

### 功能特性

- **生成结构**: 从现有 Flutter 项目中提取目录结构
- **重建结构**: 从保存的 JSON 文件重建项目结构
- **选择性扫描**: 专注于重要目录（`lib`、`android`）
- **JSON 导出**: 将结构保存为可读的 JSON 格式
- **跨平台**: 支持 Dart 支持的所有平台

### 安装

1. 确保已安装 Dart SDK
2. 克隆或下载此仓库
3. 导航到项目目录

### 使用方法

#### 从现有项目生成结构

```bash
dart structure_tool.dart generate -s /path/to/your/flutter/project
```

此命令将：
- 扫描指定的 Flutter 项目目录
- 提取 `lib` 和 `android` 文件夹的结构
- 在当前目录生成 `project_structure.json` 文件

#### 从 JSON 重建结构

```bash
dart structure_tool.dart recreate -i project_structure.json -o /path/to/new/location
```

此命令将：
- 从指定的 JSON 文件读取结构
- 在目标位置创建目录和空文件
- 重建完全相同的文件夹结构

### 命令行选项

#### Generate 命令
- `-s, --source`: 源 Flutter 项目根目录路径（必需）

#### Recreate 命令
- `-i, --input`: 输入 JSON 文件路径（默认：`project_structure.json`）
- `-o, --output`: 重建结构的目标目录（默认：当前目录）

### 示例工作流程

1. **从现有项目提取结构：**
   ```bash
   dart structure_tool.dart generate -s ~/my_flutter_app
   ```

2. **在新位置重建结构：**
   ```bash
   dart structure_tool.dart recreate -i project_structure.json -o ~/new_project
   ```

### 依赖项

此工具使用以下 Dart 包：
- `path`: 用于跨平台路径操作
- `args`: 用于命令行参数解析

### 使用场景

- **项目模板**: 创建可重用的项目结构
- **团队标准化**: 确保一致的项目组织
- **迁移**: 在不同环境间传输项目结构
- **文档**: 可视化项目架构

### 注意事项

- 该工具只复制目录结构，不复制文件内容
- 创建的文件为空文件，需要手动添加内容
- 目前支持扫描 `lib` 和 `android` 目录，可根据需要扩展

---

## License

This project is open source and available under the [MIT License](LICENSE).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

*Made with ❤️ for the Flutter community*
