#!/usr/bin/env bash

# Usage: ./wget-site.sh [url] [domain]
#  		 ./wget-site.sh https://echo.labstack.com/guide echo.labstack.com 

wget -e robots=off \
	--recursive \
	--no-clobber \
	--page-requisites \
	--html-extension \
	--convert-links \
	--restrict-file-names=windows \
	--domains $2 \
	--no-parent \
		$1
