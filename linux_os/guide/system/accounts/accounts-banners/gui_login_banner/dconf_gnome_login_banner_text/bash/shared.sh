# platform = Red Hat Enterprise Linux 7, multi_platform_fedora
. /usr/share/scap-security-guide/remediation_functions
populate login_banner_text

include_dconf_settings

expanded=$(echo "$login_banner_text" | sed 's/(\\\\\x27)\*/\\\x27/g;s/(\\\x27)\*//g;s/(\\\\\x27)/tamere/g;s/\^(\(.*\)|.*$/\1/g;s/\[\\s\\n\][+*]/ /g;s/\\//g;s/(n)\*/\\n/g;s/\x27/\\\x27/g;')

dconf_settings 'org/gnome/login-screen' 'banner-message-text' "string '${expanded}'" 'gdm.d' '00-security-settings'
dconf_lock 'org/gnome/login-screen' 'banner-message-text' 'gdm.d' '00-security-settings-lock'
