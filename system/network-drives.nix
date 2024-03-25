{...}:
{
  fileSystems."/mnt/csi/IT" =
    { device = "//10.1.1.65/csi-data$/IT";
      fsType = "cifs";
      options = ["credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
    };
  fileSystems."/mnt/csi/Project" =
    { device = "//10.1.1.65/csi-data$/Project";
      fsType = "cifs";
      options = ["credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
    };
  fileSystems."/mnt/csi/Rockwell" =
    { device = "//10.1.1.65/csi-data$/Rockwell";
      fsType = "cifs";
      options = ["credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
    };
  fileSystems."/mnt/csi/Approved Documents" =
    { device = "//10.1.1.65/csi-data$/Approved Documents";
      fsType = "cifs";
      options = ["credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
    };
}
