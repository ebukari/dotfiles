#!/bin/python3
from html.parser import HTMLParser
import urllib.request


RELEASES_URL = "https://www.lua.org/ftp/"


def get_url(url):
    page = urllib.request.urlopen(url)
    page_source = page.read().decode("utf-8")
    return page_source


class LuaReleasesParser(HTMLParser):
    """
    1. Find the first td tag
    2. Set flag to process next tag data
    3. Extract data
    4. Set flag to discontinue processing
    5. If flag is set skip all the rest
    """

    def __init__(self, *args, **kwargs):
        super(LuaReleasesParser, self).__init__(*args, **kwargs)
        self._latest_version = None
        self._found = False
        self._is_first_row = False

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if self._found is False and tag == "td":
            self._is_first_row = attrs.get("class", "") == "name"

    def handle_endtag(self, tag):
        if self._is_first_row and tag == "a":
            self._found = True
            self._is_first_row = False

    def handle_data(self, data):
        data = data.strip()
        if self._is_first_row and data.endswith(".tar.gz"):
            self._latest_version = data
            _stop = self._latest_version.find(".tar.gz")
            print(self._latest_version[:_stop])


if __name__ == "__main__":
    parser = LuaReleasesParser()
    page = get_url(RELEASES_URL)
    parser.feed(page)
