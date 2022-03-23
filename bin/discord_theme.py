#!/usr/bin/env python3
import plyvel
import sys
import os
from pathlib import Path
from xdg.BaseDirectory import xdg_config_home
import tempfile
import shutil
import json
import requests

TOKEN_KEY = b'_https://discord.com\x00\x01token'

def get_token():
    db_path = Path(os.path.join(xdg_config_home, 'discord', 'Local Storage', 'leveldb'))
    with tempfile.TemporaryDirectory() as d:
        dest = Path(d)
        manifest_name = (db_path / "CURRENT").read_text().strip()

        shutil.copy(db_path / manifest_name, dest)
        (dest / "CURRENT").write_text(manifest_name + "\n")
        for ldb in db_path.glob("*.ldb"):
            shutil.copy(ldb, dest)
        for log in db_path.glob("*.log"):
            shutil.copy(log, dest)

        db = plyvel.DB(str(dest))
        return json.loads(db.get(TOKEN_KEY)[1:])

def switch_theme(theme):
    requests.patch("https://discord.com/api/v9/users/@me/settings", headers={
        'Authorization': get_token(),
    }, json={"theme": theme})


if __name__ == '__main__':
    switch_theme(sys.argv[1])
