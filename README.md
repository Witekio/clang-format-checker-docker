# clang-format-checker-docker

Docker image verifying the code format with clang-format

## Getting Started

The following command will mount the current working directory folder to the `src` working directory, and check its format

`docker run --rm -v $(pwd):/src witekio/clang-format-checker`

The return code will be
* `non-zero` if any formatting errors are found, and printed in the standard output.
* `0` if no issue was found

```
$ docker run -v $(pwd):/src --rm witekio/clang-format-checker                                      2 ↵
--- ./testCode/File.cpp	(original)
+++ ./testCode/File.cpp	(reformatted)
@@ -3,18 +3,13 @@
 
 #include "MyHeader.h"
 
-MyClass::MyClass() 
+MyClass::MyClass()
-    : arg(new Other(std::string("string"), 4))
+  : arg(new Other(std::string("string"), 4))
```

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

## Changing the style

The style used by `clang-format` can be defined by providing a `.clang-format` file in your source folder. For more information, see [clang-format style options](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)

## Specify the files to check

Check recursively .h/.cpp files excluding `vendors` folder

`docker run --rm -v $(pwd):/src witekio/clang-format-checker "--extensions=h,cpp --exclude vendors"`

For more information, you can check [`run-clang-format`](https://github.com/Sarcasm/run-clang-format) repository

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* This Docker container uses `run-clang-format` from [https://github.com/Sarcasm/run-clang-format](https://github.com/Sarcasm/run-clang-format)
