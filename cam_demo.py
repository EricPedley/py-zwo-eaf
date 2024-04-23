from zwo_asi import ASICamera
import cv2 as cv

if __name__ == "__main__":
    cam = ASICamera(0, 0, 35)
    while True:
        img = cam.get_frame()
        cv.imshow("frame", img)
        if cv.waitKey(1) & 0xFF == ord("q"):
            break
