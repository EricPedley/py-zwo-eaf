# eaf_focuser.pyx

cimport eaf_focuser

cdef class EAF:
    cdef int ID

    def __cinit__(self, int ID):
        self.ID = ID

    def open(self):
        return eaf_focuser.EAFOpen(self.ID)

    def get_property(self):
        cdef eaf_focuser.EAF_INFO info
        ret = eaf_focuser.EAFGetProperty(self.ID, &info)
        if ret == eaf_focuser.EAF_SUCCESS:
            return info
        else:
            return None

    def move(self, int position):
        return eaf_focuser.EAFMove(self.ID, position)
