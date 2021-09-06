#!/usr/bin/env python3
import os
import argparse
import sys
import subprocess
import json
import secrets


def main(args):
    with open(args.connection_file) as f:
        data = json.load(f)
    data['ip'] = '0.0.0.0'

    rnd = secrets.token_hex(6)
    connection_file = f'~/.ipy-{rnd}.json'

    job_id = None
    try:
        kernel_args = " ".join([
            f'--Session.key={data["key"]}',
            f'--ip=0.0.0.0',
            f'-f {connection_file}'
        ])
        launch_stdout = subprocess.run([
            "ssh", args.host, args.cmd.replace("KERNEL_ARGS", kernel_args)
        ], check=True, capture_output=True).stdout
        job_id = [l for l in launch_stdout.split(b'\n') if l][-1].decode()

        query_cmd = f"while [ ! -f {connection_file} ]; do sleep 1; done; squeue --me --noheader -o '%N' -j {job_id}"
        host = None
        with subprocess.Popen(["ssh", args.host, query_cmd], stdout=subprocess.PIPE) as p:
            for line in p.stdout:
                host = line.strip().decode()
                if host:
                    break

        remote_config = json.loads(subprocess.run([
            'ssh', args.host, f'cat {connection_file}'
        ], check=True, capture_output=True).stdout)

        port_keys = { 'shell_port', 'iopub_port', 'stdin_port', 'control_port', 'hb_port' }
        test_port = remote_config['shell_port']
        forwards = [f'-L {data[key]}:{host}:{remote_config[key]}' for key in port_keys]
        ping_cmd = f"while nmap --open {host} -p {test_port} | grep {test_port} > /dev/null; do sleep 10; done"
        subprocess.run(["ssh", args.host] + forwards + [ping_cmd])
    finally:
        subprocess.run(["ssh", args.host, f"rm ~/.ipy-{rnd}.json"])
        if job_id is not None:
            subprocess.run(["ssh", args.host, "scancel", job_id])

if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    parser.add_argument("--host", help="SSH host or user@host of SLURM head node")
    parser.add_argument("--cmd", help="Command to run to start kernel. Should return job id as last line.")
    parser.add_argument("connection_file", metavar="CONNECTION_FILE")

    main(parser.parse_args())
