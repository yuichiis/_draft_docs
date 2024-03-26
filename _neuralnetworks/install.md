Operating environment
---------------------
Rindow Neural Networks has been tested in the following operating environments:

・PHP 8.1, 8.2, 8.3 (When using in PHP 7.x, 8.0 environment, please use Release 1.x.)
- Windows 10 20H2 or later.
- Ubuntu 20.04, 22.04
- AMD/Intel CPU/APU 64bit (SSE2 or later)
- OpenBLAS (0.3.20 Windows-x64, 0.3.20 Ubuntu-2204, 0.3.8 Ubuntu-2004)
- CLBlast (1.5.2 or later, Windows-x64, Ubuntu-2204, Ubuntu-2004)

It also works with Intel/AMD CPU/APU and integrated graphics with OpenCL drivers.

Installation instructions for Windows
----------------------------------
Installing PHP

For Windows 10/11, install PHP for Windows.

+ Download the PHP x64 version from https://windows.php.net/download/. Either Non Thread Safe or Thread Safe version is fine.
+ Extract to a location of your choice.
+ Create php.ini by copying php.ini-development.
+ Set execution PATH for PHP.EXE.
+ Make sure PHP works with PHP -v.

```shell
C:TEMP>COPY C:\php\php.ini-development C:\php\php.ini
Edit php.ini to your liking.

C:TEMP>PATH %PATH%;C:\php
C:TEMP>php -v
PHP 8.3.4 (cli) (built: Mar 13 2024 11:42:47) (NTS Visual C++ 2019 x64)
Copyright (c) The PHP Group
Zend Engine v4.3.4, Copyright (c) Zend Technologies
    with Zend OPcache v8.3.4, Copyright (c), by Zend Technologies
C:TEMP>
```

Install the PHP extensions required by Rindow Neural Networks.

+ Download and unzip the corresponding pre-built binary file from https://github.com/xianyi/OpenBLAS/releases.
+ Download and unzip the corresponding pre-built binary file from https://github.com/rindow/rindow-matlib/releases.
+ Set the OpenBLAS and Rindow-Matlib DLL paths to the execution path.
+ Make the necessary settings in php.ini.
      - memory_limit = 8G
      - extension = ffi
      - extension=gd
      - extension = mbstring
      - extension=openssl
      - extension=pdo_sqlite
      - extension=zip
+ Make sure PHP extensions are loaded with PHP -m.


```shell
C:TEMP>PATH %PATH%;C:\OpenBLAS\OpenBLAS-0.3.26-x64\bin
C:TEMP>PATH %PATH%;C:\Matlib\rindow-matlib-1.0.0-win64\bin

Edit php.ini

C:TEMP>php -m
[PHP Modules]
...
ffi
...
pdo_sqlite
...
C:TEMP>
```

Install Rindow Neural Networks.

+ Create your project directory.
+ Install rindow/rindow-neuralnetworks with composer.
+ Install rindow/rindow-math-matrlix-matlibffi with composer to speed up.
+ Install rindow/rindow-math-plot with composer for graph display.
+ Run the sample to see if it works.
+ The results are displayed graphically.

