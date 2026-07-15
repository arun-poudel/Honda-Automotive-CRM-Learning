page 51000 "Honda Dealer Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Honda Dealer";
    Caption = 'Honda Dealer Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code) { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Dealer Type"; Rec."Dealer Type") { ApplicationArea = All; }
            }
            group(AddressCommunication)
            {
                Caption = 'Address and Communication';
                field(Address; Rec.Address) { ApplicationArea = All; }
                field("Address 2"; Rec."Address 2") { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field(Province; Rec.Province) { ApplicationArea = All; }
                field(District; Rec.District) { ApplicationArea = All; }
                field(Municipality; Rec.Municipality) { ApplicationArea = All; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field(Email; Rec.Email) { ApplicationArea = All; }
                field("Contact Person"; Rec."Contact Person") { ApplicationArea = All; }
            }
            group(Assignment)
            {
                Caption = 'Assignment';
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field(Active; Rec.Active) { ApplicationArea = All; }
                field(Blocked; Rec.Blocked) { ApplicationArea = All; }
                field("Last Date Modified"; Rec."Last Date Modified") { ApplicationArea = All; }
            }
        }
    }
}
