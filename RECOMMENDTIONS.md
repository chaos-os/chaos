# Suggestions

Below are some of the articles and wiki pages you should read to get
increased performance, security and lower power consumption.

-   <https://wiki.archlinux.org/title/improving_performance>
-   <https://docs.kernel.org/admin-guide/mm/zswap.html>
-   <https://wiki.archlinux.org/title/Partitioning>
-   <https://superuser.com/questions/442383/why-should-i-make-a-separate-partition-for-tmp>
-   <https://wiki.archlinux.org/title/Kernel_module#Blacklisting>
-   <https://wiki.archlinux.org/title/Security>
-   <https://wiki.archlinux.org/title/Btrfs>
-   <https://btrfs.wiki.kernel.org/index.php/Compression>
-   <https://linuxhint.com/btrfs-filesystem-mount-options/>
-   <https://wiki.archlinux.org/title/Power_management#Network_interfaces>

# Recommendations

Below are some of the tweaks that I use and recommend to get
performance, security and lower power consumption.

-   cfs-zen-tweaks
-   install cpu microcode
-   keep seperate /tmp, /var, /, /home partitions
-   install profile-sync-daemon
-   disable wake-on-lan
-   disable watchdog
-   use btrfs with zstd level 15 compression with autodefrag and noatime
    flags
-   setup makepkg to use /tmp to build packages
-   install anything-sync-daemon
-   use linux-zen kernel
-   use swap
-   use /tmp partition with noexec n nosuid flags with the same size as
    the ram
-   use zswap
