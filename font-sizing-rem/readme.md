# Font Sizing w/ Rems Mixin

Attribution: [CSS Tricks](http://css-tricks.com/snippets/css/less-mixin-for-rem-font-sizing/)

## The Mixin: 

	html {
	  font-size: 62.5%;
	}
	@mixin font-size ( $size: 14 ) {
	  font-size: $size + px;
	  font-size: $size/10 + rem; 
	}
	body {
	  @include font-size( 14 ); 
	}

The first part sets the base font-size of the browser to base 10, so that `1.4rem` = `14px` etc. The rest of it just gives you a mixin which creates an accessible rem font declaration with a pixel fallback for old IE. Ideally used with gzipping to counteract repitition. 