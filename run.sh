dir=`pwd`
source_dir=$dir"/src"
image=$dir"/xhprof.aci"

echo $dir

sudo systemd-run --slice=machine rkt --insecure-options=image run $image --volume localhost,kind=host,source=$source_dir
