include INFO

RPMS	= confd \
	  confd-debuginfo

PROD	= products

#
#  all		- Make all targets
#
all:
	( export GOPATH=$(shell pwd) ; \
	  tar xzf src/confd/vendor.tar.gz -C src/confd ; \
	  go build -v -o bin/confd-$(version)-linux-amd64 $(name) )
	( chmod 666 bin/confd-$(version)-linux-amd64 )	
	( ln -s bin $(name)-$(version) ; \
	  tar zcvhf rpm/SOURCES/$(name)-$(version).tar.gz $(name)-$(version) ; \
	  rm $(name)-$(version) )
	( cd rpm ; make all )
	echo "%asset CSDC" >$(PROD)
	echo "%version $(version)-$(release)" >>$(PROD)
	echo "%packaging $(platform).rpm" >>$(PROD)
	for rpm in $(RPMS); do \
		echo "%bundle	rpm/RPMS/$(platform)/$$rpm-$(version)-$(release).$(platform).rpm $$rpm" >>$(PROD); \
	done;

#
#  rpm		- Make SDC RPMs and the product file
#
rpm: all

#
#  upload	- Upload Asset to Nexus
#
upload: $(PROD)
	UploadAsset

#
#  clean	- Cleanup temporary files after build
#
clean:
	( cd rpm ; make clean )
	( rm -f products )
	( rm -f bin/confd-$(version)-linux-amd64 )
	( rm -fr src/confd/vendor )
