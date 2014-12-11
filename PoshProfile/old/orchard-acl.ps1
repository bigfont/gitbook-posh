
# Set-ExecutionPolicy RemoteSigned

cls

$folder =  'C:\Users\BigFont\Documents\GitHub\2014-118EI-001\Orchard.Source.1.8.1\build\Precompiled'
$acl = Get-Acl $folder
$targetUser = 'BUILTIN\IIS_IUSRS';

# remove rule
Foreach($ar in $acl.access)
{    
    if($ar.IdentityReference.Value -eq $targetUser)
    {
        $acl.RemoveAccessRule($ar) | out-null;
    }
}

# todo make this more specific
# root
# App_Data
# Media
# Themes
# Modules

$identity = new-object System.Security.Principal.NTAccount($targetUser);
$fileSystemRights = [System.Security.AccessControl.FileSystemRights]"FullControl"; # the new permissions will only show up in Advanced security.

# ContainerInherit: permissions pass down to decendent directories
# None: permission do not pass down to any descendents
# ObjectInherit: permission pass down to descendent files
$inheritanceFlags = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit";

# significant only if InheritanceFlags are present
# InheritOnly: permission apply only to descendents (not to the parent!!)
# None: no flags
# NoPropagateInherit: permissions do not pass down to any descendents
$propagationFlags = [System.Security.AccessControl.PropagationFlags]::None;
$type = [System.Security.AccessControl.AccessControlType]::Allow;

$ar = New-Object system.security.accesscontrol.filesystemaccessrule($identity,$fileSystemRights,$inheritanceFlags,$propagationFlags, $type)
$acl.AddAccessRule($ar);

# save
Set-Acl -path $folder -AclObject $acl

# view results 
write-host ($acl | Format-List | Out-String)