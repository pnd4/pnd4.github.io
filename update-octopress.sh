#!/bin/bash

git pull octopress master     # Get the latest Octopress
bundle install                # Keep gems updated
bundle exec rake update_source            # update the template's source
bundle exec rake update_style             # update the template's style
