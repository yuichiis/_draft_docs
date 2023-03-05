cl /P /C /IC:\OpenBLAS\OpenBLAS-0.3.20-x64\include blasffi.c
cl /P /C /IC:\OpenCL\include /DCL_TARGET_OPENCL_VERSION=120 openclffi.c
cl /P /C /IC:\OpenCL\include /IC:\OpenCL\CLBlast-1.5.2-Windows-x64\include clblastffi.c
