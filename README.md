OCS must-gather
=================

`ocs-must-gather` is a tool built on top of [OpenShift must-gather](https://github.com/openshift/must-gather)
that expands its capabilities to gather Openshift Container Storage 4 information.

### Usage
```sh
oc adm must-gather --image=ashishranjan738/ocs-must-gather
```

The command above will create a local directory with a dump of the ocs state.
Note that this command will only get data related to the ocs part of the OpenShift cluster.

You will get a dump of:
- The OCS Operator namespaces (and its children objects)
- All namespaces (and their children objects) that belong to any ocs resources
- All ocs CRD's definitions
- All namspaces that contains ceph and noobaa

In order to get data about other parts of the cluster (not specific to ocs) you should
run `oc adm must-gather` (without passing a custom image). Run `oc adm must-gather -h` to see more options.