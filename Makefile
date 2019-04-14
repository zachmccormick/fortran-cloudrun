FLIBS=flibs-0.9/src

FORTRAN=gfortran
FORTRANFLAGS=-ldl -lfcgi -pthread -Wl,-rpath -Wl,/usr/lib

OBJECTS = \
	cgi_protocol.o \
	fcgi_protocol.o

fortran_fcgi: fortran_fcgi.f90 $(OBJECTS)
	$(FORTRAN) -o $@ $^ $(FORTRANFLAGS)

cgi_protocol.o: $(FLIBS)/cgi/cgi_protocol.f90
	$(FORTRAN) -c $<

fcgi_protocol.o: $(FLIBS)/cgi/fcgi_protocol.f90
	$(FORTRAN) -c $<

clean:
	rm -f -v fortran_fcgi *.o *.mod

.PHONY: clean
