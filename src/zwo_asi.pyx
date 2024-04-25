# zwo_asi.pyx

cimport zwo_asi
import numpy as np

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
    
        cdef unsigned char imgData[1920*1080*2]

        zwo_asi.ASIGetVideoData(self.ID, imgData, 1920*1080*2, 500)

        data = np.zeros(1920*1080*2, dtype=np.uint8)

        for i in range(1920*1080*2):
            data[i] = imgData[i]
        
        return data

    def get_frame(self):
        return self.get_frame_data().reshape(1080, 1920)
    
    
