___

### Hi,
this is my small collection of smart AI tools.

It's easy to use and ready to start!

## Why it's good?

It's good because you can just step in without much setup stuff, without installing runtimes or compiling binaries. Everything is bash. You can configure the AI behavior right in the files.

All agent files use stdin and stdout, so you can pipe them in a chain and integrate into your everyday processes!

Some important files/folders are:

* ```func/ai-model-config.sh``` - Here you can configure the models for different AIs.

* The folder ```/json``` is to place structured information for the AI output.

## Setup
Some prerequisites:

* Uninstall Windows (you don't need it), use a Linux/Unix system.
* Checkout this project.
* Set some links to the AI files in ```/usr/local/bin``` for convenience.
* Set environment variables (see below).

export AIRPORT_AI_KEY={key}  
export TRANSLATION_AI_KEY={key}  
export ERR_EXPLANATION_AI_KEY={key}  
export TLDR_AI_KEY={key}  

You can, of course, use the same key if you don't want to differentiate it.

## The AIs

### tldr-ai

It works like the unix tool 'tldr' (explains unix tools). But uses AI.  
It has also a verbose switch ```tldr-ai -v```

```
tam137 | ~/git/ai-agents ❥ tldr-ai "ls"
Usage:
- `ls` - list files and directories.
- `ls -l` - detailed (long) list with permissions and sizes.
- `ls -a` - include hidden files (starting with .).
- `ls -h` - human-readable sizes.
- `ls -R` - recursive listing of directories.

Common options:
- `-t` - sort by modification time.
- `-S` - sort by file size.
- `-r` - reverse order.
```

```
tam137 | ~/git/ai-agents ❥ tldr-ai "git rebase"
Git rebase is used to move or combine a sequence of commits to a new base commit. It helps to maintain a clean project history.

Basic usage:
1. Start a rebase: git rebase <base-branch>
2. Resolve conflicts if any, then use: git rebase --continue
3. Abort the rebase: git rebase --abort

Useful for integrating changes or linearizing commit history.
```

### exec-ai

Provides a Unix command for the purpose the user requests.
```
tam137 | ~/git/ai-agents ❥ echo "Show me my used ram" | exec-ai
free -h
```

Works perfectly with tldr-ai.
```
tam137 | ~/git ❥ echo "list all files and folders" | exec-ai | tldr-ai 
Display detailed information about all files and directories, including hidden ones.

**Usage:**
ls -al [DIRECTORY]

**Options:**
- `-a`: Show all files, including hidden ones (starting with `.`).
- `-l`: Use a long listing format, showing permissions, owner, size, and modification date.

**Example:**
ls -al
```

### airport-ai

Gives structured information for a given airport. The use case is obvious: you need to know where to land!

```
tam137 | ~/git/ai-agents ❥ echo "EGLL" | airport-ai
{
  "City": "London",
  "IOAC": "EGLL",
  "Altitude": 25,
  "Runways": [
    {
      "direction": "09L/27R",
      "length": 3902
    },
    {
      "direction": "09R/27L",
      "length": 3660
    }
  ]
}
```

### toeng.sh / toger.sh / tolat.sh / toesp.sh

Translates text to the given language (English, German, Latin, Spanish)

```
tam137 | ~/git/suprah ❥ echo "With your help I can speak German, thats awesome" | toger 
Mit deiner Hilfe kann ich Deutsch sprechen, das ist großartig.
```

```
tam137 | ~/git/suprah ❥ echo "I can also translate everything and play silent mail." | toger | tolat | toesp | toeng
I can also translate everything and play in silence.
```

### err-explanation

Explains an error message (mostly for technical purposes, but not only..). Hint: Error needs to be redirected to the stdin channel.

```
tam137 | ~/git/suprah ❥ cargo build 2>&1 | err-explanation-ai
The errors you're encountering are due to unresolved imports in your Rust code. Here's a breakdown of the specific issues and how to fix them:

1. **Error E0432: Unresolved import `crate::Book`**  
   **Cause**: The compiler couldn't find a module or struct named `Book` in the root of your crate.  
   **Solution**: Check your file structure and ensure that you have a module named `Book`. Correct the import statement to match the exact name and case (e.g., `crate::book` if the module is named `book`).

2. [....]
```

```
tam137 | ~/git/suprah ❥ notinstalledprog 2>&1 | err-explanation-ai 
The error "command not found" typically occurs when the terminal (or command line interface) cannot locate the specified program. This usually means that the program is not installed or not in your system's PATH.

**Solution:**
1. Ensure that the program name is spelled correctly.
2. Install the program using your package manager:
   - For Ubuntu/Debian: `sudo apt install package_name`
   - For CentOS/RHEL: `sudo yum install package_name`
   - For macOS (Homebrew): `brew install package_name`
3. If the program is installed, check if it's in your PATH by running `echo $PATH` and verify the directories listed.
4. If necessary, add the program's installation directory to your PATH by updating your profile configuration file (e.g., `~/.bashrc` or `~/.bash_profile`).

Replace `package_name` with the actual name of the program you're trying to install.
```