permissionset 51000 "HONDA CRM USER"
{
    Assignable = true;
    Caption = 'HONDA CRM USER';
    Permissions =
        tabledata "Honda Dealer" = R,
        tabledata "Honda Vehicle Model" = R,
        tabledata "Honda Vehicle Variant" = R,
        tabledata "Honda Opp. Vehicle Line" = RIMD,
        tabledata "Honda CRM Activity" = RIMD,
        tabledata "Honda Opp. Status Entry" = R;
}
