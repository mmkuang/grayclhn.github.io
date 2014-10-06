#! /usr/bin/bash

jekyll build
rm _site/feed.xml
scp -r _site/* gcalhoun@econ22.econ.iastate.edu:public_html
