#!/usr/bin/env python3
import json
import subprocess
import requests
from collections import namedtuple
validators = subprocess.run("solana -u https://solana-api.projectserum.com validators --output json".split(), stdout=subprocess.PIPE).stdout.decode()
validators = json.loads(validators)
gossip = subprocess.run("solana -u https://solana-api.projectserum.com gossip".split(), stdout=subprocess.PIPE).stdout.decode().split("\n")
ContactInfo = namedtuple("ContactInfo", ["ip", "id", "gossip", "tpu", "rpc", "version"])
contact_infos = [ContactInfo(*[x.strip() for x in l.split('|')]) for l in gossip[2:-2] if '|' in l]
full_data = [dict(validator, contact=contact) for validator in validators['validators'] for contact in contact_infos if contact.id == validator['identityPubkey']]
with_rpc = [i for i in full_data if i['contact'].rpc != 'none']
relevant = [i for i in sorted(full_data, key=lambda i: i['activatedStake']) if i['contact'].rpc != 'none']
def check_conn(validator):
    try:
        return requests.get(f"http://{validator['contact'].rpc}", timeout=2).status_code
    except (requests.ConnectTimeout, requests.ConnectionError):
        return None
with_response = [dict(validator, code=check_conn(validator)) for validator in relevant]
open_rpc = [x for x in with_response if x['code'] == 405]
print("\n".join([f"{i['voteAccountPubkey']:>45} http://{i['contact'].rpc:20} stake {i['activatedStake']}" for i in reversed(open_rpc)]))
