cdef extern from 'opencv2/core/types_c.h':
    cdef struct IplImage:
        pass
    cdef struct CvSize:
        pass
    cdef enum:
        IPL_DEPTH_16U = 16

cdef extern from 'opencv2/core/core_c.h':
    IplImage* cvCreateImage 	( 	CvSize  	size,
		int  	depth,
		int  	channels 
	) 	

cdef extern from 'opencv2/core.hpp':
    cdef int CV_16UC3
    cdef int CV_16UC1
    cdef int CV_16U

cdef extern from 'opencv2/core/mat.hpp':
    cdef class Mat "cv::Mat":
        pass