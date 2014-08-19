To deploy on gray.clhn.org - just push to github

To deploy on http://www.econ.iastate.edu/~gcalhoun,
1. Change the urls in _layouts/default.html to `/~gcalhoun`
2. Run `jekyll build`
3. run
    scp -r _site/* gcalhoun@econ22.econ.iastate.edu:public_html