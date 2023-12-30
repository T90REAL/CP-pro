# CP-pro
This is a tool for competitive programmer to automatically get the test case input/output files.
Currently only supports C++, Python and Java.
## Requirements
- competitive-companion browser extension (https://github.com/jmerle/competitive-companion)
- Python3 with `socket` `json` package
- OS: Macos / Linux
## Limitations
Since this is just a tool I use myself when I'm using neovim for competitive programming, so I assume all the solution file is called
`sol.cpp` or `sol.py`, also you have to change a tons of path in the `makefile.sh`. So if anyone is really interested in this project, I 
may perfect it in the future.

## Configurations
Open the `makefile.sh`, in the function `fetch_info` and `get_dependency`, you should clone this project and replace all the path to fit
your need.

The ```cpp.cpp``` and ```cpp2.cpp``` is just the template you use for programming.

## Usage
### Demo

**Create the files with your own template**
```
python3 create [filename.cpp/.py]
```

**Fetch the test case info from the OJ**
```
python3 fetch.py [problem name]
```
**Test your solution**
```
cd /prob_directory
python3 test.py
```
**Delete all the related files in the current directory**
```
python3 dl.py
```

## Other
You can choose to do some *alias* in your computer to make all procedure faster. I use zsh shell so here is part of my .zhsrc:
```
alias pro='sh makefile.sh'
alias gen='sh makefile.sh gen sol.cpp'
alias test='python3 /Users/liam/programming/competitive-programming/script/test.py'
alias fetch='python3 /Users/liam/programming/competitive-programming/script/fetch.py'
```
