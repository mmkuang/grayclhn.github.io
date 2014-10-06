#! /usr/bin/bash

jekyll build
rm _site/feed.xml
rm _site/rss -rf
scp -r _site/* gcalhoun@econ22.econ.iastate.edu:public_html
