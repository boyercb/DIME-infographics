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
    resized = img.resize((math.floor(width * scale), math.floor(height * scale)))
    resized.save(fname + "_resized.png")

for file in glob.glob('*.jpg'):
	resize(file, 0.175)
