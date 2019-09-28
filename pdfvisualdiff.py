#!/usr/bin/env python

# Required for zip_longest
from future import standard_library
standard_library.install_aliases()

import sys
from pathlib import Path
from itertools import zip_longest

from consolemsg import step, warn

def step(*args): pass


def buildDiffPdf(a, b, overlay, output, **params):
	import PyPDF2
	from io import open, BytesIO

	if overlay:
		overlayfile = BytesIO(overlay)

	step("Building diff pdf")
	def pages(reader):
		for i in range(reader.getNumPages()):
			yield reader.getPage(i)

	with \
		a.open('rb') as afile, \
		b.open('rb') as bfile, \
		output.open('wb') as outputfile \
		:
		areader = PyPDF2.PdfFileReader(afile)
		breader = PyPDF2.PdfFileReader(bfile)
		diffreader = PyPDF2.PdfFileReader(overlayfile)
		writer = PyPDF2.PdfFileWriter()
		# TODO: zip_longest instead of zip and manage Nones
		def blankLike(otherPage):
			return PyPDF2.pdf.PageObject.createBlankPage(
				width=otherPage.mediaBox.getUpperRight_x(),
				height=otherPage.mediaBox.getLowerRight_y(),
			)

		for apage, bpage, diffpage in zip_longest(pages(areader), pages(breader), pages(diffreader)):
			step(" Building page")
			apage = apage or blankLike(bpage)
			bpage = bpage or blankLike(apage)
			xoffset = apage.mediaBox.getUpperRight_x()
			apage.mergeTranslatedPage(bpage, xoffset, 0, True)
			apage.mergeTranslatedPage(diffpage, 0, 0, True)
			apage.mergeTranslatedPage(diffpage, xoffset, 0, True)
			writer.addPage(apage)
		step(" Writing pdf")
		writer.write(outputfile)

def centeredText(page, text):
	"Draws a centered text in the middle of a page"
	page.alpha_channel='activate'
	page.opaque_paint('black', 'rgba(240,255,255,.4)', channel='all_channels')
	from wand.drawing import Drawing
	with Drawing() as draw:
		draw.fill_color='rgba(255,0,0,1)'
		draw.stroke_color='grey'
		draw.font_size=40
		draw.gravity='center'
		draw.text(0,0,text)
		draw(page)

def highlightDifferences(diffimage):
	diffimage.morphology(method='dilate',kernel='square:2')
	diffimage.negate()
	diffimage.edge(2)
	diffimage.channel='argb'
	diffimage.fill_color='red'
	diffimage.opaque_paint('white', 'red')
	diffimage.alpha_channel='activate'
	diffimage.opaque_paint('black', 'rgba(240,255,255,.4)', channel='all_channels')

def visualDifferences(a, b, diff=None, **params):

	from wand.image import Image
	from wand.display import display
	from wand.image import Image
	from wand.color import Color

	hasdifferences = False
	step("Comparing pdfs")
	step(" Loading pdfs")

	with \
			Image(filename=str(a)) as aimage,\
			Image(filename=str(b)) as bimage:

		step(" Rasterizing pdfs")
		aimage.background_color='white'
		aimage.alpha_channel='remove'
		aimage.format = 'png'
		aPages=len(aimage.sequence)

		bimage.background_color='white'
		bimage.alpha_channel='remove'
		bimage.format = 'png'
		bPages=len(bimage.sequence)
		# TODO: should be max and handle shorter pdf's
		diffpages = []

		for i in range(min(aPages,bPages)):
			step(" Page {}", i)
			with \
					aimage.sequence[i] as apage, \
					bimage.sequence[i] as bpage  \
					:
				diffpage, ndiffs = apage.compare(bpage,
					metric='absolute',
					highlight='white',
					lowlight='black',
					)

				# Not generating diff? be expeditive
				if not diff:
					if ndiffs: return False
					continue

				if ndiffs:
					hasdifferences=True
					warn("Page {} contains {:,.0f} different pixels", i, ndiffs)
					highlightDifferences(diffpage)
				if not ndiffs:
					centeredText(diffpage, "NO DIFFERENCES")
				diffpages.append(diffpage)

		def single(page, text):
			diffpage = Image(background='black', height=apage.height, width=apage.width)
			centeredText(diffpage, "ONLY IN A")
			return diffpage

		for i in range(min(aPages,bPages),aPages):
			warn("Page {} only available in {}", i, a)
			apage = aimage.sequence[i]
			diffpages.append(single(apage, "ONLY IN A"))

		for i in range(min(aPages,bPages),bPages):
			warn("Page {} only available in {}", i, b)
			bpage = bimage.sequence[i]
			diffpages.append(single(bpage, "ONLY IN B"))

	if not hasdifferences: return True
	if not diff: return False

	with Image() as diffimage:
		diffimage.alpha_channel='set'
		diffimage.sequence += diffpages
		diffimage.format='pdf'
		diff_overlay = diffimage.make_blob()

	buildDiffPdf(a,b,diff_overlay,diff)

	return False



ejemplos=Path('ejemplos')
a,b = ejemplos.glob('mantenimientos-2018*pdf')
a,b = ejemplos.glob('factura*pdf')
a,b = (Path(x) for x in sys.argv[1:3])
diff = ejemplos / 'diff.pdf'
output = Path('output.pdf')

print(visualDifferences(a,b,output))



