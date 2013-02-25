# Media Query Labels

This technique allows you to get the currently active media query via JavaScript like this:

	var viewport = window.getComputedStyle(document.body,':after').getPropertyValue('content')

More detailed example in this Gist [https://gist.github.com/tedw/4963703](https://gist.github.com/tedw/4963703)

Working demo page [http://jsbin.com/ufiful/latest](http://jsbin.com/ufiful/latest)

## The Mixin:

	/* Add Breakpoint Labels to Body */
	$breakpoints: alpha 320,
	              beta 480,
	              gamma 568,
	              delta 768,
	              epsilon;

	@mixin mq-breakpoints() {
		/* Hide generated content */
		body:after {display: none}
	
		/* Get number of breakpoints */
		$break-count: length($breakpoints);
	
		/* Create index var to use in @each loop */
		$index: 1;
	
		/* Loop through each breakpoint and generated the appropriate media query code */
		/* Set the font-family on the pseudo element, as iOS 4 cannot get the CSS content with JS */
		@each $break in $breakpoints {
			/* First Breakpoint */
			@if $index == 1 {
				@media (max-width: calc-em( nth($break, 2) ))  {
					body:after { font-family: '#{nth($break, 1)}' }
				};
			}
			/* Last Breakpoint */
			@else if $index == $break-count {
				/* Get previous breakpoint width */
				$min-width: nth( nth($breakpoints, $index - 1), 2 ) + 1;
			
				@media (min-width: calc-em( $min-width )) {
					body:after { font-family: '#{nth($break, 1)}' }
				};
			}
			/* All Other Breakpoints */
			@else {
				/* Get previous breakpoint width */
				$min-width: nth( nth($breakpoints, $index - 1), 2 ) + 1;
			
				@media (min-width: calc-em( $min-width )) and (max-width: calc-em( nth($break, 2) )) {
					body:after { font-family: '#{nth($break, 1)}' }
				};
			}
		
			/* Increment counter */
			$index: $index + 1;
		}
	}


## Usage

###Sass:

	@include mq-breakpoints();

###CSS:

	@media (max-width: 20em) {
	  body:after {
	    content: "alpha";
	  }
	}

	@media (min-width: 20.0625em) and (max-width: 30em) {
	  body:after {
	    content: "beta";
	  }
	}

	@media (min-width: 30.0625em) and (max-width: 35.5em) {
	  body:after {
	    content: "gamma";
	  }
	}

	@media (min-width: 35.5625em) and (max-width: 48em) {
	  body:after {
	    content: "delta";
	  }
	}

	@media (min-width: 48.0625em) {
	  body:after {
	    content: "epsilon";
	  }
	}

**Attribution**: Inspired by Jeremy Keith's [Conditional CSS](http://adactio.com/journal/5429/) and [The Sass Way](http://thesassway.com/intermediate/responsive-web-design-in-sass-using-media-queries-in-sass-32)