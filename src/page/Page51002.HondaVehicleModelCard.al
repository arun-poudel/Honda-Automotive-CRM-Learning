page 51002 "Honda Vehicle Model Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Honda Vehicle Model";
    Caption = 'Honda Vehicle Model Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Make Code"; Rec."Make Code") { ApplicationArea = All; }
            }
            group(ProductInformation)
            {
                Caption = 'Product Information';
                field("Product Category"; Rec."Product Category") { ApplicationArea = All; }
                field("Model Year"; Rec."Model Year") { ApplicationArea = All; }
            }
            group(Pricing)
            {
                Caption = 'Pricing';
                field("Starting Price"; Rec."Starting Price") { ApplicationArea = All; }
            }
            group(Integration)
            {
                Caption = 'Integration';
                field("Item No."; Rec."Item No.") { ApplicationArea = All; }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field(Active; Rec.Active) { ApplicationArea = All; }
                field(Blocked; Rec.Blocked) { ApplicationArea = All; }
                field("Last Date Modified"; Rec."Last Date Modified") { ApplicationArea = All; }
            }
            part(Variants; "Honda Vehicle Variant List")
            {
                Caption = 'Variants';
                ApplicationArea = All;
                SubPageLink = "Model Code" = field(Code);
                UpdatePropagation = Both;
            }
        }
    }
}
