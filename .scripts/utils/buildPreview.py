from PIL import Image, ImageDraw, ImageFont

PREVIEW_FONT = r'c:\Windows\Fonts\seguibl.ttf'

def buildPreview(backgroundImage: Image, overlayImage: Image, text: str):
	img = backgroundImage.convert('RGBA').resize((512, 512))
	img.alpha_composite(Image.new('RGBA', (512,512), (0, 0, 0, 80)))
	img.alpha_composite(overlayImage)

	draw = ImageDraw.Draw(img)
	size = 70
	font = None
	w = 0
	h = 0

	while True and size > 10:
		font = ImageFont.truetype(PREVIEW_FONT, size)
		left, top, right, bottom = font.getbbox(text)
		w = right - left
		h = bottom - top

		if w > 500:
			size -= 10
		else:
			break

	draw.multiline_text((256 - w / 2, 350 - h / 2), text, font = font, fill=(255,255,255,200), align ="center") 

	return img
