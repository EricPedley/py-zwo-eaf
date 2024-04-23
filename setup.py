from setuptools import setup, Extension
from Cython.Build import cythonize

extensions = [
    Extension(
        "zwo_eaf",
        ["src/zwo_eaf.pyx"],
        libraries=["EAFFocuser", "udev"],
        library_dirs=["src/sdk/lib/x64/", "/usr/lib"],
        include_dirs=["src/sdk/include"],
        extra_compile_args=['-static'],
        extra_link_args=[
            "-Wl,-rpath,/usr/lib,-rpath,src/sdk/lib/x64"
            ],
    ),
    Extension(
        "zwo_asi",
        ["src/zwo_asi.pyx"],
        libraries=["ASICamera2", "udev", "opencv_core"],
        library_dirs=["src/sdk/lib/x64/", "/usr/lib"],
        include_dirs=["src/sdk/include"],
        extra_compile_args=['-static'],
        extra_link_args=[
            "-Wl,-rpath,/usr/lib,-rpath,src/sdk/lib/x64"
            ],
    )
]

setup(
    ext_modules=cythonize(extensions),
    name="zwo_eaf",
)
