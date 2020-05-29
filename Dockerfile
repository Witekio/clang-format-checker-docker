FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
	clang-format python3 \
        && rm -rf /var/lib/apt/lists/*

ADD run-clang-format/run-clang-format.py /usr/bin
RUN ln -s /usr/bin/python3 /usr/local/bin/python

RUN mkdir /src
WORKDIR /src

RUN echo "--- Clang-format version ---"
RUN clang-format --version

ENTRYPOINT ["run-clang-format.py"]

