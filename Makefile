
VERSION=0.75
FILES=$(shell ls usr/share/applications/*.desktop usr/share/pixmaps/*.xpm usr/share/icons/*.png usr/share/icons/64x64/apps/*.png usr/local/bin/* usr/share/menu/* | grep -v CVS | grep -v Root | grep -v Entries | grep -v Repository) 

all: 
	rm -rf debian
	mkdir -p debian/DEBIAN
	cat control | sed -e 's%VERSION%${VERSION}%' >debian/DEBIAN/control
	cat postinst | sed -e 's%FILES%${FILES}%' >debian/DEBIAN/postinst
	cp postrm debian/DEBIAN
	chmod 755 debian/DEBIAN/postinst
	chmod 755 debian/DEBIAN/postrm
	tar --exclude=CVS -c -f - usr | (cd debian; tar xf -)
	find ./debian -type d | xargs chmod 755   
	dpkg-deb --build debian
	mv debian.deb winstart_${VERSION}_all.deb
	

clean:
	rm *.deb
	find . -name "*~" -exec rm {} \;
