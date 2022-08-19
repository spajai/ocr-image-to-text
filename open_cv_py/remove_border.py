import sys
import cv2

img = cv2.imread(sys.argv[1])

img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) # tolerance seems not to work on RGB images

cornerPx = img[0,0] # this must be white

cv2.imshow("input", img)

th=30  # flood threshold
_, img, _, _ = cv2.floodFill(img, None, (0, 0), (0, 0, 255), loDiff=th, upDiff=th)
cv2.imshow("flood black", img)

_, img, _, _ = cv2.floodFill(img, None, (20, 200), (255, 255, 255), loDiff=th, upDiff=th)
cv2.imshow("flood white", img)

cv2.waitKey(0)