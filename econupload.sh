#! /usr/bin/bash

jekyll build
scp -r _site/* gcalhoun@econ22.econ.iastate.edu:public_html
