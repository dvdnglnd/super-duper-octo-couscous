import os
from shutil import copyfile

files = next(os.walk('./audios'))[2]

for file in files:
    short_name = file[0:8]
    copyfile(os.path.join('./audios/', file), os.path.join('./renamed/', short_name + '.mp3',))
