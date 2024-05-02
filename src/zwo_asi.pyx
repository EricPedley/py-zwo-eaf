# zwo_asi.pyx

cimport zwo_asi
cimport numpy as np
import numpy as np # doesn't conflict with cimport because cython magic
import cv2 as cv

from cpython.buffer cimport PyObject_GetBuffer, PyBuffer_Release, PyBUF_ANY_CONTIGUOUS, PyBUF_SIMPLE

cdef enum:
    ASI_IMG_RAW8 = 0
    ASI_IMG_RAW16 = 2
    ASI_GAIN = 0
    ASI_EXPOSURE = 1
    ASI_BANDWIDTHOVERLOAD = 6
    ASI_HIGH_SPEED_MODE = 14
    ASI_WB_B = 4
    ASI_WB_R = 3
    ASI_FALSE = 0
    ASI_TRUE = 1
    ASI_MODE_NORMAL = 0

cdef class ASICamera:
    cdef int ID

    def __cinit__(self, int ID, int gain, int exposure_ms):
        self.ID = ID
        print("num connected:", zwo_asi.ASIGetNumOfConnectedCameras())
        cdef zwo_asi.ASI_CAMERA_INFO cam_info
        info = zwo_asi.ASIGetCameraProperty(&cam_info, self.ID)
        print(info)
        zwo_asi.ASIOpenCamera(self.ID)
        zwo_asi.ASIInitCamera(self.ID)
        zwo_asi.ASISetROIFormat(self.ID, 1920, 1080, 1, ASI_IMG_RAW16)
        zwo_asi.ASISetControlValue(self.ID, ASI_GAIN, gain, ASI_FALSE)
        zwo_asi.ASISetControlValue(self.ID, ASI_EXPOSURE, exposure_ms*1000, ASI_FALSE)

        # hard-coded values copied from sdk C++ demo code
        zwo_asi.ASISetControlValue(self.ID,ASI_BANDWIDTHOVERLOAD, 40, ASI_FALSE)
        zwo_asi.ASISetControlValue(self.ID,ASI_HIGH_SPEED_MODE, 0, ASI_FALSE)
        zwo_asi.ASISetControlValue(self.ID,ASI_WB_B, 90, ASI_FALSE)
        zwo_asi.ASISetControlValue(self.ID,ASI_WB_R, 48, ASI_TRUE)

        zwo_asi.ASIStartVideoCapture(self.ID)

    def __dealloc__(self):
        zwo_asi.ASIStopVideoCapture(self.ID)
        zwo_asi.ASICloseCamera(self.ID)
    
    def get_frame_data(self):
        # Assuming your NumPy array is named 'arr' (dtype should be character type)
        cdef np.ndarray[dtype=np.uint8_t, ndim=1] arr = np.empty(1920*1080*2, dtype=np.uint8)

        cdef unsigned char* data_ptr = <unsigned char*>arr.data  # Direct pointer access (use with caution)

        zwo_asi.ASIGetVideoData(self.ID, data_ptr, 1920*1080*2, 500)
        
        return arr

    def get_frame(self):
        frame_data = self.get_frame_data()

        frame = frame_data.view(np.uint16).reshape(1080, 1920)
        frame = (frame >> 8) | ((frame & 0xFF) << 8)
        frame_color = cv.cvtColor(frame.astype(np.uint8), cv.COLOR_BAYER_RG2RGB)

        return frame_color
    
    
