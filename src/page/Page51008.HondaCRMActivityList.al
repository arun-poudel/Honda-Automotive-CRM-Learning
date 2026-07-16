page 51008 "Honda CRM Activity List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Honda CRM Activity";
    CardPageId = "Honda CRM Activity Card";
    Caption = 'Honda CRM Activity List';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; Editable = false; }
                field("Contact No."; Rec."Contact No.") { ApplicationArea = All; }
                field("Opportunity No."; Rec."Opportunity No.") { ApplicationArea = All; }
                field("Activity Type"; Rec."Activity Type") { ApplicationArea = All; }
                field(Subject; Rec.Subject) { ApplicationArea = All; }
                field("Activity Date"; Rec."Activity Date") { ApplicationArea = All; }
                field("Due Date"; Rec."Due Date") { ApplicationArea = All; }
                field("Due Time"; Rec."Due Time") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; Editable = false; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field("Dealer Code"; Rec."Dealer Code") { ApplicationArea = All; }
            }
        }
    }
}
