# Retina Media Query Mixin

## The Mixin:

	@mixin hires-mq( $ratio ) {
		@media only screen and (-webkit-min-device-pixel-ratio: $ratio), only screen and (min-resolution: ($ratio * 96) + 'dpi') {
			@content;
		}
	}

## Usage

###Sass:

	.hires .logo {
		hires-mq( 2 ) {
			background-image: url('../img/logo@2x.png');
			background-size: 100px 50px;
		}
	}

###CSS:

	@media only screen and (-webkit-min-device-pixel-ratio: 2), only screen and (min-resolution: 192dpi) {
		.hires .logo {
			background-image: url('../img/logo@2x.png');
			background-size: 100px 50px;
		}
	}


**Attribution**: Inspired by [http://www.brettjankord.com/2012/11/28/cross-browser-retinahigh-resolution-media-queries/](http://www.brettjankord.com/2012/11/28/cross-browser-retinahigh-resolution-media-queries/)