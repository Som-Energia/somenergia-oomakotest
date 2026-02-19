#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import re
import requests

TIMEOUT = 5

IMG_REGEX = re.compile(
    r'https?://[^\s"\'>]+?\.(png|jpe?g|gif|webp|svg)',
    re.IGNORECASE
)


def check_url(url):
    try:
        r = requests.head(url, allow_redirects=True, timeout=TIMEOUT)
        return r.status_code
    except requests.RequestException as e:
        return str(e)


def scan_html_file(filepath):
    broken = []

    f = open(filepath, "r")
    try:
        content = f.read()
    finally:
        f.close()

    urls = set(IMG_REGEX.findall(content))
    # finds només retorna el grup, així que refem:
    urls = set(match.group(0) for match in IMG_REGEX.finditer(content))

    for url in urls:
        status = check_url(url)
        if status != 200:
            broken.append((url, status))

    return broken


def main(directory):
    broken_images = set()

    for root, _, files in os.walk(directory):
        for file in files:
            if file.lower().endswith(".mako"):
                path = os.path.join(root, file)
                broken = scan_html_file(path)

                if broken:
                    print("\n📄 "+path)
                    for url, status in broken:
                        print("  ❌ "+url+" → "+str(status))
                        broken_images.add(url)

    total_broken = len(broken_images)
    if total_broken == 0:
        print("✅ Tot net. Cap URL d'imatge trencada.")
    else:
        print("\n💥 Total d'URLs d'imatge trencades: "+str(total_broken))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Ús: python check_img_urls_regex.py <directori>")
        sys.exit(1)

    main(sys.argv[1])
