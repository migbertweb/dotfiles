import subprocess

pop = subprocess.run(
    'bat ~/.cache/conky-weather.json | jq ".list | .[0] | .pop"',
    shell=True,
    check=True,
    capture_output=True,
    encoding='utf-8')
num = float(pop.stdout.rstrip())
salida = num * 100
print(salida)
