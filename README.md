ESXi Tools For OS X
==========

VMRC (VMware Remote Control) Tool
---------------------------------

### 1. Install VMRC
    Goto https://www.vmware.com/support/developer/vmrc/
    Login to VMware and download "VMRC installer"
    Follow instruction to install "VMRC"

### 2. Install VMRC Tools
    git clone https://github.com/pantc12/ESXi_Tools.git
    cd ESXi_Tools
    cp vmrc.sh /usr/local/bin/vmrc
    chmod +x /usr/local/bin/vmrc
    source /usr/local/bin/

### 3. Use it
    List all VMs on ESXi Server - vmrc [ list-vms | -l ] [user@]host[:port]
    Connect to a VM Console on ESXi Server - vmrc [ connect | -c ] [user@]host[:port]

### Uninstall
	rm /usr/local/bin/vmrc
	
Developers
----------
* [PTC](https://github.com/pantc12)
