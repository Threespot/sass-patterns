# Write Out Heading Selectors

Attribution: [Rowan Manning](http://jsfiddle.net/uD2pp/1/)

History: Initially from [Harry Roberts] (http://jsfiddle.net/csswizardry/NbLg7/). Modified by Rowan Manning (http://jsfiddle.net/uD2pp/1/). Thread for topic on Twitter (https://twitter.com/csswizardry/status/307089868943654912).

## The Mixin

    @mixin headings($from: 1, $to: 6) {
        $heading-selector: (unquote(""));
        
        @for $i from $from through $to {
            $heading-selector: $heading-selector, unquote("h#{$i}")
        }
        
        #{$heading-selector} {
            @content
        }
    }

## Usage

    @include headings() {
        font-family: sans-serif;
    }
    
    div{
        @include headings(1, 3) {
            color: #BADA55;
        }
    }

You can add styles for all headings by providing no parameters. You can limit the styles to only certain headings by adding parameters.
