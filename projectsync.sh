#!/usr/bin/bash

PID="/usr/sbin/projectsync/pid"

echo 1 > ${PID}

if [ -e $PID ]; then
        line=$(cat ${PID})
                while [ ${line} -gt 0 ]; do
                        /usr/bin/inotifywait -e modify,create,delete -r /var/lib/awx/projects && \
                        for i in `cat /usr/sbin/projectsync/host`; do /usr/bin/rsync -raluSHog --delete-after --ignore-errors --force /var/lib/awx/projects/ $i:/var/lib/awx/projects/; done

                        line=$(cat ${PID})

                done

else
        echo "PID file does not exist"
fi

##DATABASE REPLICATION

#!/usr/bin/bash

PID="/usr/sbin/projectsync/pid"

echo 1 > ${PID}

if [ -e $PID ]; then
        line=$(cat ${PID})
                while [ ${line} -gt 0 ]; do
                        /usr/bin/inotifywait -e modify,create,delete -r /var/lib/pgsql/data && \
                        for i in `cat /usr/sbin/projectsync/host`; do /usr/bin/rsync -raluSHog --delete-after --ignore-errors --force /var/lib/pgsql/data/ $i:/var/lib/pgsql/data/; done

                        line=$(cat ${PID})

                done

else
        echo "PID file does not exist"
fi
