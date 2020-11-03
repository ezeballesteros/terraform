##########
# Compute
##########
resource "proxmox_vm_qemu" "proxmox_vm" {
    count             = 1
    name              = var.name
    target_node       = "ebsr001"
    clone             = var.image
    clone_wait        = 15
    os_type           = "cloud-init"
    cores             = var.cores
    sockets           = "1"
    cpu               = "host"
    memory            = var.memory
    scsihw            = "virtio-scsi-pci"
    bootdisk          = "scsi0"

    # Disk
    disk {
        id              = 0
        size            = var.disk_size
        format          = "qcow2"
        type            = "scsi"
        storage         = "data"
        storage_type    = "dir"
        iothread        = true
    }

    # Network
    network {
        id              = 0
        model           = "virtio"
        bridge          = "vmbr1"
        firewall        = false
        link_down       = false
        macaddr         = var.mac
    }

    # Cloud Init Settings
    ciuser              = var.default_user
    ipconfig0           = "ip=${var.ip}/24,gw=192.168.12.1"
    sshkeys             = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvE/yp7velX6f/D5q+n9+z33D5baPc3o53gZqfKsk3xC39NtqXHH6kzatlfVl2Ej76UODpr3JDWs3i895YhMzz3FR/adHZ0dbJLMe8YDe9RpEv0l4OopSfj5cx549wFZxcJSp2wGpIE2n0hiSmmCrbTH35AueLjmMxx7y68+FC1fnY1l4HqgzjwR91T+8dfPxsmzZCXuJ6LQBmhFIt7VngW6Kqo2AlaEx0kn5IwnvwQg5TeU/gaeSFGaXeRyYpjb95BqgLpVYVe3CbFEb7b4inVuVlB1EKegb9xRVKN7kFGodhZu01tkd0I/aj1t+hFtHOe7orVrkFK+5zIOfb18fIQ== root@ebkey
    EOF
}

##########
# Outputs
##########
output "InstanceName" {
  value = [proxmox_vm_qemu.proxmox_vm[0].name]
}
output "InstanceIP" {
  value = [proxmox_vm_qemu.proxmox_vm[0].ssh_host]
}
