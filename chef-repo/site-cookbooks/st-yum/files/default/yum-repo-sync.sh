#!/bin/sh

yum -y update

cd /var/www/html/yum-repo/

reposync -r base -n -t /var/cache/yum
createrepo base/
reposync -r updates -n -t /var/cache/yum
createrepo updates/
reposync -r extras -n -t /var/cache/yum
createrepo extras/
reposync -r centosplus -n -t /var/cache/yum
createrepo centosplus/
reposync -r contrib -n -t /var/cache/yum
createrepo contrib/
reposync -r debug -n -t /var/cache/yum
createrepo debug/
reposync -r c6-media -n -t /var/cache/yum
createrepo c6-media/
reposync -r epel -n -t /var/cache/yum
createrepo epel/
reposync -r artica_pandorafms -n -t /var/cache/yum
createrepo artica_pandorafms/
reposync -r remi -n -t /var/cache/yum
createrepo remi/
reposync -r rpmforge -n -t /var/cache/yum
createrepo rpmforge/
reposync -r rpmforge-extras -n -t /var/cache/yum
createrepo rpmforge-extras/
reposync -r rpmforge-testing -n -t /var/cache/yum
createrepo rpmforge-testing/
