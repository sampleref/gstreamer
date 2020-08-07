1. Added new else if condition in libnice 0.1.15   /agent/interfaces.c

2. else if ((fixed_interface = getenv("NET_IFACE_PREFIX")) != NULL) {
        if(g_str_has_prefix (ifa->ifa_name, fixed_interface)) {
            if (nice_interfaces_is_private_ip (ifa->ifa_addr))
              ips = add_ip_to_list (ips, addr_string, TRUE);
            else
              ips = add_ip_to_list (ips, addr_string, FALSE);
        } else{
            nice_debug ("Ignoring interface %s as it does not matches prefix %s",
                ifa->ifa_name, fixed_interface);
        }
    }
    
        
3. It shall use the interface only which has prefix as defined by 
   environment variable 'NET_IFACE_PREFIX'
   
4. Built on nas2docker/gstreamer_grpc:1.3