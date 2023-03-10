cc -shared -fPIC -o libtestdll.so testdll.c
cc -L./ testdllclient.c -o testdllclient.out -ltestdll
