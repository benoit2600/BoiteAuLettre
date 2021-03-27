# import the necessary packages
from skimage import metrics
import argparse
#import imutils
from cv2 import imread ,cvtColor ,COLOR_BGR2GRAY
import sys
# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-f", "--first", required=True,
	help="first input image")
ap.add_argument("-s", "--second", required=True,
	help="second")
args = vars(ap.parse_args())

# load the two input images
imageA = imread(args["first"])
imageB = imread(args["second"])
# convert the images to grayscale
grayA = cvtColor(imageA, COLOR_BGR2GRAY)
grayB = cvtColor(imageB, COLOR_BGR2GRAY)

# compute the Structural Similarity Index (SSIM) between the two
# images, ensuring that the difference image is returned
(score, diff) = metrics.structural_similarity(grayA, grayB, full=True)
diff = (diff * 255).astype("uint8")
print("SSIM: {}".format(score))
if (score > 0.85):
    sys.exit(1)
sys.exit(0)
