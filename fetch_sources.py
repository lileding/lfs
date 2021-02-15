#!/usr/bin/env python3
#
import sys
import logging
import hashlib
import os
import urllib.request
import cssselect
from lxml.html import etree

mirrors = [
    'http://mirrors.tuna.tsinghua.edu.cn/gentoo/distfiles',
    'http://mirrors.tuna.tsinghua.edu.cn/pkgsrc/distfiles',
    'http://mirrors.ustc.edu.cn/lfs/lfs-packages/10.0',
]


def main():
    logging.basicConfig(level=logging.DEBUG)
    destdir = len(sys.argv) > 1 and sys.argv[1] or './'
    tree = etree.HTML(sys.stdin.read())
    for dd in tree.cssselect('dl.variablelist > dd'):
        link = None
        checksum = None
        for p in dd.cssselect('p'):
            if p.text.strip().startswith('Download'):
                link = p.cssselect('a.ulink')[0].text.strip()
            if p.text.strip().startswith('MD5'):
                checksum = p.cssselect('code.literal')[0].text.strip()
        download(link, checksum, destdir)


def download(link, checksum, destdir):
    fname = link.split('/')[-1]
    fpath = os.path.join(destdir, fname)
    urls = []
    for m in mirrors:
        urls.append('%s/%s' % (m, fname))
    if link.find('ftp.gnu.org'):
        urls.append(link.replace('ftp.gnu.org', 'mirrors.tuna.tsinghua.edu.cn'))
    urls.append(link)
    if check_download(fpath, checksum):
        return
    for url in urls:
        if download_inner(url, fpath, checksum):
            logging.info('download %s from %s success' % (fname, url))
            return


def check_download(fpath, checksum):
    if not os.path.exists(fpath):
        return False
    with open(fpath, 'rb') as f:
        md5 = hashlib.md5()
        md5.update(f.read())
        ck2 = str(md5.hexdigest())
        return ck2 == checksum


def download_inner(link, fpath, checksum):
    logging.debug('download %s with md5=%s' % (link, checksum))
    try:
        urllib.request.urlretrieve(link, fpath)
    except Exception as ex:
        logging.warning('download %s fail: %s' % (link, ex))
        return False
    return check_download(fpath, checksum)


if __name__ == '__main__':
    main()
