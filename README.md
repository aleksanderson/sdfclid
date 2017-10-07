sdfcld
=============

``Currently supports 2017.2``

Docker image for NetSuite SDF CLI packages all the nesessary dependencies nesessary to instal and run SuiteCloud Development Framework CLI.

Usage
-----

```
echo $NS_PASSWORD | \
docker run -i -v LOCAL_PROJECT_DIR:IMAGE_PROJECT_DIR \
"sdfcli [...arguments]"
```

* $NS_PASSWORD - account's password to be passed to the sdfcli which promts for it each time th command run
* "sdfcli [...arguments]" - script provided by NetSuite suplimental package and all standard CLI arguments specified in the official NetSuite's documentation. 

**NOTE:** container uses ```/bin/bash -c``` as it's ENTRYPOINT, therefore sdfcli command and arguments should be wraped into ```""```. This will allow to run multiple commands under the same session of the container.

```
echo $NS_PASSWORD | \
docker run -i -v LOCAL_PROJECT_DIR:IMAGE_PROJECT_DIR \
"\
  sdfcli project -p /path/to/project; \
  sdfcli validate
"
```

TODO
----
* Build an executable jar to call it directly from the ``sdfcli`` script
