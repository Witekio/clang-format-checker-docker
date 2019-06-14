# clang-format-checker-docker

Docker image verifying the code format with clang-format

## Getting Started

Mount the source folder in the `src` working directory and run the format checker

`docker run --rm -v $(pwd):/src witekio/clang-format-checker`

The return code will be
* `1` if any formatting errors are found, and printed in the standard output.
* `0` if no issue was found

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* This Docker container uses `run-clang-format` from [https://github.com/Sarcasm/run-clang-format](https://github.com/Sarcasm/run-clang-format)
