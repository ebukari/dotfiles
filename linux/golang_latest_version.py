#!/bin/python3

import re
import urllib.request
from html.parser import HTMLParser

GO_RELEASES_URL = r'https://golang.org/doc/devel/release'
GO_VERSION_RE = re.compile(r'''^go\d     # go and major version number
                               \.
                               \d+       # major release number
                               (\.\d+)*  # minor rlease number
                               $''', re.X | re.I)
GO_MAJOR_VERSION_RE = re.compile(r'^(Go \d\.\d+) is a major')


def get_url(url):
    page = urllib.request.urlopen(url)
    page_source = page.read().decode('utf-8')
    return page_source


def version_str_to_tuple(version_string):
    return tuple(map(int, version_string.split(".")))


def get_golang_latest():
    page_source = get_url(GO_RELEASES_URL)

    class GolangParser(HTMLParser):

        def __init__(self, *args, **kwargs):
            super(GolangParser, self).__init__(*args, **kwargs)
            self._versions = []

        def handle_data(self, data):
            for line in data.strip().split("\n"):
                line = line.strip()
                if GO_VERSION_RE.match(line) is not None:
                    self._versions.append(version_str_to_tuple(line[2:]))

                elif GO_MAJOR_VERSION_RE.match(line) is not None:
                    version_string = line.split(' ')[1]
                    self._versions.append(version_str_to_tuple(version_string))

        def get_latest_version(self):
            return ".".join(map(str, max(self._versions)))

    parser = GolangParser()
    parser.feed(page_source)
    return parser.get_latest_version()


try:
    print(get_golang_latest())
except:
    print("")
