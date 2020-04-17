from os import listdir
from os.path import isfile, join
import numpy as np
import imageio


def main():
    img_names = [f for f in listdir("../res") if isfile(join("../res", f))]
    paths = ["../res/{}".format(name) for name in img_names]

    imgs12 = []
    for path in paths:
        imgs12.append(convertImg(path))

    writeBook(imgs12, img_names)

def convertImg(path):
    img = imageio.imread(path)
    dims = img.shape;

    img = img >> 4 # prend les 4 MSB de chaque couleur
    rgb12 = []
    for y in range(dims[0]):
        for x in range(dims[1]):
            if dims[2] < 4 or img[y][x][3] == 15:
                rgb12.append("{0:04b}{0:04b}{0:04b}".format(img[y][x][0], img[y][x][1], img[y][x][2]))
            else:
                rgb12.append("uuuuuuuuuuuu")
    return rgb12

def writeBook(imgs, names):
    file = open("sprite_book.vhd", "w+")
    file.write("package sprite_book is\n")
    file.write("    type sprite is array (natural range 0 to 2499) of std_logic_vector(11 downto 0);\n")
    for i in range(len(imgs)):
        img = imgs[i]
        name = names[i].split('.')
        name = name[0]
        file.write("    constant {} : sprite := (".format(name))
        for j in range(len(img) - 1):
            file.write(" \"{}\",".format(img[j]))
        file.write(" \"{}\");\n".format(img[j + 1]))
    file.write("end sprite_book;")
    file.close

if __name__ == "__main__":
    main();
