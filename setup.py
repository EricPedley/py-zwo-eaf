from setuptools import setup, Extension
from Cython.Build import cythonize

extensions = [
    Extension("eaf_focuser",
        ["src/eaf_focuser.pyx"],
        libraries=["EAFFocuser", "udev"],
        library_dirs=["src/EAF_linux_mac_SDK_V1.6/lib/x64/", "/usr/lib"],
        include_dirs=["src/EAF_linux_mac_SDK_V1.6/include"],
        extra_link_args=["-Wl,-rpath,src/EAF_linux_mac_SDK_V1.6/lib/x64,-rpath,/usr/lib"],
    )
]

setup(
    ext_modules=cythonize(extensions),
    name="eaf_focuser",
    author="Eric Pedley",
    author_email="ericpedley@gmail.com",
    long_description="Python wrapper for the ZWO EAF Focuser C++ SDK",
    version="1.0",
    platforms=["manylinux1_x86_64", "manylinux2010_x86_64", "manylinux2014_x86_64"]
)
