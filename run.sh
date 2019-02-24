dir=`pwd`
dir=$dir"/src"

echo $dir

sudo rkt --insecure-options=image run xhprof.aci --volume localhost,kind=host,source=$dir
