# Media Query Labels

This technique allows you to get the currently active media query via JavaScript like this:

	var viewport = window.getComputedStyle(document.body,':after').getPropertyValue('content')

More detailed example in this Gist [https://gist.github.com/tedw/4963703](https://gist.github.com/tedw/4963703)

Working demo page [http://jsbin.com/ufiful/latest](http://jsbin.com/ufiful/latest)

## The Mixin:

	/* Add Breakpoint Labels (for use in JS) */

	$fixed-width: false !default;

	// References:
	// http://adactio.com/journal/5429/
	// http://thesassway.com/intermediate/responsive-web-design-in-sass-using-media-queries-in-sass-32
	// https://github.com/registerguard/js-media-queries

	// Default breakpoints if not defined
	$breakpoints: small,
	              medium 768,
	              large 960 !default;

	// Get number of breakpoints
	$break-count: length($breakpoints);

	// Iterate through breakpoints
	@mixin mq-breakpoints( $font-stack: "'Helvetica Neue', Arial, Helvetica, sans-serif" ) {

		// Fallback label
		html { font-family: "#{nth( nth($breakpoints, 1), 1 )}" }

		// Override <html> inheritance.
		body { font-family: #{$font-stack} }

		body:after {
			content: "#{nth( nth($breakpoints, 1), 1 )}";
			display: none;
		}

		// Get number of breakpoints
		$break-count: length($breakpoints);
	
		// Create index var to use in @each loop
		$index: 1;
	
		// Loop through each breakpoint and generated the appropriate media query code
		// Set the font-family on the pseudo element, as iOS 4 cannot get the CSS content with JS
		@each $break in $breakpoints {
			// First breakpoint
			@if $index == 1 {
				// Get next breakpoint width, subtract 1px
				$max-width: nth( nth($breakpoints, $index + 1), 2 ) - 1;

				@media ( max-width: em( $max-width ) )  {
					html { font-family: '#{nth($break, 1)}' }
					body:after { content: '#{nth($break, 1)}' }
				};
			}
			// Last breakpoint
			@else if $index == $break-count {
				@media ( min-width: em( nth($break, 2) ) ) {
					html { font-family: '#{nth($break, 1)}' }
					body:after { content: '#{nth($break, 1)}' }
				};
			}
			// All other breakpoints
			@else {
				// Get next breakpoint width, subtract 1px
				$max-width: nth( nth($breakpoints, $index + 1), 2 ) - 1;
			
				@media ( min-width: em( nth($break, 2) ) ) and ( max-width: em( $max-width ) ) {
					html { font-family: '#{nth($break, 1)}' }
					body:after { content: '#{nth($break, 1)}' }
				};
			}
		
			// Increment counter
			$index: $index + 1;
		}
	}


## Usage

###Sass:

	@include mq-breakpoints();

###CSS:

	/* Add breakpoint labels for JS purposes */
	html { font-family: "small" }

	body { font-family: 'Helvetica Neue', Arial, Helvetica, sans-serif }

	body:after {
	  content: "small";
	  display: none;
	}

	@media (max-width: 47.9375em) {
	  html { font-family: "small" }
	  body:after { content: "small" }
	}

	@media (min-width: 48em) and (max-width: 59.9375em) {
	  html { font-family: "medium" }
	  body:after { content: "medium" }
	}

	@media (min-width: 60em) {
	  html { font-family: "large" }
	  body:after { content: "large" }
	}

**Attribution**: Inspired by Jeremy Keith's [Conditional CSS](http://adactio.com/journal/5429/) and [The Sass Way](http://thesassway.com/intermediate/responsive-web-design-in-sass-using-media-queries-in-sass-32). For use with [onMediaQuery](https://github.com/registerguard/js-media-queries), developed by Josh Barr and forked by [registerguard](https://github.com/registerguard).