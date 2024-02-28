# eaf_focuser.pxd

cdef extern from "EAF_linux_mac_SDK_V1.6/include/EAF_focuser.h":
    cdef struct EAF_INFO:
        int ID
        char Name[64]
        int MaxStep

    ctypedef enum EAF_ERROR_CODE:
        EAF_SUCCESS = 0
        EAF_ERROR_INVALID_INDEX
        EAF_ERROR_INVALID_ID
        EAF_ERROR_INVALID_VALUE
        EAF_ERROR_REMOVED
        EAF_ERROR_MOVING
        EAF_ERROR_ERROR_STATE
        EAF_ERROR_GENERAL_ERROR
        EAF_ERROR_NOT_SUPPORTED
        EAF_ERROR_CLOSED
        EAF_ERROR_END = -1

    cdef struct EAF_ID:
        unsigned char id[8]

    ctypedef EAF_ID EAF_SN

    cdef int EAFGetNum()
    cdef int EAFGetProductIDs(int* pPIDs)
    cdef int EAFCheck(int iVID, int iPID)
    cdef EAF_ERROR_CODE EAFGetID(int index, int* ID)
    cdef EAF_ERROR_CODE EAFOpen(int ID)
    cdef EAF_ERROR_CODE EAFGetProperty(int ID, EAF_INFO* pInfo)
    cdef EAF_ERROR_CODE EAFMove(int ID, int iStep)
    cdef EAF_ERROR_CODE EAFStop(int ID)
    cdef EAF_ERROR_CODE EAFIsMoving(int ID, int* pbVal, int* pbHandControl)
    cdef EAF_ERROR_CODE EAFGetPosition(int ID, int* piStep)
    cdef EAF_ERROR_CODE EAFResetPostion(int ID, int iStep)
    cdef EAF_ERROR_CODE EAFGetTemp(int ID, float* pfTemp)
    cdef EAF_ERROR_CODE EAFSetBeep(int ID, int bVal)
    cdef EAF_ERROR_CODE EAFGetBeep(int ID, int* pbVal)
    cdef EAF_ERROR_CODE EAFSetMaxStep(int ID, int iVal)
    cdef EAF_ERROR_CODE EAFGetMaxStep(int ID, int* piVal)
    cdef EAF_ERROR_CODE EAFStepRange(int ID, int* piVal)
    cdef EAF_ERROR_CODE EAFSetReverse(int ID, int bVal)
    cdef EAF_ERROR_CODE EAFGetReverse(int ID, int* pbVal)
    cdef EAF_ERROR_CODE EAFSetBacklash(int ID, int iVal)
    cdef EAF_ERROR_CODE EAFGetBacklash(int ID, int* piVal)
    cdef EAF_ERROR_CODE EAFClose(int ID)
    cdef char* EAFGetSDKVersion()
    cdef EAF_ERROR_CODE EAFGetFirmwareVersion(int ID, unsigned char* major, unsigned char* minor, unsigned char* build)
    cdef EAF_ERROR_CODE EAFGetSerialNumber(int ID, EAF_SN* pSN)
    cdef EAF_ERROR_CODE EAFSetID(int ID, EAF_ID alias)
endif