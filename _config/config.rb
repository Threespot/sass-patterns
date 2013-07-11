# Sass configuration

http_path = "/"
css_dir = "static/css"
sass_dir = "static/scss"
images_dir = "static/images"
javascripts_dir = "static/js"
fonts_dir = "static/font"

output_style = (environment == :production) ? :compact : :expanded
line_comments = (environment == :production) ? false : true
color_output = false

preferred_syntax = :scss
