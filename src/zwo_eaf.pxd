# zwo_eaf.pxd

cdef extern from "EAF_linux_mac_SDK_V1.6/include/EAF_focuser.h":
    cdef struct _EAF_INFO:
        pass

    ctypedef _EAF_INFO EAF_INFO

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

    int EAFGetNum()
    int EAFGetProductIDs(int* pPIDs)
    int EAFCheck(int iVID, int iPID)
    EAF_ERROR_CODE EAFGetID(int index, int* ID)
    EAF_ERROR_CODE EAFOpen(int ID)
    EAF_ERROR_CODE EAFClose(int ID)
    EAF_ERROR_CODE EAFGetProperty(int ID, EAF_INFO* pInfo)
    EAF_ERROR_CODE EAFMove(int ID, int iStep)
    EAF_ERROR_CODE EAFStop(int ID)
    EAF_ERROR_CODE EAFIsMoving(int ID, int* pbVal, int* pbHandControl)
    EAF_ERROR_CODE EAFGetPosition(int ID, int* piStep)
    EAF_ERROR_CODE EAFResetPostion(int ID, int iStep)
    EAF_ERROR_CODE EAFGetTemp(int ID, float* pfTemp)
    EAF_ERROR_CODE EAFSetBeep(int ID, int bVal)
    EAF_ERROR_CODE EAFGetBeep(int ID, int* pbVal)
    EAF_ERROR_CODE EAFSetMaxStep(int ID, int iVal)
    EAF_ERROR_CODE EAFGetMaxStep(int ID, int* piVal)
    EAF_ERROR_CODE EAFStepRange(int ID, int* piVal)
    EAF_ERROR_CODE EAFSetReverse(int ID, int bVal)
    EAF_ERROR_CODE EAFGetReverse(int ID, int* pbVal)
    EAF_ERROR_CODE EAFSetBacklash(int ID, int iVal)
    EAF_ERROR_CODE EAFGetBacklash(int ID, int* piVal)