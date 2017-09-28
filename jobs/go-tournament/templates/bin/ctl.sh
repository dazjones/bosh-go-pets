#!/bin/bash

APP_DIR=/var/vcap/sys/run/bosh-go-pets
LOG_DIR=/var/vcap/sys/log/bosh-go-pets
PIDFILE=${APP_DIR}/pid
RUN_USER=vcap

case $1 in

    start)
        mkdir -p $APP_DIR $LOG_DIR
        chown -R $RUN_USER:$RUN_USER $APP_DIR $LOG_DIR

        echo $$ > $PIDFILE

        cd /var/vcap/packages/go-pets

        exec /var/vcap/packages/go-pets/bin/go-pets \
            >>  $LOG_DIR/bosh_go-pets.stdout.log \
            2>> $LOG_DIR/bosh_go-pets.stderr.log

        ;;

    stop)
        kill -9 `cat $PIDFILE` && rm -f $PIDFILE
        ;;

    *)
        echo "Usage: ctl {start|stop}" ;;

    esac
