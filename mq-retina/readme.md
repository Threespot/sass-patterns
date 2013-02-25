# Retina Media Query Mixin

## The Mixin:

	@mixin retina-display {
		@media only screen and 
		(-webkit-min-device-pixel-ratio: 2), 
		(min-resolution: 192dpi) { 
			@content;
		}
	}

Pretty straightforward: only delivers content if browser has a high display density.

MQ Attribution: [CSS Tricks](http://css-tricks.com/snippets/css/retina-display-media-query/)