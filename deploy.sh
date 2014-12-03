#!/bin/bash
me=`basename $0`
tar czf - --exclude=$me * | ssh wae07@weng.culturall.com 'tar xzf - && echo "Deployed:" && ls -lhtR && cat db-schema.sql db-dataseeder.sql | mysql -vvv && mysql -e "show tables like \"wae07%\""'
