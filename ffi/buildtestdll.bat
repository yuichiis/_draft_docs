cl testdll.c /link /dll /out:testdll.dll
cl testdllclient.c testdll.lib
