#!/usr/bin/env python3
import argparse
import subprocess

def get_brightness_value(bus):
    output = subprocess.check_output(['ddcutil', '--bus', bus, 'getvcp', '10']).decode()
    value = output.split('=')[1].split(',')[0].strip()
    return value

def list_monitors():
    result = []
    output = subprocess.check_output(['ddcutil', 'detect', '-t']).decode()
    lines = output.split("\n")

    item = {}
    for line in lines:
        line = line.strip()
        if line.startswith("I2C bus:"):
            bus = line.split(" ")[-1]
            item['bus'] = bus.split("-")[-1]
            item['value'] = get_brightness_value(item['bus'])
        elif line.startswith("Monitor:"):
            monitor = line.split(" ")[-1]
            item['monitor'] = monitor.split(":")[1]
            result.append(item)
            item = {}
    print("\n".join("{},{},{}".format(item['monitor'], item['bus'], item['value']) for item in result))

def get_brightness(monitor):
    pass

def set_brightness(monitor, value):
    output = subprocess.check_output(['ddcutil', '--bus', monitor, 'setvcp', '10', value]).decode()

def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(required=True)

    parser_list = subparsers.add_parser('list')
    parser_list.set_defaults(func=list_monitors)

    parser_get = subparsers.add_parser('get')
    parser_get.add_argument('-m', '--monitor', dest='monitor', help='Monitor')
    parser_get.set_defaults(func=get_brightness)

    parser_set = subparsers.add_parser('set')
    parser_set.add_argument('-m', '--monitor', dest='monitor', help='Monitor')
    parser_set.add_argument('-v', '--value', dest='value', help='Brightness value')
    parser_set.set_defaults(func=set_brightness)

    args = parser.parse_args()
    func = args.func
    kwargs = args.__dict__
    kwargs.pop("func")
    func(**kwargs)

if __name__ == "__main__":
    main()
