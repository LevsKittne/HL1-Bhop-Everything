"""Engine-free checks. Does not pretend to compile engine integrations."""
from pathlib import Path
import csv,importlib.util,json,math,re,subprocess,sys
root=Path(__file__).resolve().parent.parent
spec=importlib.util.spec_from_file_location('goldsrc',root/'reference/goldsrc.py')
ref=importlib.util.module_from_spec(spec);sys.modules[spec.name]=ref;spec.loader.exec_module(ref)
ref.self_test()
count=0
with (root/'tests/cases.csv').open(newline='',encoding='utf-8') as f:
    for c in csv.DictReader(f):
        n=lambda k:float(c[k])
        result=ref.step((n('vx'),n('vy')),(n('wx'),n('wy')),n('dt'),n('maxspeed'),
            grounded=c['grounded']=='1',jump=c['jump']=='1',surface_friction=n('surface'),
            edge_multiplier=n('edge'),settings=ref.Settings(stock_bunny_limit=c['stock']=='1'))
        assert max(abs(result[0]-n('expected_x')),abs(result[1]-n('expected_y')))<1e-7,c['name']
        count+=1
for p in root.rglob('*.md'):
    if any(x in p.parts for x in ['.build','bin','obj','.godot']):continue
    for href in re.findall(r'\]\(([^)]+)\)',p.read_text(encoding='utf-8')):
        if '://' in href or href.startswith('#'):continue
        assert (p.parent/href.split('#')[0]).exists(),(p,href)
presets=json.loads((root/'config/presets.json').read_text(encoding='utf-8'))
assert presets['goldsrc-stock']['stock_bunny_limit'] is True
assert presets['classic-bhop']['stock_bunny_limit'] is False
print(f'PASS Python: {count} fixtures, documentation links and preset modes')
print('Engine-free checks complete. Run C++, C# and engine checks separately: docs/TESTING.md')
