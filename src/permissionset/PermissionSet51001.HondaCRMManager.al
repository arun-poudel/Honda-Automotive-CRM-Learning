permissionset 51001 "HONDA CRM MANAGER"
{
    Assignable = true;
    Caption = 'HONDA CRM MANAGER';
    IncludedPermissionSets = "HONDA CRM USER";
    Permissions =
        tabledata "Honda Dealer" = RIMD,
        tabledata "Honda Vehicle Model" = RIMD,
        tabledata "Honda Vehicle Variant" = RIMD,
        tabledata "Honda Opp. Status Entry" = RIMD;
}
