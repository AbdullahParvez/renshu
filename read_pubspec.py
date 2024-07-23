import yaml

with open("pubspec.yaml") as stream:
    try:
        # print(yaml.safe_load(stream)['flutter']['assets'])
        assets = yaml.safe_load(stream)['flutter']['assets']
        for asset in assets:
            # print(asset)
            if 'Picture' in asset or 'last_one' in asset:
                parts = asset.split('/')
                name = parts[3].split('.')
                year = ''
                if 'first' in parts[2]:
                    year = parts[2].replace('first', '1')
                elif 'second' in parts[2]:
                    year = parts[2].replace('second', '2')
                new_sent = "static const String "+name[0]+"_"+year+" = '"+asset+"';"
                print(new_sent)
    except yaml.YAMLError as exc:
        print(exc)