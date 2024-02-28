# eaf_focuser.pyx

cimport eaf_focuser_pxd

cdef class EAFWrapper:
    cdef int ID

    def __cinit__(self, int ID):
        self.ID = ID

    def open(self):
        return eaf_focuser_pxd.EAFOpen(self.ID)

    def close(self):
        return eaf_focuser_pxd.EAFClose(self.ID)

    def get_property(self):
        cdef eaf_focuser_pxd.EAF_INFO info
        ret = eaf_focuser_pxd.EAFGetProperty(self.ID, &info)
        if ret == eaf_focuser_pxd.EAF_SUCCESS:
            return info
        else:
            return None

    def move(self, int position):
        return eaf_focuser_pxd.EAFMove(self.ID, position)
    
    def move_relative(self, int position):
        return eaf_focuser_pxd.EAFMoveRelative(self.ID, position)
    
    def stop(self):
        return eaf_focuser_pxd.EAFStop(self.ID)