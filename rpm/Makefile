include ../INFO

all: 
	( sed -e "s/NAME/$(name)/" \
	      -e "s/VERS/$(version)/" \
	      -e "s/RELEASE/$(release)/" \
		SPECS/$(name).src >SPECS/$(name).spec )
	( cd SPECS ; rpmbuild --define "_topdir $(shell pwd)" -ba $(name).spec )

clean:
	rm -fr BUILD
	rm -fr BUILDROOT
	rm -fr RPMS
	rm -fr SOURCES/*
	rm -f  SPECS/*.spec
	rm -fr SRPMS
