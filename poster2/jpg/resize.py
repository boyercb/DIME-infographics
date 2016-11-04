import os
import sys
import glob
import math
from PIL import Image, ImageDraw, ImageFont

def resize(file, scale):
    """
    Resizes image file to size.
    """
    img = Image.open(file)
    fname, ext = os.path.splitext(file)
    width, height = img.size
    resized = img.resize((868, 613))
    # was 69
    cropped = resized.crop((0, 50, 868, 560))
    cropped.save(fname + "_resized.png")

for file in glob.glob('*.jpg'):
	resize(file, 0.175)
