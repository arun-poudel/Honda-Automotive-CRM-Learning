page 51001 "Honda Dealer List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Honda Dealer";
    CardPageId = "Honda Dealer Card";
    Caption = 'Honda Dealer List';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code) { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Dealer Type"; Rec."Dealer Type") { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field(Province; Rec.Province) { ApplicationArea = All; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field(Active; Rec.Active) { ApplicationArea = All; }
                field(Blocked; Rec.Blocked) { ApplicationArea = All; }
            }
        }
    }
}
