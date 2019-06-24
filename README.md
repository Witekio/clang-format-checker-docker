# clang-format-checker-docker

Docker image verifying the code format with clang-format

## Getting Started

The following command will mount the current working directory folder to the `src` working directory, and recursively check the format of source files in `src` and  `include` directories, as well as `file.cpp`

`docker run --rm -v $(pwd):/src witekio/clang-format-checker -r src includes file.cpp`

## Output

The return code of the `docker run` will be
* `non-zero` if any formatting errors are found, and printed in the standard output.
* `0` if no issue was found

```
# Recursively check all files from current folder
$ docker run -v $(pwd):/src --rm witekio/clang-format-checker -r .                                 2 ↵
--- ./testCode/File.cpp	(original)
+++ ./testCode/File.cpp	(reformatted)
@@ -3,18 +3,13 @@
 
 #include "MyHeader.h"
MyClass::MyClass()
-    : arg(new    Other( std::string(  "string"),      4))
+  : arg(new Other(std::string("string"), 4))
```

## Specifying the code style

The style used by `clang-format` can be defined by providing a `.clang-format` file in your source folder. For more information, see [clang-format style options](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)

## Supported arguments

Folders and files can be excluded with `--exclude`
```
# Check recursively .h/.cpp files excluding 'vendors' folder and '*_test.cpp'
docker run -v $(pwd):/src --rm witekio/clang-format-checker -r  --exclude src/third_party --exclude '*_test.cpp' src include foo.cpp
```

`run-clang-format.py` help
```
usage: run-clang-format.py [-h] [--clang-format-executable EXECUTABLE]
                           [--extensions EXTENSIONS] [-r] [-q] [-j N]
                           [--color {auto,always,never}] [-e PATTERN]
                           file [file ...]

A wrapper script around clang-format, suitable for linting multiple files and
to use for continuous integration. This is an alternative API for the clang-
format command line. It runs over multiple files and directories in parallel.
A diff output is produced and a sensible exit code is returned.

positional arguments:
  file

optional arguments:
  -h, --help            show this help message and exit
  --clang-format-executable EXECUTABLE
                        path to the clang-format executable
  --extensions EXTENSIONS
                        comma separated list of file extensions (default:
                        c,h,C,H,cpp,hpp,cc,hh,c++,h++,cxx,hxx)
  -r, --recursive       run recursively over directories
  -q, --quiet
  -j N                  run N clang-format jobs in parallel (default number of
                        cpus + 1)
  --color {auto,always,never}
                        show colored diff (default: auto)
  -e PATTERN, --exclude PATTERN
                        exclude paths matching the given glob-like pattern(s)
                        from recursive search
```
For more information, you can check [`run-clang-format` official repository](https://github.com/Sarcasm/run-clang-format).

## CI Integration

### BitBucket Pipeline

The following Pipeline step will check for any style error in the `src` folder, and return an error if problems are found
```
pipelines:
  default:
    - step:
        name: Check code format
        image: witekio/clang-format-checker
        script:
          - run-clang-format.py -r src
```

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* This Docker container uses `run-clang-format` from [https://github.com/Sarcasm/run-clang-format](https://github.com/Sarcasm/run-clang-format)
