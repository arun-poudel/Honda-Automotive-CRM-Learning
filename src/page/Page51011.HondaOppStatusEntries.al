page 51011 "Honda Opp. Status Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Honda Opp. Status Entry";
    Caption = 'Honda Opp. Status Entries';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; }
                field("Opportunity No."; Rec."Opportunity No.") { ApplicationArea = All; }
                field("Old CRM Stage"; Rec."Old CRM Stage") { ApplicationArea = All; }
                field("New CRM Stage"; Rec."New CRM Stage") { ApplicationArea = All; }
                field("Old Result"; Rec."Old Result") { ApplicationArea = All; }
                field("New Result"; Rec."New Result") { ApplicationArea = All; }
                field("Change Date-Time"; Rec."Change Date-Time") { ApplicationArea = All; }
                field("Changed By"; Rec."Changed By") { ApplicationArea = All; }
                field(Reason; Rec.Reason) { ApplicationArea = All; }
                field(Comment; Rec.Comment) { ApplicationArea = All; }
                field("Sales Cycle Code"; Rec."Sales Cycle Code") { ApplicationArea = All; }
                field("Sales Cycle Stage"; Rec."Sales Cycle Stage") { ApplicationArea = All; }
            }
        }
    }
}
