sudo virsh list --all | grep -Eo '([[:alnum:]_]+-[[:alnum:]_]+-[[:alnum:]_]+-[[:alnum:]_]+-[[:alnum:]_]+)|([[:alnum:]_]+)' | xargs -I {} sudo virsh destroy {}; sudo virsh undefine {}
virsh list --all | awk '{if(NR>2) sudo virsh destroy $2}'


for vm in $(virsh list --all | awk '{if(NR>2) print $2}'); do virsh shutdown $vm; done
for vm in $(virsh list --all | awk '{if(NR>2) print $2}'); do sudo virsh destroy $vm; done


sudo virsh net-list --all | grep -Eo '([[:alnum:]_]+-[[:alnum:]_]+-[[:alnum:]_]+-[[:alnum:]_]+-[[:alnum:]_]+)|([[:alnum:]_]+)' | xargs -I {} sudo virsh net-destroy {}; sudo virsh net-undefine {}
