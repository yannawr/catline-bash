# catline

## Description

A simple Bash script to display the number of lines in files within a directory.
You can choose which file extensions you want the script to read or exclude the extensions of files you don't want to be included.

This script was inspired by OFJAAH videos.

## Requirements:

None, really. But remember if running as portable, ensure this script has execute permissions. Use `chmod +x ./catline.sh` to grant permissions.

## Usage

### Instalation

git clone this repository:
```
git clone https://github.com/yannawr/catline && cd catline && sudo chmod +x ./catline.sh
```
No installation is necessary, but if you find it more convenient, you can use the following command:

```bash
./catline -i
```
You can then delete the repository directory if you prefer.

## Commands

To display usage information, run catline with the `-h` or `-help` option:
```bash
catline -h
```
Options:
```
-e <extensions>   List of extensions to include (comma-separated)
-x <extensions>   List of extensions to exclude (comma-separated)
-i, -install      Install catline
-u, -uninstall    Uninstall catline
```
To read all files within a directory, simply run the script without including any additional commands.

## Removing catline
If you want to remove catline, use the following command:
```bash
catline -u
```

That's all :)

