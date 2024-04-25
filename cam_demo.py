from zwo_asi import ASICamera
import cv2 as cv
from tqdm import tqdm
import numpy as np
from matplotlib import pyplot as plt

if __name__ == "__main__":
    cam = ASICamera(0, 0, 35)
    for _ in tqdm(range(100000)):
        frame_data = cam.get_frame_data()

        frame = frame_data.view(np.uint16).reshape(1080, 1920)
        frame = (frame >> 8) | ((frame & 0xFF) << 8)
        frame_color = cv.cvtColor(frame.astype(np.uint8), cv.COLOR_BAYER_RG2RGB)
        
        cv.imshow("frame", frame_color)
        if cv.waitKey(1) & 0xFF == ord('q'):
            break

        
        


