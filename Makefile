PACKAGE_SOURCES := $(wildcard ./src/*.typ)
DOCUMENTATION_SOURCES := $(wildcard ./docs/*.typ)

THUMBNAILS := docs/lighten-th.png
TIMELINE_IMAGES := docs/underline-timeline.png docs/lighten-timeline.png
EXAMPLES := docs/example-underline.pdf docs/example-lighten.pdf
EXAMPLES_IMAGES := docs/example-underline.png docs/example-lighten.png

.PHONY: all
all: $(THUMBNAILS) $(TIMELINE_IMAGES) $(EXAMPLES) $(EXAMPLES_IMAGES)

docs/example-%.pdf: docs/example-%.typ docs/example.typ $(PACKAGE_SOURCES)
	typst compile --root $(PWD) $< $@

docs/example-%.png: docs/example-%.pdf
	pdftoppm $< $(patsubst %.png,%,$@) -png -singlefile

docs/%-timeline.png : docs/example-%.png
	convert $< -crop 520x60+60+440 $@

docs/%-th.png: docs/example-%.png
	convert $< -thumbnail 500x $@

clean:
	rm --force docs/*.pdf
	rm --force docs/*.png
