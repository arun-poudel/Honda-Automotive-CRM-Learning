page 51005 "Honda Opp. Vehicle Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Honda Opp. Vehicle Line";
    Caption = 'Vehicle Interest';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Model Code"; Rec."Model Code") { ApplicationArea = All; }
                field("Model Description"; Rec."Model Description") { ApplicationArea = All; }
                field("Variant Code"; Rec."Variant Code") { ApplicationArea = All; }
                field("Variant Description"; Rec."Variant Description") { ApplicationArea = All; }
                field("Product Category"; Rec."Product Category") { ApplicationArea = All; }
                field("Preferred Color"; Rec."Preferred Color") { ApplicationArea = All; }
                field(Quantity; Rec.Quantity) { ApplicationArea = All; }
                field("Estimated Unit Price"; Rec."Estimated Unit Price") { ApplicationArea = All; }
                field("Estimated Line Amount"; Rec."Estimated Line Amount") { ApplicationArea = All; }
                field("Primary Interest"; Rec."Primary Interest") { ApplicationArea = All; }
                field(Remarks; Rec.Remarks) { ApplicationArea = All; }
            }
        }
    }
}
