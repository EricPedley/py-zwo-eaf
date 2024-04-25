cdef extern from "sdk/include/ASICamera2.h":

    cdef struct _ASI_CAMERA_INFO:
        pass
        
    ctypedef _ASI_CAMERA_INFO ASI_CAMERA_INFO
    

    int ASIGetNumOfConnectedCameras()
    int ASIGetCameraProperty(ASI_CAMERA_INFO *pASICameraInfo, int iCameraIndex)
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

