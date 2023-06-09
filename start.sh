#!/bin/sh
# if [ ! -f /tmp/cmsrevalidate-$(date +%Y%m%d) ]; then
    php -f check_revalidate.php
# Draft claim email disabled by commenting below:
#    npm run draft
    touch /tmp/cmsrevalidate-$(date +%Y%m%d)
# else
    # echo "We have run the script today. Skip."
fi