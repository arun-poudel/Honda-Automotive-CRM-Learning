page 51003 "Honda Vehicle Model List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Honda Vehicle Model";
    CardPageId = "Honda Vehicle Model Card";
    Caption = 'Honda Vehicle Model List';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Product Category"; Rec."Product Category") { ApplicationArea = All; }
                field("Model Year"; Rec."Model Year") { ApplicationArea = All; }
                field("Starting Price"; Rec."Starting Price") { ApplicationArea = All; }
                field(Active; Rec.Active) { ApplicationArea = All; }
                field(Blocked; Rec.Blocked) { ApplicationArea = All; }
            }
        }
    }
}
