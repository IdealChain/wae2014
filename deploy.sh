#!/bin/bash
me=`basename $0`
tar czf - --exclude=$me * | ssh wae07@weng.culturall.com "tar xzf - && ls -lht && mysql -vvv < database.sql"
