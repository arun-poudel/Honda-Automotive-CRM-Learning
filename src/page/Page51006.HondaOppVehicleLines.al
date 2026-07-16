page 51006 "Honda Opp. Vehicle Lines"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Honda Opp. Vehicle Line";
    Caption = 'Honda Opp. Vehicle Lines';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Opportunity No."; Rec."Opportunity No.") { ApplicationArea = All; }
                field("Line No."; Rec."Line No.") { ApplicationArea = All; }
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
