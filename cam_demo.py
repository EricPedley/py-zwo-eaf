from zwo_asi import ASICamera
import cv2 as cv
from tqdm import tqdm
import numpy as np
from matplotlib import pyplot as plt

if __name__ == "__main__":
    cam = ASICamera(0, 200, 1000*1/60)
    for _ in tqdm(range(100000)):
        frame_color = cam.get_frame()
        cv.imshow("frame", frame_color)
        if cv.waitKey(1) & 0xFF == ord('q'):
            break

        
        


