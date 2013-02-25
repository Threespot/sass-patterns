# System Ideas

Variables and templates are extremely powerful in Sass. This document is a list of tips and tricks to give you ideas about how Sass could better serve you.

## Descend from Parent Colors

Don't repeatedly type color codes, especially branding colors. You can collect them in a variables file:

```scss
$brandRed: rgb(226,47,51) ;
$brandYellow: rgb(240,179,54);
$brandGreen: rgb(43,163,82);
$branTeal: rgb(12,181,192);
```

Now that you have them in variables, you can do all kinds of fun things by using the parent colors has a baseline for transformations.

`darken()` or `lighten()` colors by a few degrees to create harmonious borders or even entire button systems. If your parent colors ever shift, your system automatically moves along with it.

```scss
.flashMessage {
  // [...]
  &.error {
   background: $brandRed;
   border-top-color: darken($brandRed,5);
   border-bottom-color: darken($brandRed,5);
  }
  &.notice {
    background: darken($brandTeal,5);
    border-top-color: darken($brandTeal,10);
    border-bottom-color: darken($brandTeal,10);
  }
}
```

## Harmonic Padding and Spacing

Set a parent padding for something. Let's say, table cells:

```scss
$tablePadding: 6px;
```

Now you can use Sass math to create harmonious padding systems that scale from a single variable:

```scss
th {
  padding: 0 (2*$tablePadding) $tablePadding (2*$tablePadding);
}
td {
  padding: $tablePadding (2*$tablePadding);
}
```

If you use `2 * $tablePadding` a lot, then just set it to its own variable.

## One Font Family Declaration

Store `font-family` strings in a variable so that you have a single, authoritative location for your font stacks.

```scss
$monospace: Consolas, "Liberation Mono", Courier, monospace;

// elsewhere...
pre, code {
  font-family: $monospace;
}
```

## Create `@extend`-able Blocks for Typekit

Use placeholder templating to store font declarations instead of using Typekit HTML classes everywhere.

```scss
$museoSlab: "museo-slab", "Museo Slab", "American Typewriter", Rockwell, Georgia, serif;

%museo-slab-thin {
  font-family: $museoSlab;
  font-weight: 100;
  font-style: normal;
}

%museo-slab-light {
  font-family: $museoSlab;
  font-weight: 300;
  font-style: normal;
}

%museo-slab-bold {
  font-family: $museoSlab;
  font-weight: 700;
  font-style: normal;
}

// elsewhere...

.button {
  @extend %museo-sans-bold;
}
```


