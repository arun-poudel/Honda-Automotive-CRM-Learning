page 51009 "Honda Contact Activities Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Honda CRM Activity";
    Caption = 'Honda Contact Activities';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Activity Type"; Rec."Activity Type") { ApplicationArea = All; }
                field(Subject; Rec.Subject) { ApplicationArea = All; }
                field("Due Date"; Rec."Due Date") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
            }
        }
    }
}
