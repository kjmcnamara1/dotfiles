# Partition Disk

List partitions

```sh
fdisk -l
```

Start fdisk for intended block device

```sh
fdisk /dev/nvme0n1

# Create new GPT partition table
g

# Create new EFI System partition
n
1       # Partition number (default)
        # First sector (default)
+512M   # Last sector (size = 512M)
y       # Remove vfat signature
# Change partition type to EFI System
t       # Selected partition 1
1       # EFI System

# Create new Linux filesystem partition
n
2       # Partition number (default)
        # First sector (default)
+100G   # Last sector (size = 100G)

# Create new home partition
n
3       # Partition number (default)
        # First sector (default)
        # Last sector (default)
# Change partition type to Linux home
t
3       # Partition number 3
42      # Linux home

# Print partition table
p
# Write partition table and exit fdisk
w
```
