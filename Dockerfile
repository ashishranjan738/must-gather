FROM quay.io/openshift/origin-must-gather:latest

RUN sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/subscription-manager.conf \
    && cat /etc/yum/pluginconf.d/subscription-manager.conf \
    && sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/ovl.conf && cat /etc/yum/pluginconf.d/ovl.conf \
    && sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/product-id.conf && cat /etc/yum/pluginconf.d/product-id.conf \
    && sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/search-disabled-repos.conf && cat /etc/yum/pluginconf.d/search-disabled-repos.conf \
    && rm -rf /etc/yum.repos.d/*

COPY Centos-Base.repo  /etc/yum.repos.d/
COPY .cephmedic.conf /root/.cephmedic.conf

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
    && yum -y update \
    && yum -y install python36u python36u-libs python36u-devel python36u-pip \
    && ln -s /usr/bin/python3.6 /usr/bin/python3 \
    && curl -LO https://github.com/ceph/ceph-medic/archive/master.tar.gz && tar xvzf master.tar.gz \ 
    && cd ceph-medic-master && python3.6 setup.py install \
    && rm -rf ceph-medic-master master.tar.gz

# Save original gather script
RUN mv /usr/bin/gather /usr/bin/gather_original

# copy all collection scripts to /usr/bin
COPY collection-scripts/* /usr/bin/

ENTRYPOINT /usr/bin/gather