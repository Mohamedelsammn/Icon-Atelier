import os
from PIL import Image

sizes = {
    'mipmap-mdpi': 48,
    'mipmap-hdpi': 72,
    'mipmap-xhdpi': 96,
    'mipmap-xxhdpi': 144,
    'mipmap-xxxhdpi': 192,
}

base = 'android/app/src/main/res'

for folder, size in sizes.items():
    path = f'{base}/{folder}'
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    img.save(f'{path}/ic_launcher.png')
    img.save(f'{path}/ic_launcher_round.png')
    print(f'Done: {path}')

os.makedirs('android/app/src/main/res/mipmap-anydpi-v26', exist_ok=True)

xml = '<?xml version="1.0" encoding="utf-8"?>\n<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">\n    <background android:drawable="@android:color/transparent"/>\n    <foreground android:drawable="@android:color/transparent"/>\n</adaptive-icon>'

with open('android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml', 'w') as f:
    f.write(xml)

with open('android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml', 'w') as f:
    f.write(xml)

print('All done!')