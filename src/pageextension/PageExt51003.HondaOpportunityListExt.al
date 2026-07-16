pageextension 51003 "Honda Opportunity List Ext." extends "Opportunity List"
{
    layout
    {
        addlast(Control1)
        {
            field("Honda Dealer Code"; Rec."Honda Dealer Code") { ApplicationArea = All; }
            field("Honda CRM Stage"; Rec."Honda CRM Stage") { ApplicationArea = All; }
            field("Honda Result"; Rec."Honda Result") { ApplicationArea = All; }
            field("Honda Primary Model Code"; Rec."Honda Primary Model Code") { ApplicationArea = All; }
            field("Honda Primary Variant Code"; Rec."Honda Primary Variant Code") { ApplicationArea = All; }
        }
    }
}
