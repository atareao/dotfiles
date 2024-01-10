function minify --descrition="compile scss to css"
    # Compile scss to css
    # Minify css
    if test -f style.scss
        sass style.scss style.css
        cp style.min.css ../style.css
    end
end
