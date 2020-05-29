# clang-format-checker-docker

This Docker image let you verify that your code matches the format from clang-format, in an easy way, as part of your CI pipeline. The clang-format versions supported can be found on the ["Tags" page](https://hub.docker.com/repository/docker/witekio/clang-format-checker/tags?page=1) of the image.

## Getting Started

The simplest use of this image is to check source files in the current folder, after mounting it with `-v`. The example below checks all files in the current folder (`.`), and recursively (`-r`):

`docker run --rm -v $(pwd):/src witekio/clang-format-checker -r .`

Arguments after the image name are passed directly to `run-clang-format.py`. You can target multiple folders and files. The example below will recursively analyze files in the `src` and `includes` folder, as well as the file `main.cpp`.

`docker run --rm -v $(pwd):/src witekio/clang-format-checker -r src includes main.cpp`

## CI Integration

### BitBucket Pipeline

The following BitBucket Pipeline step will check for any style error in the `src` folder, and return an error if problems are found

```bitbucket-pipelines.yml
pipelines:
  default:
    - step:
        name: Check code format
        image: witekio/clang-format-checker
        script:
          - run-clang-format.py -r src
```

### GitLab CI Pipeline

The following GitLab CI step will check for any style error in the `src` folder, and return an error if problems are found

```.gitlab-ci.yml
check-format:
  image: witekio/clang-format-checker
  script:
    - run-clang-format.py -r src
```

## Output

The return code of the `docker run` will be:
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

This image relies on `run-clang-format`. For more information, you can check [`run-clang-format` official repository](https://github.com/Sarcasm/run-clang-format).

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

## Building manually

To build manually this image, you can clone this repository, and run `make`. Other supported Makefile targets are:
- `make build [TAG=latest]`: Build the image, and use the specified tag, or `latest`
- `make push [TAG=latest]`: Push the image to Docker HUB registry
- `make run [TAG=latest] [CMD="-r ."]`: Run the image locally after mounting the current folder. `run-clang-format` arguments can be customized with `CMD="<args>"`

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* This Docker container uses `run-clang-format` from [https://github.com/Sarcasm/run-clang-format](https://github.com/Sarcasm/run-clang-format)
