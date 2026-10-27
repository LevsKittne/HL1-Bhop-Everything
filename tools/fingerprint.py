"""Read-only engine hints and selected file hashes; never executes the game."""
from pathlib import Path
import argparse,hashlib,json
def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('path',type=Path)
    args=ap.parse_args();root=args.path.resolve()
    if not root.is_dir():ap.error('Expected an existing game/project directory')
    evidence=[]
    def note(engine,p):
        if not p.is_file():return
        row={'candidate':engine,'file':str(p.relative_to(root)),'bytes':p.stat().st_size}
        # Large game archives are evidence only; do not hash whole installations.
        if p.suffix.lower() not in ['.pck','.pak','.ucas','.utoc']:
            h=hashlib.sha256()
            with p.open('rb') as f:
                for chunk in iter(lambda:f.read(1024*1024),b''):h.update(chunk)
            row['sha256']=h.hexdigest()
        evidence.append(row)
    for p in root.glob('*.uproject'):note('Unreal project',p)
    note('Unity project',root/'ProjectSettings/ProjectVersion.txt')
    note('Godot project',root/'project.godot')
    for name in ['UnityPlayer.dll','UnityPlayer.so','GameAssembly.dll','GameAssembly.so']:
        note('Unity native candidate',root/name)
    for data in root.glob('*_Data'):
        note('Unity Mono candidate',data/'Managed/Assembly-CSharp.dll')
        note('Unity IL2CPP candidate',data/'il2cpp_data/Metadata/global-metadata.dat')
    for pattern in ['*.pck','*.pak','*.ucas','*.utoc','Content/Paks/*.pak','Content/Paks/*.utoc']:
        for p in root.glob(pattern):note('Export/archive candidate; confirm independently',p)
    print(json.dumps({'path':str(root),'evidence':evidence,'status':'Hints only; confirm controller, runtime, architecture and extension point'},indent=2,ensure_ascii=False))
if __name__=='__main__':main()
