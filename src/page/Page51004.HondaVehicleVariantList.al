page 51004 "Honda Vehicle Variant List"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Honda Vehicle Variant";
    Caption = 'Honda Vehicle Variant List';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Model Code"; Rec."Model Code") { ApplicationArea = All; }
                field(Code; Rec.Code) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Model Year"; Rec."Model Year") { ApplicationArea = All; }
                field("Fuel Type"; Rec."Fuel Type") { ApplicationArea = All; }
                field("Transmission Type"; Rec."Transmission Type") { ApplicationArea = All; }
                field("Color Description"; Rec."Color Description") { ApplicationArea = All; }
                field("Unit Price"; Rec."Unit Price") { ApplicationArea = All; }
                field(Active; Rec.Active) { ApplicationArea = All; }
                field(Blocked; Rec.Blocked) { ApplicationArea = All; }
            }
        }
    }
}
