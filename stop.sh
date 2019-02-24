gc=$1
uuid=`sudo rkt list | grep xhprof | grep running | cut -d$'\t' -f1`

if [[ ! -z $uuid ]]
then
  echo "Stopping pod: "$uuid
  sudo rkt stop $uuid
else
  echo "Pod is not running."
fi

if [[ ! -z $gc ]]
then
  sudo rkt gc --grace-period=0s
fi
