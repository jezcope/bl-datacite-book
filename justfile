book_dir := "bl_datacite_api"

build:
    jupyter book build {{book_dir}}

clean:
    jupyter book clean {{book_dir}}

serve: clean build
    python -m http.server -d {{book_dir}}/_build/html

console:
    jupyter console

lab:
    jupyter lab
