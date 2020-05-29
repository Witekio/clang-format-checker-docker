FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
	clang-format python3 \
        && rm -rf /var/lib/apt/lists/*

ADD run-clang-format/run-clang-format.py /usr/bin

RUN mkdir /src
WORKDIR /src
ENTRYPOINT ["run-clang-format.py"]

