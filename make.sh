#!/bin/bash

jekyll build && \
  cd _site && \
  git add . && \
  git commit -m "Update" && \
  git push origin master && \
  cd .. && \
  echo "Successfully built and pushed to GitHub."
