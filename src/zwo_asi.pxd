cdef extern from "sdk/include/ASICamera2.h":

    cdef struct ASI_CAMERA_INFO:
        pass

    int ASIGetNumOfConnectedCameras()
    int ASIInitCamera(int cameraId)
    int ASIOpenCamera(int cameraId)
    int ASIGetControlValue(int cameraId, int controlId, int *value, int controlType)
    int ASISetROIFormat(int iCameraID, int iWidth, int iHeight, int iBin, int Img_type)
    int ASISetControlValue(int cameraId, int controlId, int value, int controlType)
    int ASIStartVideoCapture(int cameraId)
    int ASIGetVideoData(int cameraId, unsigned char *data, int length, int iWaitMS)
    int ASIGetDroppedFrames(int cameraID, int *droppedFrames)
    int ASIStopVideoCapture(int cameraId)
    int ASICloseCamera(int cameraId)

