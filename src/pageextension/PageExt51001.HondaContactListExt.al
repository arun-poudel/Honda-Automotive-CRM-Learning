pageextension 51001 "Honda Contact List Ext." extends "Contact List"
{
    layout
    {
        addlast(Control1)
        {
            field("Honda Lead Source"; Rec."Honda Lead Source") { ApplicationArea = All; }
            field("Honda Preferred Dealer Code"; Rec."Honda Preferred Dealer Code") { ApplicationArea = All; }
            field("Honda Product Category"; Rec."Honda Product Category") { ApplicationArea = All; }
            field("Honda Preferred Model Code"; Rec."Honda Preferred Model Code") { ApplicationArea = All; }
        }
    }
}
