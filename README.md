# Business Ralliart Configuration Management 

## Chef

### Install berkshelf

まずはこちらを実施

<http://http://nokogiri.org/tutorials/installing_nokogiri.html>

Mac OS

    [root@example ~]# port install libxml2 libxslt
    [root@example ~]# gem install berkshelf
    

Linux

    [root@example ~]# sudo yum install -y gcc ruby-devel libxml2 libxml2-devel libxslt libxslt-devel
    [root@example ~]# gem install berkshelf
 

インストール後の確認

    [root@example ~]# berks -v
      
### Import opscode recipes

    [root@example ~]# cd cehf-repo
    [root@example chef-repo]# berks install -p cookbooks
    [root@example chef-repo]# ls cookbooks

