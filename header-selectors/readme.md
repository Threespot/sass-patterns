# Write Out Heading Selectors

Attribution: [Rowan Manning](http://jsfiddle.net/uD2pp/1/)

History: Initially from [Harry Roberts] (http://jsfiddle.net/csswizardry/NbLg7/). Modified by Rowan Manning (http://jsfiddle.net/uD2pp/1/). Thread for topic on Twitter (https://twitter.com/csswizardry/status/307089868943654912).

The version below has been modified by Ted to fix a validation error and for readability (http://codepen.io/tedw/pen/yLfdg).

## The Mixin

	@mixin headings( $start: 1, $end: 6 ) {
		$heading-selectors: ();
		@for $i from $start through $end {
			$heading-selectors: append( $heading-selectors, h + $i, comma );
		}
		#{$heading-selectors} {
			@content
		}
	}

## Usage

###Sass:
    @include headings() {
        font-family: sans-serif;
    }
    
    div{
        @include headings(1, 3) {
            color: #BADA55;
        }
    }

###CSS:

	h1, h2, h3, h4, h5, h6 {
	  font-family: sans-serif;
	}

	div h1, div h2, div h3 {
	  color: #BADA55;
	}

You can add styles for all headings by providing no parameters. You can limit the styles to only certain headings by adding parameters.
